    //
    //  FancyRTCDTMFSender.swift
    //  FancyWebRTC
    //
    //  Created by Osei Fortune on 1/23/19.
    //  Copyright © 2019 Osei Fortune. All rights reserved.
    //
    
    import Foundation
    import WebRTC
    
    @objc(FancyRTCDTMFSender)
    @objcMembers public class FancyRTCDTMFSender: NSObject {
        private var _sender: RTCDtmfSender
        
        public init(sender: RTCDtmfSender) {
            _sender = sender;
        }
        
        public var toneBuffer: String {
            get{
                return _sender.remainingTones()
            }
        }
        
        public var sender: RTCDtmfSender {
            get {
                return _sender
            }
        }
        
        public func dispose() {
            
        }
        
        @objc public func insertDTMF(tones: String, duration: Double, interToneGap: Double) {
            _sender.insertDtmf(tones, duration: duration, interToneGap: interToneGap)
        }
    }
