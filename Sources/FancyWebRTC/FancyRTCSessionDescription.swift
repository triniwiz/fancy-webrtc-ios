//
//  FancyRTCSessionDescription.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCSessionDescription: NSObject {
    
    private var _sessionDescription: RTCSessionDescription
    
    public init(type: FancyRTCSdpType, description: String) {
        _sessionDescription = RTCSessionDescription(type: type.rtcValue, sdp: description)
    }
    
    public init(sdp: RTCSessionDescription) {
        _sessionDescription = sdp
    }
    
    class FancySDP: Encodable, Decodable {
        var type: String
        var sdp: String
        public init(type: FancyRTCSdpType, sdp: String){
            self.type = type.rawValue
            self.sdp = sdp;
        }
    }
    
    public var type: FancyRTCSdpType {
        get{
            return FancyRTCSdpType(sdpType: sessionDescription.type)
        }
    }
    
    public var sdp: String {
        get{
            return sessionDescription.sdp
        }
    }
    
    public func toJSON() -> String  {
        let encoder = JSONEncoder()
        let sdp = FancySDP(type: type, sdp: self.sdp)
        do {
            let json = try encoder.encode(sdp)
            return String(data: json, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    @objc static func fromRTCSessionDescription(sdp: RTCSessionDescription) -> FancyRTCSessionDescription {
        return FancyRTCSessionDescription(type: FancyRTCSdpType.init(sdpType: sdp.type), description: sdp.sdp)
    }
    
    public var sessionDescription: RTCSessionDescription {
        get{
            return _sessionDescription
        }
    }
    
}
