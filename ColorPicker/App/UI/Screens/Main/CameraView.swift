//
//  CameraView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 13.11.24.
//

import SwiftUI

// TODO: Otimizations!!!

struct CameraView: UIViewControllerRepresentable {
    @Binding var centerColor: UIColor

    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CameraViewControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func didCaptureCenterColor(_ color: UIColor) {
            parent.centerColor = color
        }
    }
}

import AVFoundation
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureCenterColor(_ color: UIColor)
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
    weak var delegate: CameraViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high

        guard let videoDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))

        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let image = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }

        // Get the color at the center of the pixel buffer and calculate its screen position
        let point = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
        let color = self.colorAtPixel(point: point, in: image)

        DispatchQueue.main.async {
            self.delegate?.didCaptureCenterColor(color)
        }
    }

    func colorAtPixel(point: CGPoint, in image: UIImage) -> UIColor {
        guard let cgImage = image.cgImage,
              CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height).contains(point) else {
            return UIColor.clear
        }

        // Define properties for the 1x1 pixel context
        let pointX = Int(point.x)
        let pointY = Int(point.y)
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel
        let bitsPerComponent = 8
        var pixelData: [UInt8] = [0, 0, 0, 0]
        
        // Create the context for a 1x1 pixel
        guard let context = CGContext(data: &pixelData,
                                      width: 1,
                                      height: 1,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
            return UIColor.clear
        }
        
        // Draw the selected pixel into the context
        context.setBlendMode(.copy)
        context.translateBy(x: -CGFloat(pointX), y: -CGFloat(pointY))
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // Retrieve color values and normalize to [0, 1]
        let red = CGFloat(pixelData[0]) / 255.0
        let green = CGFloat(pixelData[1]) / 255.0
        let blue = CGFloat(pixelData[2]) / 255.0
        let alpha = CGFloat(pixelData[3]) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }

        // Lock the pixel buffer's base address
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }
        
        // Create a CIImage from the pixel buffer
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        // Create a temporary CIContext
        let context = CIContext()
        
        // Convert the CIImage to a CGImage
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        
        // Create and return a UIImage from the CGImage
        return UIImage(cgImage: cgImage)
    }
}

