//
//  PendingNotification.swift
//  localNotification
//
//  Created by Ahad Islam on 2/20/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation
import UserNotifications

class PendingNotification {
    static let helper = PendingNotification()
    private init() {}
    
    public func getPendingNotification(completion: @escaping ([UNNotificationRequest]) -> ()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("there are \(requests.count) requests.")
            completion(requests)
        }
    }
}
