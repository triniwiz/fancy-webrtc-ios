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
@objcMembers public class FancyRTCPeerConnection: NSObject , RTCPeerConnectionDelegate, RTCDataChannelDelegate {
    
    public func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        
    }
    
    public func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        
    }
    
    var _connection: RTCPeerConnection
    var configuration: FancyRTCConfiguration
    
    private static func getSupportedVideoDecoder(factory: RTCDefaultVideoDecoderFactory) -> RTCVideoCodecInfo{
        let supportedCodecs: [RTCVideoCodecInfo] = factory.supportedCodecs()
        if supportedCodecs.contains(RTCVideoCodecInfo.init(name: kRTCVp9CodecName)) {
            return RTCVideoCodecInfo.init(name: kRTCVp9CodecName)
        } else if supportedCodecs.contains(RTCVideoCodecInfo.init(name: kRTCH264CodecName)){
            return RTCVideoCodecInfo.init(name: kRTCH264CodecName)
        } else {
            return RTCVideoCodecInfo.init(name: kRTCVp8CodecName)
        }
    }
    
    private static func getSupportedVideoEncoder(factory: RTCDefaultVideoEncoderFactory) -> RTCVideoCodecInfo{
        let supportedCodecs: [RTCVideoCodecInfo] = RTCDefaultVideoEncoderFactory.supportedCodecs()
        if supportedCodecs.contains(RTCVideoCodecInfo.init(name: kRTCVp9CodecName)) {
            return RTCVideoCodecInfo.init(name: kRTCVp9CodecName)
        } else if supportedCodecs.contains(RTCVideoCodecInfo.init(name: kRTCH264CodecName)){
            return RTCVideoCodecInfo.init(name: kRTCH264CodecName)
        } else {
            return RTCVideoCodecInfo.init(name: kRTCVp8CodecName)
        }
    }
    
    private static var _factory: RTCPeerConnectionFactory?
    static var factory: RTCPeerConnectionFactory {
        get {
            if self._factory == nil {
                let encoderFactory = RTCDefaultVideoEncoderFactory()
                let decoderFactory = RTCDefaultVideoDecoderFactory()
                encoderFactory.preferredCodec = getSupportedVideoEncoder(factory: encoderFactory)
                
                self._factory = RTCPeerConnectionFactory(
                    encoderFactory: encoderFactory
                    , decoderFactory: decoderFactory)
            }
            
            return self._factory!
        }
    }
    
    public override init() {
        configuration = FancyRTCConfiguration()
        _connection = FancyRTCPeerConnection.factory.peerConnection(with: configuration.configuration, constraints: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil), delegate: nil)
        super.init()
        _connection.delegate = self
    }
    
    public init(config: FancyRTCConfiguration) {
        configuration = config
        _connection = FancyRTCPeerConnection.factory.peerConnection(with: configuration.configuration, constraints: RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil), delegate: nil)
        super.init()
        _connection.delegate = self
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
            DispatchQueue.main.async {
                if(error != nil){
                    listener(error!.localizedDescription)
                }else{
                    listener(nil)
                }
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
        _connection.setRemoteDescription(sdp.sessionDescription) { (error) in
            DispatchQueue.main.async {
                if(error != nil){
                    listener(error!.localizedDescription)
                }else{
                    listener(nil)
                }
            }
        }
    }
    
    public var connectionState: FancyRTCPeerConnectionState {
        get {
            return FancyRTCPeerConnectionState(state: connection.connectionState)
        }
    }
    
    
    private var onConnectionStateChangeListener: (() -> Void)?
    
    public func onConnectionStateChange(_ listener : @escaping () -> Void){
        onConnectionStateChangeListener = listener
    }
    
    private var onTrackListener: ((FancyRTCTrackEvent) -> ())?
    
    public func onTrack(_ listener :@escaping (FancyRTCTrackEvent) -> Void){
        onTrackListener = listener
    }
    
    private var onRemoveTrackListener: (()-> Void)?
    
    public func onRemoveTrack(_ listener : @escaping () -> Void) {
        onRemoveTrackListener = listener
    }
    
    private var onRemoveStreamListener:((FancyRTCMediaStream) -> Void)?
    
    public func onRemoveStream(_ listener: @escaping (FancyRTCMediaStream) -> Void) {
        onRemoveStreamListener = listener
    }
    
    
    private var onIceGatheringStateChangeListener:(() -> Void)?
    
    
    public func onIceGatheringStateChange(_ listener:  @escaping () -> Void ) {
        onIceGatheringStateChangeListener = listener
    }
    
    
    private var onAddStreamListener:((FancyRTCMediaStream)->Void)?
    
    public func onAddStream(_ listener : @escaping (FancyRTCMediaStream)-> Void) {
        onAddStreamListener = listener
    }
    
    
    private var onNegotiationNeededListener:(()->Void)?
    
    public func onNegotiationNeeded(_ listener : @escaping ()->Void) {
        onNegotiationNeededListener = listener
    }
    
    private var onSignalingStateChangeListener:(()->Void)?
    
    public func onSignalingStateChange(_ listener :@escaping ()->Void) {
        onSignalingStateChangeListener = listener
    }
    
    private var onIceCandidateListener:((FancyRTCIceCandidate)->Void)?
    
    public func onIceCandidate(_ listener :@escaping (FancyRTCIceCandidate)->Void) {
        onIceCandidateListener = listener
    }
    
    
    private var onDataChannelListener:((FancyRTCDataChannelEvent)->Void)?
    
    public func onDataChannel(_ listener :@escaping (FancyRTCDataChannelEvent)->Void) {
        onDataChannelListener = listener
    }
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didStartReceivingOn transceiver:
        RTCRtpTransceiver) {
        DispatchQueue.main.async {
            if(self.onTrackListener != nil){
                self.onTrackListener!(FancyRTCTrackEvent(receiver:FancyRTCRtpReceiver(rtpReceiver:  transceiver.receiver), streams: nil, mediaTrack: (transceiver.receiver.track != nil ? FancyRTCMediaStreamTrack(track: transceiver.receiver.track!): nil), transceiver:FancyRTCRtpTransceiver(rtpTransceiver: transceiver)))
            }
        }
    }
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd rtpReceiver: RTCRtpReceiver, streams mediaStreams: [RTCMediaStream]) {
        DispatchQueue.main.async {
            if(peerConnection.configuration.sdpSemantics == .planB){
                if (self.onTrackListener != nil) {
                    var list: Array<FancyRTCMediaStream> = []
                    for stream in mediaStreams {
                        list.append(FancyRTCMediaStream(mediaStream:stream));
                    }
                    
                    self.onTrackListener!(FancyRTCTrackEvent(receiver:FancyRTCRtpReceiver(rtpReceiver:  rtpReceiver), streams: list, mediaTrack: (rtpReceiver.track != nil ? FancyRTCMediaStreamTrack(track: rtpReceiver.track!): nil), transceiver: nil))
                }
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        DispatchQueue.main.async {
            if(self.onConnectionStateChangeListener != nil){
                self.onConnectionStateChangeListener!()
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        DispatchQueue.main.async {
            if(self.onIceGatheringStateChangeListener != nil){
                self.onIceGatheringStateChangeListener!()
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCPeerConnectionState) {
        DispatchQueue.main.async {
            if(self.onConnectionStateChangeListener != nil){
                self.onConnectionStateChangeListener!()
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        DispatchQueue.main.async {
            if(self.onSignalingStateChangeListener != nil){
                self.onSignalingStateChangeListener!()
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        DispatchQueue.main.async {
            if(self.onAddStreamListener != nil){
                self.onAddStreamListener!(FancyRTCMediaStream(mediaStream: stream))
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        DispatchQueue.main.async {
            if(self.onRemoveStreamListener != nil){
                self.onRemoveStreamListener!(FancyRTCMediaStream(mediaStream: stream))
            }
        }
    }
    
    public func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        DispatchQueue.main.async {
            if(self.onNegotiationNeededListener != nil){
                self.onNegotiationNeededListener!()
            }
        }
    }
    
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        DispatchQueue.main.async {
            if (self.onIceCandidateListener != nil) {
                self.onIceCandidateListener!(FancyRTCIceCandidate(candidate: candidate));
            }
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        DispatchQueue.main.async {
            if (self.onDataChannelListener != nil) {
                self.onDataChannelListener!(FancyRTCDataChannelEvent(channel: FancyRTCDataChannel(channel: dataChannel)));
            }
        }
    }
    
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove rtpReceiver: RTCRtpReceiver) {
        
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
        _connection.add(candidate.iceCandidate)
    }
    
    public func addTrack(track: FancyRTCMediaStreamTrack, streamIds: [String]) {
        _connection.add(track.mediaStreamTrack, streamIds: streamIds)
    }
    
    public func close() {
        _connection.close()
    }
    
    
    public func createDataChannel(label: String, channelInit: FancyRTCDataChannelInit) -> FancyRTCDataChannel? {
        let channel = _connection.dataChannel(forLabel: label, configuration: channelInit.channelInit)
        if(channel != nil){
            return FancyRTCDataChannel(channel: channel!)
        }
        return nil
    }
    
    public func dispose() {
        
    }
    
    
    public func createAnswer(mediaConstraints: FancyRTCMediaConstraints, listener: @escaping (FancyRTCSessionDescription?, String?) -> Void) {
        if(!mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "true")) || !mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "false"))){
            mediaConstraints.mandatory.append(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "true"))
        }
        
        if(!mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "true")) || !mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "false"))){
            mediaConstraints.mandatory.append(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "true"))
        }
        
        _connection.answer(for: mediaConstraints.mediaConstraints) { (sdp, error) in
            if(error != nil){
                listener(nil,error?.localizedDescription)
            }else{
                listener(FancyRTCSessionDescription(sdp: sdp!),nil)
            }
        }
    }
    
    
    public func createOffer(mediaConstraints: FancyRTCMediaConstraints, listener: @escaping (FancyRTCSessionDescription?, String?) -> Void) {
        
        
        if(!mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "true")) || !mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "false"))){
            mediaConstraints.mandatory.append(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveVideo", value: "true"))
        }
        
        if(!mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "true")) || !mediaConstraints.mandatory.contains(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "false"))){
            mediaConstraints.mandatory.append(FancyRTCMediaConstraints.FancyRTCKeyValue(key: "OfferToReceiveAudio", value: "true"))
        }
        _connection.offer(for: mediaConstraints.mediaConstraints) { (sdp, error) in
            if(error != nil){
                listener(nil,error?.localizedDescription)
            }else{
                listener(FancyRTCSessionDescription(sdp: sdp!),nil)
            }
        }
    }
    
    public var connection: RTCPeerConnection {
        get {
            return _connection
        }
    }
    
    public var senders: Array<FancyRTCRtpSender> {
        get {
            var list: [FancyRTCRtpSender] = []
            for sender in _connection.senders {
                list.append(FancyRTCRtpSender(sender: sender))
            }
            return list
        }
    }
}

