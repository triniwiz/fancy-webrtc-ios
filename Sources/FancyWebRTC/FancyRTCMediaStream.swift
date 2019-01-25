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
    
    @objc public init(mediaStream: RTCMediaStream) {
        self._mediaStream = mediaStream
    }
    
    @objc public var getId: String{
        get{
            return self._mediaStream.streamId
        }
    }
    
    @objc public var videoTracks: Array<FancyRTCVideoTrack> {
        get{
            let tracks: Array<RTCVideoTrack> = _mediaStream.videoTracks;
            var fancyVideoTracks: Array<FancyRTCVideoTrack> = []
            for track in tracks {
                fancyVideoTracks.append(FancyRTCVideoTrack(track));
            }
            return fancyVideoTracks;
        }
    }
    
    @objc  public var audioTracks: Array<FancyRTCAudioTrack> {
        get{
            let tracks: Array<RTCAudioTrack> = _mediaStream.audioTracks
            var fancyAudioTracks: Array<FancyRTCAudioTrack> = []
            for track in tracks {
                fancyAudioTracks.append(FancyRTCAudioTrack(track));
            }
            return fancyAudioTracks;
        }
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
        get{
            print("testing", _mediaStream, self._mediaStream)
            return self._mediaStream
        }
    }
}
