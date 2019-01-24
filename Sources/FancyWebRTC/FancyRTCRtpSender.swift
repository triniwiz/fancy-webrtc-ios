//
//  FancyRTCRtpSender.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCRtpSender: NSObject {
    private var _sender: RTCRtpSender
    
    public init(sender:RTCRtpSender) {
        _sender = sender
    }
    
    public var sender:RTCRtpSender {
        get{
            return _sender
        }
    }
    
    public var dtmf: FancyRTCDTMFSender? {
        get {
            if(_sender.dtmfSender != nil){
                return FancyRTCDTMFSender(sender: _sender.dtmfSender!)
            }
            return nil
        }
    }
    
    public var id: String {
        get{
            return _sender.senderId
        }
    }
    
    public func dispose() {
        
    }
    
    public var track: FancyRTCMediaStreamTrack? {
        get {
            if(sender.track != nil){
                return FancyRTCMediaStreamTrack(track: _sender.track!)
            }
            return nil
        }
    }
    
    public var parameters: FancyRTCRtpParameters {
        get {
            return FancyRTCRtpParameters(parameters: _sender.parameters)
        }
    }
    
    public func replaceTrack(track: FancyRTCMediaStreamTrack) {
        _sender.track = track.mediaStreamTrack
    }
}
