//
//  FancyRTCMediaTrackConstraints.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 2/21/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation

@objc(FancyRTCMediaTrackConstraints)
@objcMembers public class FancyRTCMediaTrackConstraints: NSObject {
    
    private var constraints: [String: Any]
    
    public init(constraints: [String: Any]?) {
        if (constraints != nil) {
            self.constraints = constraints!;
        } else {
            self.constraints = [:]
        }
    }
    
    
    public var facingMode: String? {
        set {
            self.constraints["facingMode"]  = newValue
        }
        get {
            return self.constraints["facingMode"] as? String
        }
    }
}
