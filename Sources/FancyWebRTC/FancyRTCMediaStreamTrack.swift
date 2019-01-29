//
//  FancyRTCMediaStreamTrack.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCMediaStreamTrack)
@objcMembers public class FancyRTCMediaStreamTrack: NSObject {
    private var _mediaStreamTrack: RTCMediaStreamTrack
    
    
    @nonobjc public init(track: RTCMediaStreamTrack){
        self._mediaStreamTrack = track
    }
    
    public var id: String {
        get{
            return (_mediaStreamTrack ).trackId
        }
    }
    
    public var enabled: Bool {
        get{
            return (_mediaStreamTrack ).isEnabled
        }
        set{
            (_mediaStreamTrack ).isEnabled = newValue
        }
    }
    
    public var kind: String {
        get {
            return (_mediaStreamTrack ).kind
        }
    }
    
    public var mute: Bool {
        get{
            return (_mediaStreamTrack ).isEnabled
        }
    }
    
    public func dispose() {
        
    }
    
    public var  readyState: String {
        get {
            switch ((_mediaStreamTrack ).readyState) {
            case .live:
                return "live"
            default:
                return "ended"
            }
        }
    }
    
    public var mediaStreamTrack: RTCMediaStreamTrack {
        get {
            return (_mediaStreamTrack )
        }
    }
}
