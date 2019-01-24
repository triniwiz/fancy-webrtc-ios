//
//  FancyRTCConfiguration.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCConfiguration: NSObject {
    private var _configuration: RTCConfiguration
    public var bundlePolicy: FancyRTCBundlePolicy  {
        get {
            return FancyRTCBundlePolicy(policy: configuration.bundlePolicy)!
        }
        set {}
    }
    
    public var sdpSemantics: FancyRTCSdpSemantics {
        get {
            return FancyRTCSdpSemantics(sdpSemantics: configuration.sdpSemantics)!
        }
        set {}
    }
    public var iceCandidatePoolSize: Int32 {
        get {
            return configuration.iceCandidatePoolSize
        }
        set {}
    }
    public var iceTransportPolicy: FancyRTCIceTransportPolicy {
        get {
            return FancyRTCIceTransportPolicy(policy: configuration.iceTransportPolicy)!
        }
        set {}
    }
    public var rtcpMuxPolicy: FancyRTCRtcpMuxPolicy {
        get {
            return FancyRTCRtcpMuxPolicy(policy: configuration.rtcpMuxPolicy)!
        }
        set {}
    }
    public var iceServers: Array<FancyRTCIceServer> {
        get {
            var servers: Array<FancyRTCIceServer> = []
            for iceServer: RTCIceServer in configuration.iceServers {
                servers.append(FancyRTCIceServer(iceServer: iceServer))
            }
            return servers
        }
        set {}
    }
    public var configuration: RTCConfiguration {
        get{
            return _configuration
        }
    }
    public override init() {
        _configuration = RTCConfiguration()
        super.init()
        let defaultIceServers = ["stun:stun.l.google.com:19302",
                                 "stun:stun1.l.google.com:19302",
                                 "stun:stun2.l.google.com:19302",
                                 "stun:stun3.l.google.com:19302",
                                 "stun:stun4.l.google.com:19302"]
        for url in defaultIceServers {
            configuration.iceServers.append(RTCIceServer(urlStrings: [url]))
        }
        
        // configuration.enableDtlsSrtp = true;
        // configuration.enableRtpDataChannel = true;
        
        configuration.tcpCandidatePolicy = .disabled
        configuration.bundlePolicy = .maxBundle
        configuration.rtcpMuxPolicy = .require
        configuration.continualGatheringPolicy = .gatherContinually
        configuration.keyType = .ECDSA
        
    }
    
    public init(options: NSDictionary) {
        _configuration = RTCConfiguration()
        super.init()
        if(options["bundlePolicy"] != nil){
            let policy = options["bundlePolicy"] as? FancyRTCBundlePolicy ?? FancyRTCBundlePolicy.BALANCED
            configuration.bundlePolicy  = policy.rtcValue
        }
        if(options["sdpSemantics"] != nil){
            let semantics = options["sdpSemantics"] as? FancyRTCSdpSemantics ?? FancyRTCSdpSemantics.PLAN_B
            configuration.sdpSemantics = semantics.rtcValue
        }
        if(options["iceCandidatePoolSize"] != nil){
            configuration.iceCandidatePoolSize = options["iceCandidatePoolSize"] as? Int32 ?? 0
        }
        if(options["iceTransportPolicy"] != nil){
            let policy = options["iceTransportPolicy"] as? FancyRTCIceTransportPolicy ?? FancyRTCIceTransportPolicy.ALL
            configuration.iceTransportPolicy = policy.rtcValue
        }
        
        if(options["rtcpMuxPolicy"] != nil){
            let policy = options["rtcpMuxPolicy"] as? FancyRTCRtcpMuxPolicy ?? FancyRTCRtcpMuxPolicy.REQUIRE
            configuration.rtcpMuxPolicy = policy.rtcValue
        }
        
        if(options["iceServers"] != nil){
            let servers = options["iceServers"] as? Array<FancyRTCIceServer> ?? []
            for server in servers {
                configuration.iceServers.append(server.iceServer())
            }
        }
    }
    
    
}
