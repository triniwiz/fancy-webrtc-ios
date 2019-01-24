//
//  FancyRTCDataChannelEvent.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCDataChannelEvent: NSObject {
    public var _channel:FancyRTCDataChannel
    
    public init(channel: FancyRTCDataChannel) {
        _channel = channel;
    }
    
    public var channel: FancyRTCDataChannel {
        get {
            return _channel
        }
    }
}
