//
//  FancyRTCConfiguration.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCConfiguration)
@objcMembers public class FancyRTCConfiguration: NSObject {
    private var _configuration: RTCConfiguration
    public var peerIdentity: String {
        set {
            
        }
        get{
            return ""
        }
    }
    public var bundlePolicy: FancyRTCBundlePolicy  {
        get {
            return FancyRTCBundlePolicy(policy: configuration.bundlePolicy)!
        }
        set {
            switch newValue {
            case .BALANCED:
                configuration.bundlePolicy = .balanced
            case .MAX_BUNDLE:
                configuration.bundlePolicy = .maxBundle
            case .MAX_COMPAT:
                configuration.bundlePolicy = .balanced
            }
        }
    }
    
    public var sdpSemantics: FancyRTCSdpSemantics {
        get {
            return FancyRTCSdpSemantics(sdpSemantics: configuration.sdpSemantics)!
        }
        set {
            switch newValue {
            case .UNIFIED_PLAN:
                configuration.sdpSemantics = .unifiedPlan
            case .PLAN_B:
                configuration.sdpSemantics = .planB
            }
        }
    }
    public var iceCandidatePoolSize: Int32 {
        get {
            return configuration.iceCandidatePoolSize
        }
        set {
            configuration.iceCandidatePoolSize = newValue
        }
    }
    public var iceTransportPolicy: FancyRTCIceTransportPolicy {
        get {
            return FancyRTCIceTransportPolicy(policy: configuration.iceTransportPolicy)!
        }
        set {
            switch newValue {
            case .ALL:
                configuration.iceTransportPolicy  = .all
            case .PUBLIC:
                configuration.iceTransportPolicy  = .all
            case .RELAY:
                configuration.iceTransportPolicy  = .relay
            }
        }
    }
    public var rtcpMuxPolicy: FancyRTCRtcpMuxPolicy {
        get {
            return FancyRTCRtcpMuxPolicy(policy: configuration.rtcpMuxPolicy)!
        }
        set {
            switch newValue {
            case .NEGOTIATE:
                configuration.rtcpMuxPolicy = .negotiate
            case .REQUIRE:
                configuration.rtcpMuxPolicy = .require
            }
        }
    }
    public var iceServers: Array<FancyRTCIceServer> {
        get {
            var servers: Array<FancyRTCIceServer> = []
            for iceServer: RTCIceServer in configuration.iceServers {
                servers.append(FancyRTCIceServer(iceServer: iceServer))
            }
            return servers
        }
        set {
            for server in newValue{
                configuration.iceServers.append(server.iceServer())
            }
        }
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
        
        /*
         configuration.tcpCandidatePolicy = .disabled
         configuration.bundlePolicy = .maxBundle
         configuration.rtcpMuxPolicy = .require
         configuration.continualGatheringPolicy = .gatherContinually
         configuration.keyType = .ECDSA
         */
        
    }
    
    public init(iceServers:Array<FancyRTCIceServer>){
        _configuration = RTCConfiguration()
        
        super.init()
        
        for server in iceServers{
            configuration.iceServers.append(server.iceServer())
        }
        
        // configuration.enableDtlsSrtp = true;
        // configuration.enableRtpDataChannel = true;
        /*
         configuration.tcpCandidatePolicy = .disabled
         configuration.bundlePolicy = .maxBundle
         configuration.rtcpMuxPolicy = .require
         configuration.continualGatheringPolicy = .gatherContinually
         configuration.keyType = .ECDSA
         */
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
