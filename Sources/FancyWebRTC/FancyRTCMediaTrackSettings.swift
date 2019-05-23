//
//  FancyRTCMediaTrackSettings.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 5/23/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation

@objc(FancyRTCMediaTrackSettings)
@objcMembers public class FancyRTCMediaTrackSettings: NSObject {
    var id: String
    var type: String
    public init(id: String, type: String) {
        self.id = id
        self.type = type
    }
    
    private var capture: FancyRTCMediaDevices.FancyCapturer? {
        get {
            return FancyRTCMediaDevices.videoTrackcapturerMap[id]
        }
    }
    
    private var isVideo: Bool {
        return type.elementsEqual("video")
    }
    
    public var width: Int {
        get{
            if isVideo && capture != nil {
                return capture!.width
            }
            return 0
        }
    }
    
    public var height: Int{
        get{
            if isVideo && capture != nil {
                return capture!.height
            }
            return 0
        }
    }
    
    public var frameRate: Int {
        get{
            if isVideo && capture != nil {
                return capture!.frameRate
            }
            return 0
        }
    }
    
    public var aspectRatio: Int {
        get {
            if isVideo && capture != nil {
                return capture!.aspectRatio
            }
            return 0
        }
    }
    
    public var facingMode: String {
        get {
            if isVideo && capture != nil {
                return capture!.position
            }
            return ""
        }
    }
}
