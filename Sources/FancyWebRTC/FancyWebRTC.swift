//
//  FancyWebRTC.swift
//  FancyWebRTC
//
//  Created by Osei Fortune on 1/19/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import AVFoundation
import WebRTC

@objcMembers public class AVCaptureState: NSObject {
    public static func isVideoDisabled() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(
            for: AVMediaType.video
        );
        return (
            status == AVAuthorizationStatus.denied ||
                status == AVAuthorizationStatus.restricted
        );
    }
    
    public static func isAudioDisabled() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(
            for: AVMediaType.video
        );
        return (
            status == AVAuthorizationStatus.denied ||
                status == AVAuthorizationStatus.restricted
        );
    }
}





@objc public enum Quality: Int {
    case MAX_480P
    case MAX_720P
    case MAX_1080P
    case MAX_2160P
    case HIGHEST
    case LOWEST
}

@objc public enum WebRTCDataChannelMessageType: Int, RawRepresentable {
    case BINARY
    case TEXT
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .BINARY:
            return "binary"
        case .TEXT:
            return "text"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "binary":
            self = .BINARY
        case "text":
            self = .TEXT
        default:
            self = .TEXT
            
        }
    }
}

@objc public protocol WebRTCIceCandidate {
    var sdpMid: String {get set}
    var  sdpMLineIndex: Int {get set}
    var  sdp: String {get set}
}

@objc  public protocol WebRTCSdp {
    var type: WebRTCSdpType {get set}
    var sdp: String {get set}
}


@objc public enum SignalingState: Int, RawRepresentable {
    case STABLE
    case HAVE_LOCAL_OFFER
    case HAVE_LOCAL_PRANSWER
    case HAVE_REMOTE_OFFER
    case HAVE_REMOTE_PRANSWER
    case CLOSED
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .STABLE:
            return "stable"
        case .HAVE_LOCAL_OFFER:
            return "have-local-offer"
        case .HAVE_LOCAL_PRANSWER:
            return "have-local-pranswer"
        case .HAVE_REMOTE_OFFER:
            return "have-remote-offer"
        case .HAVE_REMOTE_PRANSWER:
            return "have-remote-pranswer"
        case .CLOSED:
            return "closed"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "stable":
            self = .STABLE
        case "have-local-offer":
            self = .HAVE_LOCAL_OFFER
        case "have-local-pranswer":
            self = .HAVE_LOCAL_PRANSWER
        case "have-remote-offer":
            self = .HAVE_REMOTE_OFFER
        case "have-remote-pranswer":
            self = .HAVE_REMOTE_PRANSWER
        case "closed":
            self = .CLOSED
        default:
            self = .STABLE
        }
    }
}

@objc public enum IceGatheringState: Int, RawRepresentable {
    case NEW
    case GATHERING
    case COMPLETE
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .NEW:
            return "binary"
        case .GATHERING:
            return "text"
        case .COMPLETE:
            return "complete"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new":
            self = .NEW
        case "gathering":
            self = .GATHERING
        case "complete":
            self = .COMPLETE
        default:
            self = .COMPLETE
            
        }
    }
}

@objc public enum IceConnectionState: Int, RawRepresentable {
    case NEW
    case CHECKING
    case CONNECTED
    case COMPLETED
    case FAILED
    case DISCONNECTED
    case CLOSED
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .NEW:
            return "new"
        case .CHECKING:
            return "checking"
        case .CONNECTED:
            return "connected"
        case .COMPLETED:
            return "completed"
        case .FAILED:
            return "failed"
        case .DISCONNECTED:
            return "disconnected"
        case .CLOSED:
            return "closed"
        default:
            return "new"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "new":
            self = .NEW
        case "checking":
            self = .CHECKING
        case "connected":
            self = .CONNECTED
        case "completed":
            self = .COMPLETED
        case "failed":
            self = .FAILED
        case "disconnected":
            self = .DISCONNECTED
        case "closed":
            self = .CLOSED
        default:
            self = .NEW
        }
    }
}

@objc public enum WebRTCDataChannelState: Int, RawRepresentable {
    case CONNECTING
    case CLOSED
    case CLOSING
    case OPEN
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .CONNECTING:
            return "connecting"
        case .CLOSED:
            return "closed"
        case .CLOSING:
            return "closing"
        case .OPEN:
            return "open"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "connecting":
            self = .CONNECTING
        case "closed":
            self = .CLOSED
        case "closing":
            self = .CLOSING
        case "open":
            self = .OPEN
        default:
            self = .CLOSED
            
        }
    }
}

