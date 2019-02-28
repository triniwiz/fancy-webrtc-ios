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
@objcMembers public class FancyWebRTCView: UIView, RTCVideoViewDelegate{
    
    public func videoView(_ videoView: RTCVideoRenderer, didChangeVideoSize size: CGSize) {
        
    }
    
    private var videoView: RTCEAGLVideoView?
    private var mirror: Bool = false
    private var track: RTCVideoTrack?
    private var mediaStream: FancyRTCMediaStream?
    
    public convenience init(){
        self.init(frame: .zero)
        self.videoView = RTCEAGLVideoView.init(frame: frame)
        if(self.videoView != nil){
            self.videoView!.delegate = self
            self.videoView!.frame = self.bounds
            self.addSubview(videoView!)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.videoView = RTCEAGLVideoView.init(frame: frame)
        if(self.videoView != nil){
            self.videoView!.delegate = self
            self.videoView!.frame = self.bounds
            self.videoView?.setSize(self.bounds.size)
            self.addSubview(videoView!)
        }
    }
    
    public func setSize(size: CGSize){
        self.videoView?.setSize(size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.videoView = RTCEAGLVideoView.init(coder: aDecoder)
        if(self.videoView != nil){
            self.videoView!.delegate = self
            self.videoView!.frame = self.bounds
            self.addSubview(videoView!)
        }
    }
    
    @objc(FancyWebRTCViewScaling)
    public enum Scaling: Int {
        case fit
        case fill
        case none
    }
    
    
    public func setScaling(scale: Scaling){
        switch scale {
        case .fill:
            self.contentMode = .scaleAspectFill
            self.videoView?.contentMode = .scaleAspectFill
        case .fit:
            self.contentMode = .scaleAspectFit
            self.videoView?.contentMode = .scaleAspectFit
        default:
            self.contentMode = .scaleToFill
            self.videoView?.contentMode = .scaleToFill
        }
    }
    
    public override func layoutSubviews() {
        if(self.videoView != nil){
            self.videoView!.frame = self.bounds
        }
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
    
    private func setupTrack(){
        if (track != nil && self.videoView != nil) {
            track!.add(self.videoView!)
        }
    }
    
    public func setVideoTrack(track: RTCVideoTrack?){
        self.track = track
        self.setupTrack()
    }
    
    
    private func setupStream(){
        if (mediaStream != nil && mediaStream!.videoTracks.count > 0) {
            let track = mediaStream!.videoTracks.first
            if (self.track != nil) {
                if(self.videoView != nil){
                    self.track?.remove(self.videoView!)
                }
                self.track = nil
            }
            self.track = track?.videoTrack
            if(self.track != nil && self.videoView != nil){
                self.track?.add(self.videoView!)
            }
        }
    }
    
    public func setSrcObject(stream: FancyRTCMediaStream) {
        mediaStream = stream
        setupStream()
    }
    
    public func setSrcObject(with rtcStream: RTCMediaStream) {
        mediaStream = FancyRTCMediaStream(mediaStream: rtcStream)
        setupStream()
        
    }
    
    public func setSrcObject(withFancy rtcStreamTrack: FancyRTCMediaStreamTrack) {
        if(rtcStreamTrack.mediaStreamTrack is RTCVideoTrack) {
            if (self.track != nil) {
                if(self.videoView != nil){
                    self.track?.remove(self.videoView!)
                }
                self.track = nil
            }
            self.track = rtcStreamTrack.mediaStreamTrack as? RTCVideoTrack
            if(self.track != nil && self.videoView != nil){
                self.track?.add(self.videoView!)
            }
        }
    }
    
    
    public func setSrcObject(withRtc mediaStreamTrack: RTCMediaStreamTrack) {
        if(mediaStreamTrack is RTCVideoTrack) {
            if (self.track != nil) {
                if(self.videoView != nil){
                    self.track?.remove(self.videoView!)
                }
                self.track = nil
            }
            self.track = mediaStreamTrack as? RTCVideoTrack
            if(self.track != nil && self.videoView != nil){
                self.track?.add(self.videoView!)
            }
        }
    }
}
