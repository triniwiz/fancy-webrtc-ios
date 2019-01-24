//
//  FancyRTCSdpSemantics .swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/22/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc public enum FancyRTCSdpSemantics: Int, RawRepresentable {
    case PLAN_B
    case UNIFIED_PLAN
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .PLAN_B:
            return "plan-b"
        case .UNIFIED_PLAN:
            return "unified-plan"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "plan-b":
            self = .PLAN_B
        case "unified-plan":
            self = .UNIFIED_PLAN
        default:
            self = .PLAN_B
        }
    }
    
    public init?(sdpSemantics: RTCSdpSemantics) {
        switch sdpSemantics {
        case .planB:
            self = .PLAN_B
        case .unifiedPlan:
            self = .UNIFIED_PLAN
        default:
            self = .PLAN_B
        }
    }
    
    public var rtcValue: RTCSdpSemantics {
        switch self {
        case .PLAN_B:
            return RTCSdpSemantics.planB
        case .UNIFIED_PLAN:
            return RTCSdpSemantics.unifiedPlan
        }
    }
}