@objcMembers public class IceServer: NSObject {
    var username: String?
    var password: String?
    var urls: NSArray?
    override init() {
       
    }
    public init(urls: NSArray, username: String?, password: String?) {
        self.urls = urls
        self.username = username
        self.password = password
    }
}

@objc public protocol WebRTCOptions {
    var iceServers: Array<IceServer> {get set}
    var enableVideo: Bool {get set}
    var enableAudio: Bool {get set}
}

@objc public enum WebRTCState: Int {
    case CONNECTING
    case DISCONNECTED
    case CONNECTED
}

@objc public enum WebRTCSdpType: Int, RawRepresentable {
    case OFFER
    case PRANSWER
    case ANSWER
    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
        case .OFFER:
            return "offer"
        case .PRANSWER:
            return "prAnswer"
        case .ANSWER:
            return "answer"
        }
    }
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "offer":
            self = .OFFER
        case "prAnswer":
            self = .PRANSWER
        case "answer":
            self = .ANSWER
        default:
            self = .OFFER
            
        }
    }
}


@objc public protocol FancyWebRTCClientDelegate {
    func webRTCClientOnRemoveStream(client: FancyWebRTC, stream: RTCMediaStream)
    func webRTCClientDataChannelStateChanged(
        client: FancyWebRTC,
        name: String,
        type: Any
    )
    func webRTCClientDataChannelMessageType(
        client: FancyWebRTC,
        name: String,
        data: String,
        type: WebRTCDataChannelMessageType
    )
    func webRTCClientStartCallWithSdp(client: FancyWebRTC, sdp: RTCSessionDescription)
    
    func webRTCClientDidReceiveStream(
        client: FancyWebRTC,
        stream: RTCMediaStream
    )
    
    func webRTCClientDidRemoveStream(
        client: FancyWebRTC,
        stream: RTCMediaStream
    )
    
    func webRTCClientDidReceiveError(client: FancyWebRTC, error: NSError)
    
    
    func webRTCClientOnRenegotiationNeeded(
        client: FancyWebRTC
    )
    
    
    func webRTCClientDidGenerateIceCandidate(
        client: FancyWebRTC,
        iceCandidate: RTCIceCandidate
    )
    
    
    func webRTCClientOnIceCandidatesRemoved(
        client: FancyWebRTC,
        candidates: Array<RTCIceCandidate>
    )
    
    func webRTCClientOnIceConnectionChange(
        client: FancyWebRTC,
        connectionState: RTCIceConnectionState
    )
    
    func webRTCClientOnIceConnectionReceivingChange(
        client: FancyWebRTC,
        change: Bool
    )
    
    func webRTCClientOnIceGatheringChange(
        client: FancyWebRTC,
        gatheringState: Any
    )
    
    func webRTCClientOnSignalingChange(
        client: FancyWebRTC,
        signalingState: Any
    )
    
    func webRTCClientOnCameraSwitchDone(
        client: FancyWebRTC,
        done:Bool
    )
    
    func webRTCClientOnCameraSwitchError(
        client: FancyWebRTC,
        error: String
    )
}

public class MediaData: NSObject {
    public var mediaSource: Any
    public var track: Any
    public var capturer: WebRTCCapturer?
    init(mediaSource: Any, track: Any, capturer: WebRTCCapturer?) {
        self.mediaSource = mediaSource;
        self.track = track;
        self.capturer = capturer;
    }
}


