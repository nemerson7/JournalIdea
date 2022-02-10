//
//  NetworkSettingsViewController.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/8/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021



import UIKit
import Network

class NetworkSettingsViewController: UIViewController, UITextFieldDelegate {

    var myAppDelegate: AppDelegate?
    
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    
    
    @IBAction func sendEntriesButtonAction(_ sender: Any) {
        
        //changes UDPSender instance in the AppDelegate to be updated before anything is sent
        //SAFETY FIRST
        if let unwrappedDelegate = self.myAppDelegate,
           let unwrappedHost = self.addressTextField.text,
           let unwrappedPort = self.portTextField.text {
            if let unwrappedInt = Int(unwrappedPort) {
                let intTo16Int = UInt16(unwrappedInt)
                let host = NWEndpoint.Host(unwrappedHost)
                let port = NWEndpoint.Port(rawValue: intTo16Int)
                if let unwrappedPort = port {
                    
                    unwrappedDelegate.udpSender = UDPSender(inputAddress: host, inputPort: unwrappedPort)
                    unwrappedDelegate.udpSender?.sendString(unwrappedDelegate.myModel.description)
                    
                }
            }
            self.portTextField.resignFirstResponder()
            self.addressTextField.resignFirstResponder()
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
