//
//  FancyRTCIceTransportPolicy.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/22/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc(FancyRTCIceTransportPolicy)
public enum FancyRTCIceTransportPolicy: Int,RawRepresentable {
    case ALL
    case PUBLIC
    case RELAY
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .ALL:
            return "all"
        case .PUBLIC:
            return "public"
        case .RELAY:
            return "relay"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "all":
            self = .ALL
        case "public":
            self = .PUBLIC
        case "relay":
            self = .RELAY
        default:
            self = .ALL
        }
    }
    
    public init?(policy : RTCIceTransportPolicy) {
        switch policy {
        case .all:
            self = .ALL
        case .noHost:
            self = .PUBLIC
        case .relay:
            self = .RELAY
        default:
            self = .ALL
        }
    }
    
    public var rtcValue: RTCIceTransportPolicy {
        switch self {
        case .ALL:
            return RTCIceTransportPolicy.all
        case .PUBLIC:
            return RTCIceTransportPolicy.noHost
        case .RELAY:
            return RTCIceTransportPolicy.relay
        }
    }
}