@objcMembers public class FancyWebRTC: NSObject , RTCDataChannelDelegate, RTCPeerConnectionDelegate{
    var connection: RTCPeerConnection?
    var configuration: RTCConfiguration?
    var remoteTracks: Array<Any>?
    var remoteIceCandidates: Array<RTCIceCandidate>?
    var defaultConnectionConstraints: RTCMediaConstraints?
    var connectionFactory: RTCPeerConnectionFactory?
    var constraints: RTCMediaConstraints?
    var delegate: FancyWebRTCClientDelegate?
    var tracks: Dictionary<String, MediaData>
    var localStreams: Dictionary<String, Any>
    var remoteStreams: Dictionary<String,Any>
    var dataChannels: Dictionary<String, RTCDataChannel>
    static let defaultIceServers = [
        "stun:stun.l.google.com:19302",
        "stun:stun1.l.google.com:19302",
        "stun:stun2.l.google.com:19302",
        "stun:stun3.l.google.com:19302",
        "stun:stun4.l.google.com:19302"]
    override init() {
        tracks = [:]
        localStreams = [:]
        remoteStreams = [:]
        dataChannels = [:]
        remoteTracks = []
        remoteIceCandidates = []
        defaultConnectionConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: ["DtlsSrtpKeyAgreement": "true","internalSctpDataChannels": "true"])
        configuration = RTCConfiguration()
        configuration?.bundlePolicy = RTCBundlePolicy.maxCompat
        configuration?.continualGatheringPolicy = RTCContinualGatheringPolicy.gatherContinually
        configuration?.tcpCandidatePolicy = RTCTcpCandidatePolicy.disabled
        configuration?.rtcpMuxPolicy = RTCRtcpMuxPolicy.require
        configuration?.keyType = RTCEncryptionKeyType.ECDSA
        
        let decoder = RTCDefaultVideoDecoderFactory()
        let encoder = RTCDefaultVideoEncoderFactory()
        
