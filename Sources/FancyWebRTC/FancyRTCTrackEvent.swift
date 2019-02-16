//
//  FancyRTCTrackEvent.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCTrackEvent)
@objcMembers public class FancyRTCTrackEvent: NSObject {
    private var _receiver: FancyRTCRtpReceiver
    private var _streams: Array<FancyRTCMediaStream>?
    private var _mediaTrack: FancyRTCMediaStreamTrack?
    private var _transceiver: FancyRTCRtpTransceiver?
    
    public init(receiver: FancyRTCRtpReceiver, streams: Array<FancyRTCMediaStream>?, mediaTrack: FancyRTCMediaStreamTrack?, transceiver: FancyRTCRtpTransceiver?) {
        self._receiver = receiver
        self._streams = streams
        self._mediaTrack = mediaTrack
        self._transceiver = transceiver
    }
    
    
    public var mediaTrack: FancyRTCMediaStreamTrack?{
        get {
            return _mediaTrack
        }
    }
    
    public var receiver: FancyRTCRtpReceiver {
        get{
            return _receiver
        }
    }
    
    public var transceiver: FancyRTCRtpTransceiver? {
        get{
            return _transceiver
        }
    }
    
   
    public var streams:Array<FancyRTCMediaStream>? {
        get{
            return _streams
        }
    }
}
