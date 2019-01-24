//
//  FancyRTCDataChannelInit.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC
@objc(FancyRTCDataChannelInit)
public class FancyRTCDataChannelInit: NSObject, Decodable, Encodable {
    private var _ordered: Bool = true;
    private var _maxPacketLifeTime: Int32
    private var _maxRetransmits: Int32
    private var _protocol: String = "";
    private var _negotiated: Bool = false;
    private var _id: Int32
    
    public override init() {
        let _init = RTCDataChannelConfiguration()
        _id = _init.channelId
        _maxRetransmits = _init.maxRetransmits
        _maxPacketLifeTime = _init.maxPacketLifeTime
        _protocol = _init.protocol
    }
    
    public var channelInit: RTCDataChannelConfiguration {
        let _init = RTCDataChannelConfiguration()
        _init.channelId = _id;
        _init.isOrdered = _ordered;
        _init.maxRetransmits = _maxRetransmits
        _init.maxPacketLifeTime = _maxPacketLifeTime
        _init.protocol = _protocol;
        return _init
    }
    
    public var id: Int32 {
        get{
            return _id
        }
    }
    
    public var maxPacketLifeTime: Int32 {
        get {
            return _maxPacketLifeTime
        }
    }
    
    public var maxRetransmits:Int32 {
        get {
            return _maxRetransmits
        }
    }
    
    public var `protocol`: String {
        get{
            return _protocol
        }
    }
    
    public func toJSON()-> String {
        let encoder = JSONEncoder()
        do{
            let json = try encoder.encode(self)
            return String(data: json, encoding: .utf8) ?? ""
        }catch{
            return ""
        }
    }
}
