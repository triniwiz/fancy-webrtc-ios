//
//  FancyRTCIceCandidate.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCIceCandidate)
@objcMembers public class FancyRTCIceCandidate: NSObject{
    
    private var _candidate: String
    private var _sdpMid: String?
    private var _sdpMLineIndex: Int32
    private var _usernameFragment: String
    private var _serverUrl: String?
    private var _iceCandidate: RTCIceCandidate
    
    class IceCandidate: Encodable, Decodable {
        public var candidate: String
        public var sdpMid: String?
        public var sdpMLineIndex: Int32
        public  var usernameFragment: String
        public var serverUrl: String?
        init(candidate: String,sdpMid: String?,sdpMLineIndex: Int32,usernameFragment: String,serverUrl: String?) {
            self.candidate = candidate
            self.sdpMid = sdpMid
            self.sdpMLineIndex = sdpMLineIndex
            self.usernameFragment = usernameFragment
            self.serverUrl = serverUrl
        }
    }
   
    public init(sdp: String, sdpMid: String?, sdpMLineIndex: Int32) {
        _candidate = sdp;
        _sdpMid = sdpMid;
        _sdpMLineIndex = sdpMLineIndex;
        _usernameFragment = ""
        _serverUrl = ""
        _iceCandidate = RTCIceCandidate(sdp: sdp, sdpMLineIndex: sdpMLineIndex, sdpMid: sdpMid)
    }
    
    public init (candidate: RTCIceCandidate) {
        _candidate = candidate.sdp
        _sdpMid = candidate.sdpMid
        _sdpMLineIndex = candidate.sdpMLineIndex
        _usernameFragment = ""
        _serverUrl = candidate.serverUrl
        _iceCandidate = candidate
    }
    
    public var candidate: String {
        get{
            return _candidate
        }
        set{
            _candidate = newValue
        }
    }
    
    public var sdp: String {
        get{
            return candidate
        }
        set {
            candidate = newValue
        }
    }
    
    public var sdpMid: String? {
        get {
            return _sdpMid
        }
        set {
            _sdpMid = newValue
        }
    }
    
    
    public var sdpMLineIndex: Int32 {
        get{
            return _sdpMLineIndex
        }
        set {
            _sdpMLineIndex = newValue
        }
    }
    
    
    public var usernameFragment: String{
        get{
            return _usernameFragment
        }
        set {
            _usernameFragment = newValue
        }
    }
    
    
    public var serverUrl:String? {
        get{
            return _serverUrl
        }
        set {
            _serverUrl = newValue
        }
    }
    
    public func toJSON() -> String {
        let encoder = JSONEncoder()
        let candidate = IceCandidate(candidate: self.candidate, sdpMid: self.sdpMid, sdpMLineIndex: self.sdpMLineIndex, usernameFragment: self.usernameFragment, serverUrl: self.serverUrl)
        do{
            let json = try encoder.encode(candidate)
            return String(data: json, encoding: .utf8) ?? ""
        }catch{
            return ""
        }
    }
    
    
    public var iceCandidate: RTCIceCandidate{
        get{
            return _iceCandidate
        }
    }
}
