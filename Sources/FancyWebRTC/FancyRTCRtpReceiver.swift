//
//  FancyRTCRtpReceiver.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objcMembers public class FancyRTCRtpReceiver: NSObject {
    private var _rtpReceiver: RTCRtpReceiver
    
    public init(rtpReceiver: RTCRtpReceiver ) {
        self._rtpReceiver = rtpReceiver
    }
    
    
    
    public var rtpReceiver:RTCRtpReceiver {
        get{
            return _rtpReceiver
        }
    }
}
