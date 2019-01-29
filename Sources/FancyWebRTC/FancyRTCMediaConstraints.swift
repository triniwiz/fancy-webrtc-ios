//
//  FancyRTCMediaConstraints.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCMediaConstraints)
@objcMembers public class FancyRTCMediaConstraints: NSObject, Encodable, Decodable {
    
    @objc public class FancyRTCKeyValue: NSObject, Encodable, Decodable {
        var key: String
        var value: String
        @objc public init(key: String, value: String) {
            self.key = key;
            self.value = value;
        }
    }
    
    class MediaConstraints: Encodable, Decodable{
        public var  mandatory: Array<FancyRTCKeyValue>
        public var optional: Array<FancyRTCKeyValue>
        init(mandatory: Array<FancyRTCKeyValue>, optional: Array<FancyRTCKeyValue>) {
            self.mandatory = mandatory
            self.optional = optional
        }
    }
    
    public var  mandatory: Array<FancyRTCKeyValue> = []
    public var optional: Array<FancyRTCKeyValue>  = []
    
    public override init() {}
    
    public func toJSON() -> String{
        let encoder = JSONEncoder()
        do{
            let constraints = MediaConstraints(mandatory: self.mandatory, optional: self.optional)
            let json = try encoder.encode(constraints)
            return String(data: json, encoding: .utf8) ?? ""
        }catch{
            return ""
        }
    }
    
    public var mediaConstraints: RTCMediaConstraints {
        get{
            var _mandatory:[String:String] = [:]
            var _optional:[String:String] = [:]
            for keyValue in mandatory{
                _mandatory[keyValue.key] = keyValue.value
            }
            for keyValue in optional{
                _optional[keyValue.key] = keyValue.value
            }
            return RTCMediaConstraints(mandatoryConstraints: _mandatory, optionalConstraints: _optional)
        }
    }
}
