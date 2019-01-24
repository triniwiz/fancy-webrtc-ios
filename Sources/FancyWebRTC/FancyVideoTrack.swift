//
//  FancyVideoTrack.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC


@objcMembers public class FancyRTCVideoTrack: FancyRTCMediaStreamTrack {
    private var _videoTrack: RTCVideoTrack
    init(track: RTCVideoTrack) {
        _videoTrack = track
        super.init(track: track)
    }
    
    public var videoTrack: RTCVideoTrack {
        get{
            return _videoTrack
        }
    }
}
