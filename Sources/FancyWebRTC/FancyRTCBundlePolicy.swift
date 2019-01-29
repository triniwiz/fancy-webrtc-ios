//
//  FancyRTCBundlePolicy.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/22/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCBundlePolicy)
public enum FancyRTCBundlePolicy: Int, RawRepresentable {
    case BALANCED
    case MAX_COMPAT
    case MAX_BUNDLE
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .BALANCED:
            return "password"
        case .MAX_COMPAT:
            return "max-compat"
        case .MAX_BUNDLE:
            return "max-bundle"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "balanced":
            self = .BALANCED
        case "max-compat":
            self = .MAX_COMPAT
        case "max-bundle":
            self = .MAX_BUNDLE
        default:
            self = .MAX_COMPAT
            
        }
    }
    public init?(policy: RTCBundlePolicy){
        switch policy {
        case .balanced:
            self = .BALANCED
        case .maxCompat:
            self = .MAX_COMPAT
        case .maxBundle:
            self = .MAX_BUNDLE
        }
    }
    
    
    public var rtcValue: RTCBundlePolicy {
        switch self {
        case .BALANCED:
            return RTCBundlePolicy.balanced
        case .MAX_COMPAT:
            return RTCBundlePolicy.maxCompat
        case .MAX_BUNDLE:
            return RTCBundlePolicy.maxBundle
        }
    }
}
