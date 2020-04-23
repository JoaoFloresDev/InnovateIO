//
//  NotificationService.swift
//  App
//
//  Created by Priscila Zucato on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestPermissions() {
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: notificationOptions) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
}
