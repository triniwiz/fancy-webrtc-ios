//
//  FancyRTCMediaStream.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCMediaStream: NSObject {
    private var _mediaStream: RTCMediaStream
    
    public init(mediaStream: RTCMediaStream) {
        _mediaStream = mediaStream
    }
    
    public var getId: String{
        get{
            return _mediaStream.streamId
        }
    }
    
    public var videoTracks: Array<FancyRTCVideoTrack> {
        get{
            let tracks: Array<RTCVideoTrack> = stream.videoTracks;
            var fancyVideoTracks: Array<FancyRTCVideoTrack> = []
            for track in tracks {
                fancyVideoTracks.append(FancyRTCVideoTrack(track:track));
            }
            return fancyVideoTracks;
        }
    }
    
    public var audioTracks: Array<FancyRTCAudioTrack> {
        get{
            let tracks: Array<RTCAudioTrack> = _mediaStream.audioTracks
            var fancyAudioTracks: Array<FancyRTCAudioTrack> = []
            for track in tracks {
                fancyAudioTracks.append(FancyRTCAudioTrack(track:track));
            }
            return fancyAudioTracks;
        }
    }
    
    public func addTrack(track: FancyRTCVideoTrack) {
        _mediaStream.addVideoTrack(track.videoTrack)
    }
    
    public func addTrack(track: FancyRTCAudioTrack) {
        _mediaStream.addAudioTrack(track.audioTrack)
    }
    
    public func removeTrack(track: FancyRTCVideoTrack) {
        _mediaStream.removeVideoTrack(track.videoTrack)
    }
    
    public func removeTrack(track: FancyRTCAudioTrack) {
        _mediaStream.removeAudioTrack(track.audioTrack)
    }
    
    public var stream: RTCMediaStream {
        get{
            return _mediaStream
        }
    }
}
