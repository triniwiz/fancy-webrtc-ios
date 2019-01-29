//
//   FancyRTCRtpParameters.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCRtpParameters)
@objcMembers public class  FancyRTCRtpParameters:NSObject {
    private var _parameters: RTCRtpParameters
    
    public init(parameters: RTCRtpParameters) {
        _parameters = parameters
    }
    
    public var parameters: RTCRtpParameters{
        get {
            return _parameters
        }
    }
}
