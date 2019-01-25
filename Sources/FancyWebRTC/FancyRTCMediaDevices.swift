//
//  FancyRTCMediaDevices.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/24/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objcMembers public class FancyRTCMediaDevices: NSObject {
    static var factory: RTCPeerConnectionFactory?
    private static let DEFAULT_HEIGHT = 480;
    private static let DEFAULT_WIDTH = 640;
    private static let DEFAULT_FPS = 15;
    
    
    enum ErrorDomain: String {
        case videoPermissionDenied = "Video permission denied"
        case audioPermissionDenied = "Audio permission denied"
    }
    
   @objc static func getUserMedia(constraints:FancyRTCMediaStreamConstraints,listener: ((FancyRTCMediaStream?, String?) -> Void)){
        let factory = FancyRTCMediaDevices.factory!
        let streamId = UUID().uuidString
        let localStream = factory.mediaStream(withStreamId: streamId)
        
        
        
        if (!AVCaptureState.isVideoDisabled()) {
            let videoSource = factory.videoSource()
            let capturer = RTCCameraVideoCapturer(delegate: videoSource)
            let videoTrackId = UUID().uuidString
            
            let videoTrack = factory.videoTrack(with: videoSource, trackId: videoTrackId)
            videoTrack.isEnabled = true;
            
            
            var useFrontCamera = true
            if (constraints.videoConstraints != nil && constraints.videoConstraints!["facingMode"] != nil) {
                let facingMode = constraints.videoConstraints!["facingMode"] as? String
                useFrontCamera = facingMode == nil || facingMode != "environment"
            }
            
            
            var width: Any?
            var height: Any?
            var minWidth = -1
            var minHeight = -1
            var idealWidth = -1
            var idealHeight = -1
            var maxWidth = -1
            var maxHeight = -1
            var frameRate = DEFAULT_FPS;
            if (constraints.videoConstraints != nil && (constraints.videoConstraints!["width"] != nil) && (constraints.videoConstraints!["height"] != nil)) {
                width = constraints.videoConstraints!["width"]
                height = constraints.videoConstraints!["height"]
                let rate = constraints.videoConstraints!["frameRate"] as? Int
                frameRate = rate ?? DEFAULT_FPS
                
                if (width != nil && type(of: width) ==  type(of: NSDictionary.self)) {
                    var widthMap = width as! [AnyHashable:AnyHashable]
                    if ((widthMap["min"]) != nil) {
                        minWidth = widthMap["min"] as! Int
                    }
                    if ((widthMap["ideal"]) != nil) {
                        idealWidth = widthMap["ideal"] as! Int
                    }
                    if ((widthMap["max"]) != nil) {
                        maxWidth = widthMap["max"] as! Int
                    }
                }
                if (height != nil && type(of: height) == type(of: NSDictionary.self)) {
                    var heightMap = height as! [AnyHashable:AnyHashable]
                    if ((heightMap["min"]) != nil) {
                        minHeight = heightMap["min"] as! Int
                    }
                    if ((heightMap["ideal"]) != nil) {
                        idealHeight = heightMap["ideal"] as! Int
                    }
                    if ((heightMap["max"]) != nil) {
                        maxHeight = heightMap["max"] as! Int
                    }
                }
            }
            
            
            let devices = RTCCameraVideoCapturer.captureDevices();
            var selectedDevice: AVCaptureDevice?
            let pos = useFrontCamera
                ? AVCaptureDevice.Position.front
                : AVCaptureDevice.Position.back
            for device in devices {
                if(device.position == pos){
                    selectedDevice = device
                    break
                }
            }
            
            var w: Int
            var h: Int
            
            if (width != nil && type(of: width) == type(of: Int.self)) {
                w = width as! Int
            } else if (maxWidth > -1) {
                w = maxWidth
            } else if (idealWidth > -1) {
                w = idealWidth
            } else if (minWidth > -1) {
                w = minWidth
            } else {
                w = DEFAULT_WIDTH
            }
            
            if (height != nil && type(of: height) == type(of: Int.self)) {
                h =  height as! Int
            } else if (maxHeight > -1) {
                h = maxHeight
            } else if (idealHeight > -1) {
                h = idealHeight
            } else if (minHeight > -1) {
                h = minHeight
            } else {
                h = DEFAULT_HEIGHT
            }
            
            
            
            let format = selectFormatForDevice(device: selectedDevice!, width: Int32(w), height: Int32(h), capturer: capturer);
            let fps = selectFpsForFormat(format: format);
            
            capturer.startCapture(with: selectedDevice!, format: format, fps: Int(fps))
            
            localStream.addVideoTrack(videoTrack);
        } else {
            listener(nil,ErrorDomain.videoPermissionDenied.rawValue)
            return
        }
        
        if (!AVCaptureState.isAudioDisabled()) {
            let audioTrackId = UUID().uuidString
            let audioSource = factory.audioSource(with: RTCMediaConstraints.init(mandatoryConstraints: nil, optionalConstraints: nil))
            let audioTrack = factory.audioTrack(with: audioSource, trackId: audioTrackId)
            audioTrack.isEnabled = true
            localStream.addAudioTrack(audioTrack)
        } else {
            listener(nil,ErrorDomain.audioPermissionDenied.rawValue)
            return
        }
        
        listener(FancyRTCMediaStream.init(mediaStream: localStream),nil)
        
    }
    
   @objc private static func selectFormatForDevice(
        device: AVCaptureDevice,
        width: Int32,
        height: Int32,
        capturer: RTCCameraVideoCapturer
        )-> AVCaptureDevice.Format {
        
        let targetHeight = height
        let targetWidth = width
        
        var selectedFormat: AVCaptureDevice.Format?;
        var currentDiff = Int32.max;
        
        let supportedFormats = RTCCameraVideoCapturer.supportedFormats(for: device)
        
        for format in supportedFormats {
            let dimension: CMVideoDimensions = CMVideoFormatDescriptionGetDimensions(
                format.formatDescription
            )
            let diff =
                abs(targetWidth - dimension.width) +
                    abs(targetHeight - dimension.height)
            let pixelFormat = CMFormatDescriptionGetMediaSubType(format.formatDescription);
            if (diff < currentDiff) {
                selectedFormat = format;
                currentDiff = diff;
            }else if(diff == currentDiff && pixelFormat == capturer.preferredOutputPixelFormat()){
                selectedFormat = format;
            }
        }
        
        
        return selectedFormat!
    }
    
   @objc private static func selectFpsForFormat(format: AVCaptureDevice.Format) -> Double {
        var maxFrameRate = 0.0
        for fpsRange in format.videoSupportedFrameRateRanges{
            maxFrameRate = fmax(maxFrameRate, fpsRange.maxFrameRate);
        }
        return maxFrameRate;
    }
    
}
