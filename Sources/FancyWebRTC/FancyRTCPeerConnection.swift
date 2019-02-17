//
//  FancyRTCPeerConnection.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import WebRTC

@objc(FancyRTCPeerConnection)
@objcMembers public class FancyRTCPeerConnection: NSObject , RTCPeerConnectionDelegate {
    var _connection: RTCPeerConnection?
    var configuration: FancyRTCConfiguration
    static let factory: RTCPeerConnectionFactory = RTCPeerConnectionFactory(
        encoderFactory: RTCDefaultVideoEncoderFactory()
        , decoderFactory: RTCDefaultVideoDecoderFactory())
    
    public override init() {
        configuration = FancyRTCConfiguration()
        _connection = FancyRTCPeerConnection.factory.peerConnection(with: configuration.configuration, constraints: RTCMediaConstraints(mandatoryConstraints: [
            "OfferToReceiveVideo": "true","OfferToReceiveAudio":"true"], optionalConstraints: nil), delegate: nil)
        super.init()
        _connection!.delegate = self
    }
    
    public init(config: FancyRTCConfiguration) {
        configuration = config
        _connection = FancyRTCPeerConnection.factory.peerConnection(with: configuration.configuration, constraints: RTCMediaConstraints(mandatoryConstraints: [
            "OfferToReceiveVideo": "true","OfferToReceiveAudio":"true"], optionalConstraints: nil), delegate: nil)
        super.init()
        _connection!.delegate = self
    }
    
    public var localDescription: FancyRTCSessionDescription? {
        get {
            if(connection.localDescription != nil){
                return FancyRTCSessionDescription(sdp: connection.localDescription!)
            }
            return nil
        }
    }
    
    public func localDescription(sdp: FancyRTCSessionDescription, listener: @escaping (String?) -> Void){
        connection.setLocalDescription(sdp.sessionDescription) { (error) in
            if(error != nil){
                listener(error!.localizedDescription)
            }else{
                listener(nil)
            }
        }
    }
    
    public var remoteDescription: FancyRTCSessionDescription? {
        get {
            if(connection.remoteDescription != nil){
                return FancyRTCSessionDescription(sdp: connection.remoteDescription!)
            }
            return nil
        }
    }
    
    public func remoteDescription(sdp: FancyRTCSessionDescription, listener: @escaping (String?) -> Void){
        connection.setRemoteDescription(sdp.sessionDescription) { (error) in
            if(error != nil){
                listener(error!.localizedDescription)
            }else{
                listener(nil)
            }
        }
    }
    
    public var connectionState: FancyRTCPeerConnectionState {
        get {
            return FancyRTCPeerConnectionState(state: connection.connectionState)
        }
    }
    
    
    private var onConnectionStateChangeListener: ((() -> Void)?)
    
    public func onConnectionStateChange(_ listener : @escaping () -> Void){
        onConnectionStateChangeListener = listener
    }
    
    private var onTrackListener: (((FancyRTCTrackEvent) -> ())?)
    
    public func onTrack(_ listener :@escaping (FancyRTCTrackEvent) -> Void){
        onTrackListener = listener
    }
    
    private var onRemoveTrackListener: ((()-> Void)?)
    
    public func onRemoveTrack(_ listener : @escaping () -> Void) {
        onRemoveTrackListener = listener
    }
    
    private var onRemoveStreamListener:(((_ stream:FancyRTCMediaStream) -> Void)?)
    
    public func onRemoveStream(_ listener: @escaping (FancyRTCMediaStream) -> Void) {
        onRemoveStreamListener = listener
    }
    
    
    private var onIceGatheringStateChangeListener:((() -> Void)?)
    
    
    public func onIceGatheringStateChange(_ listener:  @escaping () -> Void ) {
        onIceGatheringStateChangeListener = listener
    }
    
    
    private var onAddStreamListener:(((_ stream: FancyRTCMediaStream)->Void)?)
    
    public func onAddStream(_ listener : @escaping (FancyRTCMediaStream)-> Void) {
        onAddStreamListener = listener
    }
    
    
    private var onNegotiationNeededListener:((()->Void)?)
    
    public func onNegotiationNeeded(_ listener : @escaping ()->Void) {
        onNegotiationNeededListener = listener
    }
    
    private var onSignalingStateChangeListener:((()->Void)?)
    
    public func onSignalingStateChange(_ listener :@escaping ()->Void) {
        onSignalingStateChangeListener = listener
    }
    
    private var onIceCandidateListener:(((_ candidate: FancyRTCIceCandidate)->Void)?)
    
    public func onIceCandidate(_ listener :@escaping (FancyRTCIceCandidate)->Void) {
        onIceCandidateListener = listener
    }
    
    
    private var onDataChannelListener:(((_ event: FancyRTCDataChannelEvent)->Void)?)
    
