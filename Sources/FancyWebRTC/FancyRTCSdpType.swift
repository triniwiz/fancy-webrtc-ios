//
//  FancyRTCSdpType.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import  WebRTC

@objc public enum FancyRTCSdpType: Int, RawRepresentable, Encodable, Decodable {
    case ANSWER
    case OFFER
    case PRANSWER
    case ROLLBACK
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .ANSWER:
            return "answer"
        case .OFFER:
            return "offer"
        case .PRANSWER:
            return "pranswer"
        case .ROLLBACK:
            return "rollback"
        }
    }
    
    public init(rawValue: RawValue) {
        switch rawValue {
        case "answer":
            self = .ANSWER
        case "offer":
            self = .OFFER
        case "pranswer":
            self = .PRANSWER
        case "rollback":
            self = .ROLLBACK
        default:
           self = .ANSWER
        }
    }
    
    public init(sdpType: RTCSdpType) {
        switch sdpType {
        case .answer:
            self = .ANSWER
        case .offer:
            self = .OFFER
        case .prAnswer:
            self = .PRANSWER
        }
    }
    
    public var rtcValue: RTCSdpType{
        switch self {
        case .ANSWER:
            return RTCSdpType.answer
        case .OFFER:
            return RTCSdpType.offer
        case .PRANSWER:
            return RTCSdpType.prAnswer
        case .ROLLBACK:
           return RTCSdpType.answer
        }
    }
    
}
