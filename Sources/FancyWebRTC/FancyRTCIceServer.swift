//
//  FancyRTCIceServer.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC


@objcMembers public class FancyRTCIceServer: NSObject {
    
    private var _urls: Array<String>
    private var _credential: String?
    private var _credentialType: FancyRTCIceCredentialType?
    private var _username: String?
    private var _server: RTCIceServer?
    
    
    public init(url: String) {
        _urls = [url];
    }
    
    public init(url: String, username: String?,credential: String?) {
        _urls = [url]
        _username = username
        _credential = credential
    }
    
    public init(urls: [String]) {
        _urls = urls;
    }
    
    public init(urls:[String], username: String?, credential: String?) {
        _urls = urls;
        _username = username;
        _credential = credential;
    }
    
    public init(iceServer: RTCIceServer){
        _server = iceServer
        _urls = iceServer.urlStrings
        _credential = iceServer.credential
        _username = iceServer.username
    }
    
    public func toWebRtc() -> RTCIceServer{
        return iceServer()
    }
    
    public func iceServer() -> RTCIceServer{
        return RTCIceServer(urlStrings: _urls, username: _username, credential: _credential)
    }
    
    public var credentialType: FancyRTCIceCredentialType? {
        get {
            return _credentialType
        }
        set {
            _credentialType = newValue
        }
    }
    
    public var urls :[String] {
        get {
            return _urls
        }
        
        set{
            _urls = newValue
        }
    }
    
    public var username:String? {
        get{
            return _username
        }
        set {
            _username = newValue
        }
    }
    
    public var credential: String? {
        get{
            return _credential
        }
        set {
            _credential = newValue
        }
    }
    
    
}
