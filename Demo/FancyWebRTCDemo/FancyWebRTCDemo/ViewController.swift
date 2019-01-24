//
//  ViewController.swift
//  FancyWebRTCDemo
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import UIKit
import FancyWebRTC
import SocketIO
import WebRTC
class ViewController: UIViewController , FancyWebRTCClientDelegate{
    func webRTCClientOnRemoveStream(client: Any, stream: Any) {
        
    }
    
    func webRTCClientDataChannelStateChanged(client: FancyWebRTC, name: String, type: Any) {
        
    }
    
    func webRTCClientDataChannelMessageType(client: FancyWebRTC, name: String, data: String, type: WebRTCDataChannelMessageType) {
        
    }
    
    func webRTCClientStartCallWithSdp(client: Any, sdp: Any) {
        
    }
    
    func webRTCClientDidReceiveStream(client: FancyWebRTC, stream: RTCMediaStream) {
        
    }
    
    func webRTCClientDidRemoveStream(client: FancyWebRTC, stream: RTCMediaStream) {
        
    }
    
    func webRTCClientDidReceiveError(client: Any, error: NSError) {
        
    }
    
    func webRTCClientOnRenegotiationNeeded(client: FancyWebRTC) {
        
    }
    
    func webRTCClientDidGenerateIceCandidate(client: FancyWebRTC, iceCandidate: Any) {
        
    }
    
    func webRTCClientOnIceCandidatesRemoved(client: FancyWebRTC, candidates: Array<Any>) {
        
    }
    
    func webRTCClientOnIceConnectionChange(client: FancyWebRTC, connectionState: RTCIceConnectionState) {
        
    }
    
    func webRTCClientOnIceConnectionReceivingChange(client: FancyWebRTC, change: Bool) {
        
    }
    
    func webRTCClientOnIceGatheringChange(client: FancyWebRTC, gatheringState: Any) {
        
    }
    
    func webRTCClientOnSignalingChange(client: FancyWebRTC, signalingState: Any) {
        
    }
    
    func webRTCClientOnCameraSwitchDone(client: FancyWebRTC, done: Bool) {
        
    }
    
    func webRTCClientOnCameraSwitchError(client: FancyWebRTC, error: String) {
        
    }
    
    @IBOutlet weak var local: UIView!
    @IBOutlet weak var remote: UIView!
    var localView: FancyWebRTCView?
    var remoteView: FancyWebRTCView?
    var webRTC: FancyWebRTC?
    var capturer: WebRTCCapturer?
    var manager: SocketManager = SocketManager(socketURL: URL.init(string: "http://192.168.0.10:3001")!)
    var me = UUID().uuidString
    var remoteTrack: RTCVideoTrack?
    var localStream: RTCMediaStream?
    var mirror = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localView = FancyWebRTCView.initWithFrame(localView?.bounds ?? CGRect.zero)
        remoteView = FancyWebRTCView.initWithFrame(remoteView?.bounds ?? CGRect.zero)
        var options:[String: Any] = [:]
        options["enableAudio"] = true
        options["enableVideo"] = true
        
        webRTC = FancyWebRTC.initWith(options: options)
        
        webRTC?.setListener(listener: self)
        
        if !FancyWebRTC.hasPermissions() {
            FancyWebRTC.requestPermissions { (error) in
                if(error != nil){
                    print("Loggin -> has permission " + error!)
                }
            }
        }
    }


}