        connectionFactory = RTCPeerConnectionFactory(encoderFactory: encoder, decoderFactory: decoder)
    }
    
    @objc public func setListener(listener: FancyWebRTCClientDelegate){
        delegate = listener
    }
    
    @objc public static func initWith(options: Dictionary<String,Any>) -> FancyWebRTC{
        var nativeIceServers: Array<RTCIceServer> = []
        let configServers = options["iceServers"] as? Array<Dictionary<String,String>>
        if(configServers != nil){
            for config in configServers! {
                nativeIceServers.append(RTCIceServer(urlStrings: [config["url"] ?? ""], username: config["username"], credential: config["password"]))
            }
        }else{
            for server in defaultIceServers {
                nativeIceServers.append(RTCIceServer(urlStrings: [server]))
            }
        }
        let rtc = FancyWebRTC()
        rtc.configuration?.iceServers = nativeIceServers
        let enableAudio = String(options["enableAudio"] as? Bool ?? false)
        let enableVideo = String(options["enableVideo"] as? Bool ?? true)
        rtc.constraints = RTCMediaConstraints(mandatoryConstraints: ["OfferToReceiveAudio": enableAudio ,"OfferToReceiveVideo": enableVideo ] , optionalConstraints: nil)
        return rtc
    }
    
    enum ErrorDomain: String {
        case videoPermissionDenied = "Video permission denied"
        case audioPermissionDenied = "Audio permission denied"
    }
    
    static func hasCameraPermission() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(
            for: AVMediaType.video
        );
        switch (status) {
        case AVAuthorizationStatus.authorized:
            return true;
        default:
            return false;
        }
    }
    
    static func hasAudioPermission() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(
            for: AVMediaType.audio
        );
        switch (status) {
        case AVAuthorizationStatus.authorized:
            return true;
        default:
            return false;
        }
    }
    
    @objc public static func hasPermissions() -> Bool {
        return hasCameraPermission() && hasAudioPermission();
    }
    
    static func requestAudioPermission(callback:@escaping (String?) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { (granted) in
            if (granted) {
                callback(nil)
            } else {
                callback(ErrorDomain.videoPermissionDenied.rawValue);
            }
        }
    }
    
    static func requestCameraPermission(callback:@escaping (String?) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            if (granted) {
                callback(nil)
            } else {
                callback(ErrorDomain.videoPermissionDenied.rawValue);
            }
        }
    }
    
    public static func requestPermissions(callback:@escaping (String?) -> Void){
        requestCameraPermission { (videoError) in
            if(videoError != nil){
                callback(videoError)
            }else{
                requestAudioPermission(callback: { (audioError) in
                    if(audioError != nil){
                        callback(audioError)
                    }else{
                        callback(nil)
                    }
                })
            }
        }
    }
    
    public func makeOffer() {
        if (connection == nil) {return}
        connection?.offer(for: constraints!, completionHandler: { (sdp, error) in
            if(error != nil && self.delegate != nil){
                self.delegate?.webRTCClientDidReceiveError(client: self, error: error! as NSError)
            }else{
                self.handleSdpGenerated(sdp)
            }
        })
    }
    

    public func handleAnswerReceived(answer: WebRTCSdp) {
        let sessionDescription = RTCSessionDescription(type: RTCSdpType.answer, sdp: answer.sdp)
        connection?.setRemoteDescription(sessionDescription, completionHandler: { (error) in
            if (error != nil) {
                self.delegate?.webRTCClientDidReceiveError(client: self, error: error! as NSError);
            } else {
                self.handleRemoteDescriptionSet();
            }
        })
    }
    
    public func addIceCandidate(iceCandidate: WebRTCIceCandidate) {
        let nativeIceCandidate = RTCIceCandidate(sdp: iceCandidate.sdp, sdpMLineIndex: Int32(iceCandidate.sdpMLineIndex), sdpMid: iceCandidate.sdpMid)
        
        if (connection != nil && ((connection?.remoteDescription) != nil)) {
            connection?.add(nativeIceCandidate);
        } else {
            remoteIceCandidates?.append(nativeIceCandidate);
        }
    }
    
    
    public func createAnswerForOfferReceived(sdp: WebRTCSdp?) {
        if (connection == nil || sdp == nil) {return;}
        let sessionDescription = RTCSessionDescription(type: .offer, sdp: sdp!.sdp)
        connection?.setRemoteDescription(sessionDescription, completionHandler: { (error) in
            if(error != nil){
                self.delegate?.webRTCClientDidReceiveError(client: self, error: error! as NSError);
            }else{
                self.handleRemoteDescriptionSet()
                self.connection?.answer(for: self.constraints!, completionHandler: { (answerSdp, answerError) in
                    if(answerError != nil){
                        self.delegate?.webRTCClientDidReceiveError(client: self, error: answerError! as NSError);
                    }else{
                        self.handleSdpGenerated(answerSdp);
                        self.delegate?.webRTCClientStartCallWithSdp(client: self, sdp: answerSdp!);
                    }
                })
            }
        })
    }
    
    
    func handleRemoteDescriptionSet() {
        if(remoteIceCandidates != nil){
            for iceCandidate in remoteIceCandidates! {
                connection?.add(iceCandidate)
            }
        }
        remoteIceCandidates?.removeAll()
    }
    
    func handleSdpGenerated(_ sdp: RTCSessionDescription?) {
        if (sdp != nil) {return}
        connection?.setLocalDescription(sdp!, completionHandler: { (error) in
            if (error != nil) {
                self.delegate?.webRTCClientDidReceiveError(client: self, error: error! as NSError);
            } else {
                self.delegate?.webRTCClientStartCallWithSdp(client: self, sdp: sdp!);
            }
        })
    }
    
    
    public func connect() {
        if (connection == nil) {return}
        connection = connectionFactory?.peerConnection(with: configuration!, constraints: defaultConnectionConstraints!, delegate: self)
    }
    
    public func disconnect() {
        if (connection == nil) {return;}
        connection?.close();
    }
    
    public func addLocalStream(stream: RTCMediaStream) {
        if (connection == nil) {return;}
        connection?.add(stream)
        localStreams[stream.streamId] = stream
    }
    
    public func addRemoteStream(stream: RTCMediaStream) {
        remoteStreams[stream.streamId]  = stream;
    }
    
    
    public func dataChannelSend(name: String, data: String, type: WebRTCDataChannelMessageType) {
        let channel = dataChannels[name];
        if (channel != nil) {
            var isBinary: Bool = false
            var nativeData: Data?
            switch (type) {
            case WebRTCDataChannelMessageType.TEXT:
                isBinary = false;
                nativeData = data.data(using: String.Encoding.utf8)
                break;
            case WebRTCDataChannelMessageType.BINARY:
                isBinary = true;
                nativeData =  Data(base64Encoded: data, options: .init(rawValue: 0))
                break;
            }
            let buffer = RTCDataBuffer(data: nativeData!, isBinary: isBinary)
            channel?.sendData(buffer);
        }
    }
    
    public func dataChannelClose(name: String) {
        let channel = dataChannels[name];
        if (channel != nil) {
            channel!.close()
        }
    }
    
   public func dataChannelCreate(name: String) {
        let config = RTCDataChannelConfiguration();
        let channel = connection?.dataChannel(forLabel: name, configuration: config)
        dataChannels[name] = channel
        registerDataChannelDelegate(name: name)
    }
    
    
    public func switchCamera(trackId: String) {
        let mediaData = tracks[trackId];
        if (mediaData != nil && mediaData!.capturer != nil) {
            mediaData?.capturer?.toggleCamera();
        }
    }
    
    private func registerDataChannelDelegate(name: String) {
        let channel = dataChannels[name]
        if (channel != nil) {
            channel!.delegate = self
        }
    }
    
    private func getRandomId() -> String {
        return NSUUID().uuidString;
    }
    
    private func getUserMedia(quality: Quality, callback:@escaping (RTCMediaStream?, String?) -> Void) {
        let factory = connectionFactory!;
        let streamId = getRandomId();
        let localStream = factory.mediaStream(withStreamId: streamId)
        if (!AVCaptureState.isVideoDisabled()) {
            let videoSource = factory.videoSource()
            let capturer = RTCCameraVideoCapturer(delegate: videoSource)
            let customCapturer = WebRTCCapturer(client: self, capturer: capturer, quality: quality);
            let videoTrackId = getRandomId();
            
            let videoTrack = factory.videoTrack(with: videoSource, trackId: videoTrackId)
            videoTrack.isEnabled = true;
            customCapturer.start();
            tracks[videoTrackId] = MediaData(mediaSource: videoSource, track: videoTrack, capturer: customCapturer)
            localStream.addVideoTrack(videoTrack);
        } else {
            callback(nil,ErrorDomain.videoPermissionDenied.rawValue)
        }
        
        if (!AVCaptureState.isAudioDisabled()) {
            let audioTrackId = getRandomId()
            let audioSource = factory.audioSource(with: RTCMediaConstraints.init(mandatoryConstraints: nil, optionalConstraints: nil))
            let audioTrack = factory.audioTrack(with: audioSource, trackId: audioTrackId)
            audioTrack.isEnabled = true
            localStream.addAudioTrack(audioTrack);
            tracks[audioTrackId] = MediaData(mediaSource: audioSource, track: audioTrack, capturer: nil)
        } else {
            callback(nil,ErrorDomain.audioPermissionDenied.rawValue);
        }
        callback(localStream,nil)
    }
    
    
    public func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        delegate?.webRTCClientDataChannelStateChanged(client: self, name: dataChannel.label, type: dataChannel.readyState);
    }
    
    public func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        if(delegate != nil){
            var type: WebRTCDataChannelMessageType?
            var data: String?
            if (buffer.isBinary) {
                type = WebRTCDataChannelMessageType.BINARY;
                data = buffer.data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            } else {
                type = WebRTCDataChannelMessageType.TEXT;
                data = String(data: buffer.data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
            delegate!.webRTCClientDataChannelMessageType(client: self, name: dataChannel.label, data: data!, type: type!);
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientOnSignalingChange(client: self, signalingState: stateChanged)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientDidReceiveStream(client: self, stream: stream)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove rtpReceiver: RTCRtpReceiver) {
        
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didAdd rtpReceiver: RTCRtpReceiver, streams mediaStreams: [RTCMediaStream]) {
        
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didStartReceivingOn transceiver: RTCRtpTransceiver) {
        
    }
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientDidRemoveStream(client: self, stream: stream)
        }
    }
    
    public func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientOnRenegotiationNeeded(client: self)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientOnIceConnectionChange(client: self, connectionState: newState)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientOnIceGatheringChange(client: self, gatheringState: newState)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientDidGenerateIceCandidate(client: self, iceCandidate: candidate)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        DispatchQueue.main.async {
            self.delegate?.webRTCClientOnIceCandidatesRemoved(client: self, candidates: candidates)
        }
    }
    
    public func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        registerDataChannelDelegate(name: dataChannel.label)
    }
    
    
}




