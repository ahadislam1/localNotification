//
//  CreateNotificationViewController.swift
//  localNotification
//
//  Created by Ahad Islam on 2/20/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

protocol CreateNotificationControllerDelegate: AnyObject {
    func didCreateNotification(_ createNotificationController: CreateNotificationViewController)
}

class CreateNotificationViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5 // current time plus 5 seconds.
    
    weak var delegate: CreateNotificationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func createLocalNotification() {
        // step 1 create the content
        let content = UNMutableNotificationContent()
        content.title = textField.text ?? "No title."
        content.subtitle = "LEARNING LOCALNOTIFICIANOTS"
        content.body = "Local notificatiosn is awesome when used appropriately and also i'm being forced to write this somebody please help i see them they're com"
        
        
        // create identifier
        let identifier = UUID().uuidString // uniqu streque
        
        if let imageURL = Bundle.main.url(forResource: "pursuit-logo", withExtension: "png") {
            do {
            let attachment = try UNNotificationAttachment(identifier: identifier, url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("IMAGE HAD A PROBLEM I REPEAT THE IMAGE HAD A PROBLEMMMMMMMM")
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        createLocalNotification()
        delegate?.didCreateNotification(self)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickerChange(_ sender: UIDatePicker) {
        // to avoid time being in the past
        guard sender.date > Date() else { return }
        // timeintervalsincenow creates a time stamp in unix, of the exact date. xd.
        timeInterval = sender.date.timeIntervalSinceNow
    }
}