    public func onDataChannel(_ listener :@escaping (FancyRTCDataChannelEvent)->Void) {
        onDataChannelListener = listener
    }
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didStartReceivingOn transceiver: RTCRtpTransceiver) {
        if(onTrackListener != nil){
            onTrackListener!(FancyRTCTrackEvent(receiver:FancyRTCRtpReceiver(rtpReceiver:  transceiver.receiver), streams: nil, mediaTrack: (transceiver.receiver.track != nil ? FancyRTCMediaStreamTrack(track: transceiver.receiver.track!): nil), transceiver:FancyRTCRtpTransceiver(rtpTransceiver: transceiver)))
        }
    }
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd rtpReceiver: RTCRtpReceiver, streams mediaStreams: [RTCMediaStream]) {
        if(peerConnection.configuration.sdpSemantics == .planB){
            if (onTrackListener != nil) {
                var list: Array<FancyRTCMediaStream> = []
                for stream in mediaStreams {
                    list.append(FancyRTCMediaStream(mediaStream:stream));
                }
                
                onTrackListener!(FancyRTCTrackEvent(receiver:FancyRTCRtpReceiver(rtpReceiver:  rtpReceiver), streams: list, mediaTrack: (rtpReceiver.track != nil ? FancyRTCMediaStreamTrack(track: rtpReceiver.track!): nil), transceiver: nil))
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCPeerConnectionState) {
        if(onConnectionStateChangeListener != nil){
            onConnectionStateChangeListener!()
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        if(onSignalingStateChangeListener != nil){
            onSignalingStateChangeListener!()
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        if(onAddStreamListener != nil){
            onAddStreamListener!(FancyRTCMediaStream(mediaStream: stream))
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        if(onRemoveStreamListener != nil){
            onRemoveStreamListener!(FancyRTCMediaStream(mediaStream: stream))
        }
    }
    
    public func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        if(onNegotiationNeededListener != nil){
            onNegotiationNeededListener!()
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        if(onConnectionStateChangeListener != nil){
            onConnectionStateChangeListener!()
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        if(onIceGatheringStateChangeListener != nil){
            onIceGatheringStateChangeListener!()
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        if (onIceCandidateListener != nil) {
            onIceCandidateListener!(FancyRTCIceCandidate(candidate: candidate));
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        if (onDataChannelListener != nil) {
            onDataChannelListener!(FancyRTCDataChannelEvent(channel: FancyRTCDataChannel(channel: dataChannel)));
        }
    }
    
    public var defaultIceServers: Array<FancyRTCIceServer> {
        get{
            var list: Array<FancyRTCIceServer> = []
            let defaultIceServers = [
                "stun:stun.l.google.com:19302",
                "stun:stun1.l.google.com:19302",
                "stun:stun2.l.google.com:19302",
                "stun:stun3.l.google.com:19302",
                "stun:stun4.l.google.com:19302"
            ]
            
            for server in defaultIceServers {
                list.append(FancyRTCIceServer(url: server));
            }
            return list;
        }
    }
    
    public func addIceCandidate(candidate: FancyRTCIceCandidate) {
        connection.add(candidate.iceCandidate)
    }
    
    public func addTrack(track: FancyRTCMediaStreamTrack, streamIds: [String]) {
        connection.add(track.mediaStreamTrack, streamIds: streamIds)
    }
    
    public func close() {
        connection.close()
    }
    
    
    public func createDataChannel(label: String, channelInit: FancyRTCDataChannelInit) -> FancyRTCDataChannel? {
        let channel = connection.dataChannel(forLabel: label, configuration: channelInit.channelInit)
        if(channel != nil){
            return FancyRTCDataChannel(channel: channel!)
        }
        return nil
    }
    
    public func dispose() {
        
    }
    
    
    public func createAnswer(mediaConstraints: FancyRTCMediaConstraints, listener: @escaping (FancyRTCSessionDescription?, String?) -> Void) {
        connection.answer(for: mediaConstraints.mediaConstraints) { (sdp, error) in
            if(error != nil){
                listener(nil,error?.localizedDescription)
            }else{
                listener(FancyRTCSessionDescription(sdp: sdp!),nil)
            }
        }
    }
    
    
    public func createOffer(mediaConstraints: FancyRTCMediaConstraints, listener: @escaping (FancyRTCSessionDescription?, String?) -> Void) {
        connection.offer(for: mediaConstraints.mediaConstraints) { (sdp, error) in
            if(error != nil){
                listener(nil,error?.localizedDescription)
            }else{
                listener(FancyRTCSessionDescription(sdp: sdp!),nil)
            }
        }
    }
    
    public var connection: RTCPeerConnection {
        get {
            return _connection!
        }
    }
}

