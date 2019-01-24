//
//  FancyUtils.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation

@objcMembers public class FancyUtils: NSObject {
    public static func getUUID() -> String {
    return UUID().uuidString
    }
    
    public static func getLongUUID() -> Int64 {
        return 0
    }
}
