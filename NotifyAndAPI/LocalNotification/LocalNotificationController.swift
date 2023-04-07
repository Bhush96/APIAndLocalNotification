//
//  LocalNotificationController.swift
//  NotifyAndAPI
//
//  Created by Bhushan Tambe on 06/04/23.
//

import UIKit
import UserNotifications

class LocalNotificationController: UIViewController
{
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sendBtn: UIButton!
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       //datePicker.setValue(UIColor.white, forKeyPath: "textColor")
     //   datePicker.tintColor = UIColor.white
        let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        datePicker.layer.backgroundColor = white.cgColor
        datePicker.layer.cornerRadius = 15
        datePicker.minimumDate = .now
        
        sendBtn.layer.cornerRadius = 10
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Denied")
            }
        }
    }

    
    @IBAction func scheduleAction(_ sender: Any)
    {
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async
            {
                let title = self.titleTF.text!
                let message = self.messageTF.text!
                let date = self.datePicker.date
                
                if(settings.authorizationStatus == .authorized)
                {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request) { (error) in
                        if(error != nil)
                        {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let ac = UIAlertController(title: "Notification Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (_) in
                        self.titleTF.text = ""
                        self.messageTF.text = ""
                    }))
                    self.present(ac, animated: true)
                }
                else
                {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default)
                    { (_) in
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString)
                        else
                        {
                            return
                        }
                        
                        if(UIApplication.shared.canOpenURL(setttingsURL))
                        {
                            UIApplication.shared.open(setttingsURL) { (_) in}
                        }
                    }
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
}

