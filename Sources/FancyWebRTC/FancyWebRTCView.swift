//
//  FancyWebRTCView.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyWebRTCView: RTCEAGLVideoView {
    private var mirror: Bool = false
    private var track: RTCVideoTrack?
    private var mediaStream: RTCMediaStream?
    
    
    public static func initWithFrame(_ frame: CGRect )-> FancyWebRTCView {
        return FancyWebRTCView(frame: frame)
    }
    
    public func setMirror(mirror: Bool){
        if (self.mirror) {
            self.mirror = true
            self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
        } else {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            self.mirror = false;
        }
    }
    
    public func setVideoTrack(track: RTCVideoTrack?){
        self.track = track;
        if (track != nil) {
            track!.add(self);
        }
    }
    
    
    public func setSrcObject(stream: FancyRTCMediaStream) {
        mediaStream = stream.stream
        if (mediaStream != nil && mediaStream!.videoTracks.count > 0) {
            let track = mediaStream!.videoTracks.first
            if (self.track != nil) {
                self.track = nil
            }
            self.track = track
            if(self.track != nil){
                self.track?.add(self)
            }
        }
    }
    
    public func setSrcObject(with rtcStream: RTCMediaStream) {
        mediaStream = rtcStream
        if (mediaStream != nil && mediaStream!.videoTracks.count > 0) {
            let track = mediaStream!.videoTracks.first
            if (self.track != nil) {
                self.track = nil
            }
            self.track = track;
            if(self.track != nil){
                self.track?.add(self)
            }
        }
    }
}
