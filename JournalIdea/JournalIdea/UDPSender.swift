//
//  UDPSend.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/8/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021


import Foundation
import Network

class UDPSender {
    
    var connection: NWConnection? 
    
    init(inputAddress: NWEndpoint.Host, inputPort: NWEndpoint.Port) {
        self.connection = NWConnection(host: inputAddress, port: inputPort, using: .udp)
    }
    
    func sendString(_ inputString: String) {
        if let stringData = inputString.data(using: String.Encoding.utf8) {
            self.sendData(stringData)
        }
    }
    
    func sendData(_ inputData: Data) {
        self.connection?.start(queue: .global())
        self.connection?.send(content: inputData, completion: NWConnection.SendCompletion.contentProcessed {
            (NWError) in
            (NWError == nil) ? print("Data successfully sent.") : print("\nERROR: \(String(describing: NWError))\nEND-ERROR")
        })
    }

}
