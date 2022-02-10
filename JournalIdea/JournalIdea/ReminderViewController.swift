//
//  ReminderViewController.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/14/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021

import UIKit

class ReminderViewController: UIViewController {

    var myAppDelegate: AppDelegate?
    
    
    @IBOutlet weak var dateWheel: UIDatePicker!
    
    let notificationContent: UNMutableNotificationContent = {
        let temp = UNMutableNotificationContent()
        temp.title = "JournalIdea"
        temp.body = "Time to update your journal!"
        return temp
    }()
    
    
    @IBAction func scheduleDailyNotificationButton(_ sender: Any) {
        let myDateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: self.dateWheel.date)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: myDateComponents, repeats: true)
        let id = "Scheduled Daily Notification"
        let newRequest = UNNotificationRequest(identifier: id, content: self.notificationContent, trigger: notificationTrigger)
        
        self.addRequestToNotificationCenter(newRequest)
    }
    
    @IBAction func scheduleNotificationButton(_ sender: Any) {
        let myDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.dateWheel.date)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: myDateComponents, repeats: false)
        let id = "Scheduled Notification"
        let newRequest = UNNotificationRequest(identifier: id, content: self.notificationContent, trigger: notificationTrigger)
        
        self.addRequestToNotificationCenter(newRequest)
    }
    
    
    func addRequestToNotificationCenter(_ request: UNNotificationRequest) {
        self.myAppDelegate?.myNotificationCenter.add(request) {
            (error) in
            (error == nil) ? print("notification successfully scheduled") : print("ERROR: \(String(describing: error))")
        }
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
