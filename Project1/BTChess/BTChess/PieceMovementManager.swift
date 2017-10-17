//
//  BoardModel.swift
//  BTChess
//
//  Updated by Michael Tang on 10/16/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//


//Tutorial for bluetooth code https://www.ralfebert.de/tutorials/ios-swift-multipeer-connectivity/

import Foundation
import MultipeerConnectivity

protocol PieceMovementManagerDelegate {
    //Alert on connection
    func connectedDevicesChanged(manager : PieceMovementManager, connectedDevices: [String])
    //Send moves over bluetooth as a 4char string
    func packet(manager : PieceMovementManager, packet: String)
    
}

class PieceMovementManager : NSObject {
 
    private let PieceMovementType = "movement"
    
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    
    var delegate : PieceMovementManagerDelegate?
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: PieceMovementType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: PieceMovementType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func send(packet : String) {
        print("%@", "sending packet: \(packet) to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(packet.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                print("Error for sending: \(error)")
            }
        }
        
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
}

//Class extends to conform to MCNearbyService...Delegate to know of events of nearby players, who was invited, and settings for timeout limit.
extension PieceMovementManager : MCNearbyServiceBrowserDelegate {
    
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Found peer with ID: \(peerID)")
        print("Invited peer with ID: \(peerID)")
        //Set timeout to 15 sec
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Lost player with ID: \(peerID)")
    }
    
}

//Class extend to conform to MCNearbyServiceAdvertiser to know of events of when bluetooth connection broadcast begins and notification of an invitation from a nearby player.
extension PieceMovementManager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("Did not start advertising peer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Did receive invitation from peer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}



extension PieceMovementManager : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("peer \(peerID) didChangeState: \(state)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }
    
    //Function to 
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.packet(manager: self, packet: str)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("didFinishReceivingResourceWithName")
    }
    
}

