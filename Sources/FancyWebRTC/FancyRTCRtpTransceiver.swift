//
//  FancyRTCRtpTransceiver.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objcMembers public class FancyRTCRtpTransceiver: NSObject{
    private var _rtpTransceiver: RTCRtpTransceiver
    
    
    init(rtpTransceiver: RTCRtpTransceiver) {
        _rtpTransceiver = rtpTransceiver
    }
    
    
    public var rtpTransceiver: RTCRtpTransceiver {
        get {
            return _rtpTransceiver
        }
    }
    
    public var direction: FancyRTCRtpTransceiverDirection {
        get{
            return FancyRTCRtpTransceiverDirection.init(direction: _rtpTransceiver.direction)
        }
        set{
            _rtpTransceiver.direction = newValue.rtcValue
        }
    }
    
    
    public var currentDirection: FancyRTCRtpTransceiverDirection? {
        get{
            let direction: UnsafeMutablePointer<RTCRtpTransceiverDirection> = UnsafeMutablePointer(bitPattern: RTCRtpTransceiverDirection.inactive.rawValue)!
            let got = _rtpTransceiver.currentDirection(direction)
            if(!got){
                return nil
            }
            return FancyRTCRtpTransceiverDirection(direction: direction.pointee)
        }
    }
    
    public var mid:  String {
        get{
            return _rtpTransceiver.mid
        }
    }
    
    public var receiver:  FancyRTCRtpReceiver {
        get{
            return FancyRTCRtpReceiver(rtpReceiver: _rtpTransceiver.receiver)
        }
    }
    
    public var sender: FancyRTCRtpSender {
        get{
            return FancyRTCRtpSender(sender: _rtpTransceiver.sender)
        }
    }
    
    
    public var stopped:  Bool {
        get{
            return _rtpTransceiver.isStopped
        }
    }
    
    
    public func stop() {
        _rtpTransceiver.stop()
    }
}
