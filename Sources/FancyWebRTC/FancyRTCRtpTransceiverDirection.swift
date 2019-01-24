//
//  FancyRTCRtpTransceiverDirection.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc(FancyRTCRtpTransceiverDirection)
public enum FancyRTCRtpTransceiverDirection: Int, RawRepresentable {
    case INACTIVE
    case RECV_ONLY
    case SEND_ONLY
    case SEND_RECV
    
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .INACTIVE:
            return "inactive"
        case .RECV_ONLY:
            return "recvonly"
        case .SEND_ONLY:
            return "sendonly"
        case .SEND_RECV:
            return "sendrecv"
        }
    }
    
    public init(rawValue: RawValue) {
        switch rawValue {
        case "inactive":
            self = .INACTIVE
        case "recvonly":
            self = .RECV_ONLY
        case "sendonly":
            self = .SEND_ONLY
        case "sendrecv":
            self = .SEND_RECV
        default:
            self = .INACTIVE
        }
    }
    
    public init(direction: RTCRtpTransceiverDirection) {
        switch direction {
        case .inactive:
            self = .INACTIVE
        case .recvOnly:
            self = .RECV_ONLY
        case .sendOnly:
            self = .SEND_ONLY
        case .sendRecv:
            self = .SEND_RECV
        }
    }
    
    public var rtcValue: RTCRtpTransceiverDirection{
        switch self {
        case .INACTIVE:
            return RTCRtpTransceiverDirection.inactive
        case .RECV_ONLY:
            return RTCRtpTransceiverDirection.recvOnly
        case .SEND_ONLY:
            return RTCRtpTransceiverDirection.sendOnly
        case .SEND_RECV:
            return RTCRtpTransceiverDirection.sendRecv
        }
    }
}
