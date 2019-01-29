//
//  FancyRTCRtcpMuxPolicy.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/22/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc(FancyRTCRtcpMuxPolicy)
public enum FancyRTCRtcpMuxPolicy: Int, RawRepresentable {
    case NEGOTIATE
    case REQUIRE
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .NEGOTIATE:
            return "negotiate"
        case .REQUIRE:
            return "require"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "negotiate":
            self = .NEGOTIATE
        case "require":
            self = .REQUIRE
        default:
            self = .REQUIRE
        }
    }
    
    public init?(policy: RTCRtcpMuxPolicy) {
        switch policy {
        case .negotiate:
            self = .NEGOTIATE
        case .require:
            self = .REQUIRE
        default:
            self = .REQUIRE
        }
    }
    
    public var rtcValue: RTCRtcpMuxPolicy{
        switch self {
        case .NEGOTIATE:
            return RTCRtcpMuxPolicy.negotiate
        case .REQUIRE:
            return RTCRtcpMuxPolicy.require
        }
    }
}
