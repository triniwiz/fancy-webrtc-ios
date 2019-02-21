//
//  FancyVideoTrack.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCVideoTrack)
@objcMembers public class FancyRTCVideoTrack: FancyRTCMediaStreamTrack {
    private var _videoTrack: RTCVideoTrack
    
    public init(_ track: RTCVideoTrack) {
        _videoTrack = track
        super.init(track: track)
    }
    
    public var videoTrack: RTCVideoTrack {
        get{
            return _videoTrack
        }
    }
    
    public func applyConstraints(constraints: FancyRTCMediaTrackConstraints, listener: @escaping (_ error : String?) -> ()) {
        if (constraints.facingMode != nil) {
            let facingMode = constraints.facingMode;
            let useFrontCamera = facingMode == nil || !facingMode!.elementsEqual("environment")
            let capturer = FancyRTCMediaDevices.videoTrackcapturerMap[_videoTrack.trackId]
            if (capturer != nil) {
                if (!capturer!.position.elementsEqual(constraints.facingMode!)) {
                    if (capturer?.capturer != nil) {
                        
                        let devices = RTCCameraVideoCapturer.captureDevices()
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
                        
                        let w = capturer!.width
                        let h = capturer!.height
                        
                        let format = FancyRTCMediaDevices.selectFormatForDevice(device: selectedDevice!, width: Int32(w), height: Int32(h), capturer: capturer!.capturer)
                        let fps = FancyRTCMediaDevices.selectFpsForFormat(format: format)
                        
                        capturer?.capturer.startCapture(with: selectedDevice!, format: format, fps: Int(fps)) { (e: Error?) in
                            if(e != nil){
                                DispatchQueue.main.async {
                                    listener(e!.localizedDescription)
                                }
                            }else{
                                capturer?.position = useFrontCamera ? "user":"environment"
                                FancyRTCMediaDevices.videoTrackcapturerMap[self._videoTrack.trackId] = capturer
                                DispatchQueue.main.async {
                                    listener(nil)
                                }
                            }
                        }
                        
                        
                    }
                }
                
            }
        }
        
    }
}
