//
//  FancyRTCPeerConnectionState.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc public enum FancyRTCPeerConnectionState: Int, RawRepresentable {
    case NEW
    case CONNECTING
    case CONNECTED
    case DISCONNECTED
    case FAILED
    case CLOSED
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .NEW:
            return "new"
        case .CONNECTING:
            return "connecting"
        case .CONNECTED:
            return "connected"
        case .DISCONNECTED:
            return "disconnected"
        case .FAILED:
            return "failed"
        case .CLOSED:
            return "closed"
        }
    }
    
    public init(rawValue: RawValue) {
        switch rawValue {
        case "new":
            self = .NEW
        case "connecting":
            self = .CONNECTING
        case "connected":
            self = .CONNECTED
        case "disconnected":
            self = .DISCONNECTED
        case "failed":
            self = .FAILED
        case "closed":
            self = .CLOSED
        default:
            self = .NEW
        }
    }
    
    public init(state: RTCPeerConnectionState) {
        switch state {
        case .new:
            self = .NEW
        case .connecting:
            self = .CONNECTING
        case .connected:
            self = .CONNECTED
        case .disconnected:
            self = .DISCONNECTED
        case .failed:
            self = .FAILED
        case .closed:
            self = .CLOSED
        }
    }
    
    public var rtcValue:  RTCPeerConnectionState {
        switch self {
        case .NEW:
            return  RTCPeerConnectionState.new
        case .CONNECTING:
            return  RTCPeerConnectionState.connecting
        case .CONNECTED:
            return  RTCPeerConnectionState.connected
        case .DISCONNECTED:
            return  RTCPeerConnectionState.disconnected
        case .FAILED:
            return  RTCPeerConnectionState.failed
        case .CLOSED:
            return  RTCPeerConnectionState.closed
        }
    }
}
