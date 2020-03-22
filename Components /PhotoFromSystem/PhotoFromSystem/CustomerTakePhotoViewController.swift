//
//  CustomerTakePhotoViewController.swift
//  PhotoFromSystem
//
//  Created by FanYu on 25/1/2016.
//  Copyright © 2016 FanYu. All rights reserved.
//

import UIKit
import AVFoundation

// Failed 

class CustomerTakePhotoViewController: UIViewController {

    var capturedImage: UIImageView!
    var previewView: UIView!
    var captureButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {

        config()
    }
    
    private func setup() {
        // self 
        self.view.backgroundColor = UIColor.whiteColor()
        
        // button 
        captureButton = UIButton(frame: CGRect(x: 0, y: 64, width: 100, height: 30))
        captureButton.backgroundColor = UIColor.greenColor()
        captureButton.addTarget(self, action: #selector(CustomerTakePhotoViewController.captureTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(captureButton)
        
        //image 
        capturedImage = UIImageView(frame: CGRect(x: 0, y: 120, width: 200, height: 200))
        capturedImage.backgroundColor = UIColor.redColor()
        self.view.addSubview(capturedImage)
        
        // preview 
        previewView = UIView(frame: CGRect(x: 0, y: 400, width: 200, height: 200))
        self.view.addSubview(previewView)
    }
    
    func config() {
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPresetPhoto
        
        // input
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession?.addInput(input)
        } catch let error as NSError {
            print(error)
        }
        
        // output
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        captureSession?.addOutput(stillImageOutput)
        
        // live preview
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewView.layer.addSublayer(previewLayer!)
        previewLayer?.frame = previewView.bounds
    }
}


extension CustomerTakePhotoViewController {
    func captureTapped(sender: UIButton) {
        print("tapped")
        // Data Connection
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProviderCreateWithCFData(imageData)
                let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                self.capturedImage.image = image
                
                print("video connection")
            })
        }
    }
}

extension CustomerTakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
