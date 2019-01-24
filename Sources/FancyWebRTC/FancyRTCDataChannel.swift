//
//  FancyRTCDataChannel.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCDataChannel: NSObject {
    private var _dataChannel: RTCDataChannel
    
    public init (channel: RTCDataChannel){
        _dataChannel = channel;
    }
}
