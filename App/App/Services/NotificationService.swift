//
//  NotificationService.swift
//  App
//
//  Created by Priscila Zucato on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationService {
    let notificationCenter = UNUserNotificationCenter.current()
    
    let userInfoTypeKey = "notificationType"
    
    func requestPermissions() {
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: notificationOptions) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func sendNotification(type: NotificationType) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Não se esqueça!"
        notificationContent.body = type.body
        notificationContent.userInfo = [userInfoTypeKey : type.rawValue]
        
        var dateComponent = DateComponents()
        
        for (identifier, time) in type.identifiersAndTime {
            
            // If notification is of "update" type, show every sunday.
            if type == .update {
                dateComponent.weekday = 1
            }
            
            dateComponent.hour = time
            dateComponent.minute = 0
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            
            let request = UNNotificationRequest(identifier: identifier,
                                                content: notificationContent,
                                                trigger: trigger)
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }
    }
    
    func handleNavigation(for userInfo: [AnyHashable : Any], rootVC: UITabBarController) {
        guard let type = userInfo[userInfoTypeKey] as? Int else {
            print("Couldn't handle user info for notification.")
            return
        }
        
        switch type {
        case NotificationType.addMeal.rawValue:
            rootVC.selectedViewController = rootVC.viewControllers?.first(where: { (viewController) -> Bool in
                return viewController.isKind(of: MealViewController.self)
            })
            
//        case NotificationType.update.rawValue
            // TODO: [update notification] add navigation to "update weight and goal" modal
            
        default: return
            
        }
    }
}

extension NotificationService {
    enum NotificationType: Int {
        case addMeal
        case update
        
        var identifiersAndTime: [String : Int] {
            switch self {
            case .addMeal:
                return ["addMealLunch" : 12, "addMealDinner" : 20]
            case .update:
                return ["update" : 12]
            }
        }
        
        var body: String {
            switch self {
            case .addMeal:
                return "Não se esqueça de marcar sua refeição!"
            case .update:
                return "Que tal atualizar seu peso e meta?"
            }
        }
    }
}
