//
//  FancyRTCMediaStream.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc public class FancyRTCMediaStream: NSObject {
    
    private var _mediaStream: RTCMediaStream
    
    public init(mediaStream: RTCMediaStream) {
        _mediaStream = mediaStream
        NSLog("FancyRTCMediaStream %@", mediaStream)
    }
    
   @objc public var getId: String{
        NSLog("FancyRTCMediaStream getId %@", _mediaStream.streamId)
        return _mediaStream.streamId
    }
    
   @objc public var id: String{
        NSLog("FancyRTCMediaStream getId %@", _mediaStream.streamId)
        return _mediaStream.streamId
    }
    
    @objc public var videoTracks: Array<FancyRTCVideoTrack> {
        let tracks: Array<RTCVideoTrack> = _mediaStream.videoTracks;
        var fancyVideoTracks: Array<FancyRTCVideoTrack> = []
        for track in tracks {
            fancyVideoTracks.append(FancyRTCVideoTrack(track));
        }
        NSLog("FancyRTCMediaStream videoTracks %@", fancyVideoTracks)
        return fancyVideoTracks;
    }
    
   @objc public var audioTracks: Array<FancyRTCAudioTrack> {
        let tracks: Array<RTCAudioTrack> = _mediaStream.audioTracks
        var fancyAudioTracks: Array<FancyRTCAudioTrack> = []
        for track in tracks {
            fancyAudioTracks.append(FancyRTCAudioTrack(track));
        }
        NSLog("FancyRTCMediaStream audioTracks %@", fancyAudioTracks)
        return fancyAudioTracks;
    }
    
   @objc public func addTrack(video track: FancyRTCVideoTrack) {
        _mediaStream.addVideoTrack(track.videoTrack)
    }
    
   @objc public func addTrack(audio track: FancyRTCAudioTrack) {
        _mediaStream.addAudioTrack(track.audioTrack)
    }
    
   @objc public func removeTrack(video track: FancyRTCVideoTrack) {
        _mediaStream.removeVideoTrack(track.videoTrack)
    }
    
   @objc public func removeTrack(audio track: FancyRTCAudioTrack) {
        _mediaStream.removeAudioTrack(track.audioTrack)
    }
    
   @objc public var stream: RTCMediaStream {
        NSLog("FancyRTCMediaStream stream %@", _mediaStream)
       return _mediaStream
    }
}
