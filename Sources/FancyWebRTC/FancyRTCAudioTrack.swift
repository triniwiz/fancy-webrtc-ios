//
//  FancyRTCAudioTrack.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCAudioTrack)
@objcMembers public class FancyRTCAudioTrack: FancyRTCMediaStreamTrack {
    private var _audioTrack: RTCAudioTrack
    public init(_ track: RTCAudioTrack) {
        _audioTrack = track
        super.init(track: track)
    }
    
    public var volume: Double{
        set{
            _audioTrack.source.volume = newValue
        }
        get {
           return _audioTrack.source.volume
        }
    }
    
    public var audioTrack: RTCAudioTrack {
        get{
            return _audioTrack
        }
    }
}
