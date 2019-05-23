//
//  FancyRTCMediaStream.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCMediaStream)
@objcMembers public class FancyRTCMediaStream: NSObject {
    
    private var _mediaStream: RTCMediaStream
    
    public init(mediaStream: RTCMediaStream) {
        _mediaStream = mediaStream
    }
    
    public var getId: String{
        return self._mediaStream.streamId
    }
    
    public var id: String{
        return self._mediaStream.streamId
    }
    
    public var videoTracks: Array<FancyRTCVideoTrack> {
        let tracks: Array<RTCVideoTrack> = self._mediaStream.videoTracks;
        var fancyVideoTracks: Array<FancyRTCVideoTrack> = []
        for track in tracks {
            fancyVideoTracks.append(FancyRTCVideoTrack(track));
        }
        return fancyVideoTracks;
    }
    
    public var audioTracks: Array<FancyRTCAudioTrack> {
        let tracks: Array<RTCAudioTrack> = self._mediaStream.audioTracks
        var fancyAudioTracks: Array<FancyRTCAudioTrack> = []
        for track in tracks {
            fancyAudioTracks.append(FancyRTCAudioTrack(track));
        }
        return fancyAudioTracks;
    }
    
    public var tracks: Array<FancyRTCMediaStreamTrack> {
        var tracks:[FancyRTCMediaStreamTrack] = []
        for track in _mediaStream.audioTracks {
            tracks.append(FancyRTCMediaStreamTrack(track: track))
        }
        
        for track in _mediaStream.videoTracks {
            tracks.append(FancyRTCMediaStreamTrack(track: track))
        }
        
        return tracks;
    }
    
    
    
    public func addTrack(withVideo track: FancyRTCVideoTrack) {
        self._mediaStream.addVideoTrack(track.videoTrack)
    }
    
    
    public func addTrack(withAudio track: FancyRTCAudioTrack) {
        self._mediaStream.addAudioTrack(track.audioTrack)
    }
    
    
    public func removeTrack(withVideo track: FancyRTCVideoTrack) {
        self._mediaStream.removeVideoTrack(track.videoTrack)
    }
    
    
    public func removeTrack(withAudio track: FancyRTCAudioTrack) {
        self._mediaStream.removeAudioTrack(track.audioTrack)
    }
    
    public var stream: RTCMediaStream {
        return self._mediaStream
    }
}
