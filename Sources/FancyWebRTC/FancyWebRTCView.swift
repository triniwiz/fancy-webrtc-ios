//
//  FancyWebRTCView.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc(FancyWebRTCView)
public class FancyWebRTCView: RTCEAGLVideoView {
    private var mirror: Bool = false
    private var stream: RTCMediaStream?
    private var track: RTCVideoTrack?
    
   
    @objc public static func initWithFrame(_ frame: CGRect )-> FancyWebRTCView {
        return FancyWebRTCView(frame: frame)
    }
    
    @objc public func setMirror(mirror: Bool){
        if (self.mirror) {
            self.mirror = true
            self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
        } else {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.mirror = false;
        }
    }
    
    @objc public func setVideoTrack(track: RTCVideoTrack?){
        self.track = track;
        if (track != nil) {
            track!.add(self);
        }
    }
    
    @objc public func setStream(stream: RTCMediaStream?){
        self.stream = stream;
        if (stream != nil && (stream!.videoTracks.first != nil)) {
            track = stream!.videoTracks.first
        }
    }
    
    @objc public func setSrcObject(){}
}
