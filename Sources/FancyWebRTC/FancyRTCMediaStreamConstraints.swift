//
//  FancyRTCMediaStreamConstraints.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/24/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCMediaStreamConstraints: NSObject {
    var hasVideoConstraints = false
    var hasAudioConstraints = false
    var isVideoEnabled = false
    var isAudioEnabled = false
    var audioConstraints: [String: Any]?
    var videoConstraints: [String: Any]?
    
    public init(audio: Bool, video: Bool) {
        if (audio) {
            isAudioEnabled = true;
        }
        if (video) {
            isVideoEnabled = true;
        }
    }
    
    public init(videoDict audio: Bool, video: [String: Any]) {
        hasVideoConstraints = true;
        if (audio) {
            isAudioEnabled = true;
        }
        isVideoEnabled = true;
        videoConstraints = video;
    }
    
    public init(audioDict audio:[String: Any], video:Bool) {
        hasAudioConstraints = true;
        isAudioEnabled = true;
        if (video) {
            isVideoEnabled = true;
        }
        audioConstraints = audio;
    }
    
    public init(audioDict audio: [String: Any],videoDict video: [String: Any]) {
        isAudioEnabled = true;
        isVideoEnabled = true;
        audioConstraints = audio;
        videoConstraints = video;
    }
}