@objc(WebRTCCapturer)
public class WebRTCCapturer: NSObject {
    private var capturer: RTCCameraVideoCapturer?
    private var cameraPosition = "front"
    private var quality: Quality?
    private var client: FancyWebRTC?
    
    override init() {
        
    }
    
    @objc public class Format: NSObject {
        public let width: Int32
        public let height: Int32
        init(width: Int32, height: Int32) {
            self.width = width
            self.height = height
        }
    }
    
    public init(client: FancyWebRTC, capturer: RTCCameraVideoCapturer, quality: Quality) {
        self.client = client
        self.capturer = capturer
        self.quality = quality
    }
    
    
    
    public func start() {
        startWithError(show: false);
    }
    
    private func startWithError(show: Bool?) {
        let devices = RTCCameraVideoCapturer.captureDevices();
        var selectedDevice: AVCaptureDevice?
        let pos = cameraPosition == "front"
            ? AVCaptureDevice.Position.front
            : AVCaptureDevice.Position.back;
        for device in devices {
            if(device.position == pos){
                selectedDevice = device
                break
            }
        }
        
        let  format = selectFormatForDevice(device: selectedDevice!);
        let fps = selectFpsForFormat(format: format);
        capturer!.startCapture(with: selectedDevice!, format: format, fps: Int(fps)) { (error: Error?) in
            if (show ?? false) {
                if (error != nil) {
                    self.client!.delegate?.webRTCClientOnCameraSwitchError(client: self.client!, error: error!.localizedDescription);
                } else {
                    self.client!.delegate?.webRTCClientOnCameraSwitchDone(client: self.client!, done: true);
                }
            }
        }
    }
    
