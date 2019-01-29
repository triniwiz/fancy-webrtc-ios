//
//  FancyRTCIceCredentialType.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation

@objc(FancyRTCIceCredentialType)
public enum FancyRTCIceCredentialType:Int, RawRepresentable {
    case PASSWORD
    case TOKEN
    
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .PASSWORD:
            return "password"
        case .TOKEN:
            return "token"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "password":
            self = .PASSWORD
        case "token":
            self = .TOKEN
        default:
            self = .PASSWORD
            
        }
    }
}
