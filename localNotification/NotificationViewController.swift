//
//  ViewController.swift
//  localNotification
//
//  Created by Ahad Islam on 2/20/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//


import UIKit

class NotificationViewController: UIViewController {
    
    
    private var notifications = [UNNotificationRequest]()
    private let center = UNUserNotificationCenter.current()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        checkForNotificationsPermissions()
        loadNotifications()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, let destVC = navVC.viewControllers[0] as? CreateNotificationViewController {
                print("Success")
                destVC.delegate = self
        }
    }
    
    private func loadNotifications() {
        PendingNotification.helper.getPendingNotification { requests in
            self.notifications = requests
        }
    }
    
    private func checkForNotificationsPermissions() {
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                print("App is authorized for notifications")
                
            } else {
                self.requestNotificationPermissions()
            }
        }
    }
    
    private func requestNotificationPermissions() {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("Error requesting authorization: \(error)")
                return
            }
            if granted {
                print("Access was granted.")
            } else {
                print("Access denied.")
            }
        }
    }
    
    
}


extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //notifications.count
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        return cell
    }
    
    
}

extension NotificationViewController: CreateNotificationControllerDelegate {
    func didCreateNotification(_ createNotificationController: CreateNotificationViewController) {
        loadNotifications()
        print("k lol")
    }
    
    
}