    func selectFpsForFormat(format: AVCaptureDevice.Format) -> Double {
        var maxFrameRate = 0.0
        for fpsRange in format.videoSupportedFrameRateRanges{
            maxFrameRate = fmax(maxFrameRate, fpsRange.maxFrameRate);
        }
        return maxFrameRate;
    }
    
    func getFormatOrHighestFormat(
        supportedFormats: Array<AVCaptureDevice.Format>,
        device: AVCaptureDevice
        ) -> Format{
        var targetHeight:Int32 = 144
        var targetWidth:Int32 = 192
        
        func highest() -> CMVideoDimensions{
            var last: CMVideoDimensions = CMVideoFormatDescriptionGetDimensions(
                (supportedFormats.first?.formatDescription)!
            )
            for format in supportedFormats{
                let dimensions = CMVideoFormatDescriptionGetDimensions(
                    format.formatDescription
                );
                if (last.width < dimensions.width) {
                    last = dimensions;
                }
            }
            return last;
        }
        
        let best = highest()
        
        switch (quality!) {
        case Quality.HIGHEST:
            targetHeight = best.height;
            targetWidth = best.width;
            break;
        case Quality.MAX_480P:
            if (
                device.supportsSessionPreset(AVCaptureSession.Preset.vga640x480)
                ) {
                targetHeight = 480;
                targetWidth = 640;
            } else {
                targetHeight = best.height;
                targetWidth = best.width;
            }
            break;
        case Quality.MAX_720P:
            if (
                device.supportsSessionPreset(AVCaptureSession.Preset.hd1280x720)
                ) {
                targetHeight = 720;
                targetWidth = 1280;
            } else {
                targetHeight = best.height;
                targetWidth = best.width;
            }
            break;
        case Quality.MAX_1080P:
            if (
                device.supportsSessionPreset(AVCaptureSession.Preset.hd1920x1080)
                ) {
                targetHeight = 1080;
                targetWidth = 1920;
            } else {
                targetHeight = best.height;
                targetWidth = best.width;
            }
            break;
        case Quality.MAX_2160P:
            if (
                device.supportsSessionPreset(AVCaptureSession.Preset.hd4K3840x2160)
                ) {
                targetHeight = 2160;
                targetWidth = 3840;
            } else {
                targetHeight = best.height;
                targetWidth = best.width;
            }
            break;
        default:
            targetHeight = 144;
            targetWidth = 192;
            break;
        }
        
        return Format(width: targetWidth, height: targetHeight)
    }
    
    func selectFormatForDevice(
        device: AVCaptureDevice
        )-> AVCaptureDevice.Format {
        let supportedFormats = RTCCameraVideoCapturer.supportedFormats(
            for: device
        );
        let resolution = getFormatOrHighestFormat(supportedFormats: supportedFormats, device: device);
        
        let targetHeight = resolution.height;
        let targetWidth = resolution.width;
        
        var selectedFormat: AVCaptureDevice.Format?;
        var currentDiff = Int32.max;
        
        for format in supportedFormats {
            let dimension: CMVideoDimensions = CMVideoFormatDescriptionGetDimensions(
                format.formatDescription
            );
            let diff =
                abs(targetWidth - dimension.width) +
                    abs(targetHeight - dimension.height);
            if (diff < currentDiff) {
                selectedFormat = format;
                currentDiff = diff;
            }
        }
        
        
        return selectedFormat!;
    }
    
    @objc func stop() {
        capturer!.stopCapture();
    }
    
    @objc func toggleCamera() {
        if (cameraPosition.elementsEqual("front")) {
            cameraPosition = "back"
        } else {
            cameraPosition = "front";
        }
        stop()
        startWithError(show: true)
    }
}
