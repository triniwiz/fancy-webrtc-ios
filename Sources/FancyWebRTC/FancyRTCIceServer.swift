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
    
    private var urls: Array<String>
    private var credential: String?
    private var credentialType: FancyRTCIceCredentialType?
    private var username: String?
    private var server: RTCIceServer?
    
    private override init(){
        urls = []
        super.init()
    }
    
    public init(url: String) {
        urls = [url];
    }
    
    public init(url: String, username: String?,credential: String?) {
        urls = [url]
        self.username = username
        self.credential = credential
    }
    
    public init(urls: [String]) {
        self.urls = urls;
    }
    
    public init(urls:[String], username: String?, credential: String?) {
        self.urls = urls;
        self.username = username;
        self.credential = credential;
    }
    
    public init(iceServer: RTCIceServer){
        server = iceServer
        urls = iceServer.urlStrings
        credential = iceServer.credential
        username = iceServer.username
    }
    
    @objc public func toWebRtc() -> RTCIceServer{
        return iceServer()
    }
    
    @objc public func iceServer() -> RTCIceServer{
        return RTCIceServer(urlStrings: self.urls, username: self.username, credential: self.credential)
    }
    
    @objc public func setCredentialType(credentialType: FancyRTCIceCredentialType) {
        self.credentialType = credentialType
    }
    
    public func getCredentialType() -> FancyRTCIceCredentialType? {
        return credentialType
    }
    
    public func setUrls(urls: [String]) {
        self.urls = urls
    }
    
    public func getUrls() -> [String] {
        return urls
    }
    
    public  func getUsername() -> String? {
        return username
    }
    
    public func setUsername(username: String) {
        self.username = username
    }
    
}
