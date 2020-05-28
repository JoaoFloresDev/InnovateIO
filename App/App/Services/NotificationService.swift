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
import os.log

class NotificationService {
    let notificationCenter = UNUserNotificationCenter.current()
    
    let userKeyForEnabled = "isNotificationEnabled"
    
    let userInfoTypeKey = "notificationType"
    let userDefaults = UserDefaults.standard
    
    /// Getter for value saved in user defaults.
    var isNotificationEnabled: Bool {
        get {
            userDefaults.bool(forKey: userKeyForEnabled)
        }
    }
    
    typealias NotificationInfoTuple = (weekdays: [Int], hour: Int, minute: Int)
    
    // MARK: - Notifications permissions
    /// Request user's permission to fire notifications.
    func requestPermissions() {
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: notificationOptions) {isAllowed, error in
            if error != nil {
                os_log("Notification Error: ", error! as CVarArg)
                self.setIsEnabled(false)
            } else {
                self.setIsEnabled(isAllowed)
            }
        }
    }

    // MARK: - Sending or removing notifications
    
    /// Creates a notification content, its trigger and its request to add to notification center, according to the type of the notification.
    /// - Parameter type: type of notification.
    func sendNotification(type: NotificationType) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Não se esqueça!"
        notificationContent.body = type.body
        notificationContent.userInfo = [userInfoTypeKey : type.identifier]
        
        var dateComponent = DateComponents()
        
        let (weekdays, hour, minute) = getNotificationSettings(for: type)
        
        for weekday in weekdays {
            let uniqueIdentifier = type.identifier + String(weekday)
            
            dateComponent.weekday = weekday
            dateComponent.hour = hour
            dateComponent.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            
            let request = UNNotificationRequest(identifier: uniqueIdentifier,
                                                content: notificationContent,
                                                trigger: trigger)
            notificationCenter.add(request) { (error) in
                if let error = error {
                    os_log("Notification Error: ", error as CVarArg)
                }
            }
        }
    }
    
    /// Removes all delivered and pending notifications from notification center.
       private func disableAllNotifications() {
           notificationCenter.removeAllDeliveredNotifications()
           notificationCenter.removeAllPendingNotificationRequests()
       }
    
    // MARK: - Saving or getting data to/from User Defaults.
    /// Empties saved values on User Defaults (not sure if necessary/convenient).
    private func clearSpace() {
        userDefaults.set(nil, forKey: NotificationType.addMealLunch.identifier)
        userDefaults.set(nil, forKey: NotificationType.addMealDinner.identifier)
        userDefaults.set(nil, forKey: NotificationType.weaklyUpdate.identifier)
    }
    
    /// Saves notification configurations to user defaults.
    /// - Parameters:
    ///   - isEnabled: true if user has enabled notifications.
    ///   - lunchNotificationTime: tuple ([weekdays], hour, minute) of set time for lunch notification.
    ///   - dinnerNotificationTime: tuple ([weekdays], hour, minute) of set time for dinner notification.
    ///   - weaklyNotificationTime: tuple (weekday, hour, minute) of set time for weakly notification.
    func persistNotificationSettings(lunchNotificationTime: NotificationInfoTuple? = nil,
                                     dinnerNotificationTime: NotificationInfoTuple? = nil,
                                     weaklyNotificationTime: NotificationInfoTuple? = nil) {
        if let lunchNotificationTime = lunchNotificationTime {
            let dict = notificationTupleToDictionary(tuple: lunchNotificationTime)
            userDefaults.set(dict, forKey: NotificationType.addMealLunch.identifier)
        }
        if let dinnerNotificationTime = dinnerNotificationTime {
            let dict = notificationTupleToDictionary(tuple: dinnerNotificationTime)
            userDefaults.set(dict, forKey: NotificationType.addMealDinner.identifier)
        }
        if let weaklyNotificationTime = weaklyNotificationTime {
            let dict = notificationTupleToDictionary(tuple: weaklyNotificationTime)
            userDefaults.set(dict, forKey: NotificationType.weaklyUpdate.identifier)
        }
    }
    
    private func notificationTupleToDictionary(tuple: NotificationInfoTuple) -> [String: Any] {
        return ["weekdays": tuple.weekdays,
                "hour": tuple.hour,
                "minute": tuple.minute]
    }
    
    private func dictToNotificationTuple(dictionary: [String: Any]) -> NotificationInfoTuple? {
        guard let weekdays = dictionary["weekdays"] as? [Int],
            let hour = dictionary["hour"] as? Int,
            let minute = dictionary["minute"] as? Int else {
                return nil
        }
        return (weekdays: weekdays, hour: hour, minute: minute)
    }
    
    /// Will update value for isNotificationEnabled on User Defaults. If true, will send notifications; if false, will remove notifications and clear other saved data on User Defaults.
    func setIsEnabled(_ value: Bool) {
        userDefaults.set(value, forKey: userKeyForEnabled)
        if value {
            sendNotification(type: .addMealLunch)
            sendNotification(type: .addMealDinner)
            sendNotification(type: .weaklyUpdate)
        } else {
            clearSpace()
            disableAllNotifications()
        }
    }
    
    /// Will return a tuple containing the set information for the type of notification.
    private func getNotificationSettings(for type: NotificationType) -> NotificationInfoTuple {
        guard let dict = userDefaults.dictionary(forKey: type.identifier) else {
            return type.defaultConfig
        }
        let tuple = dictToNotificationTuple(dictionary: dict)
        return tuple ?? type.defaultConfig
    }
    
    // MARK: - Navigation
    
    /// Use this to make appropriate navigations inside app depending on type of notification.
    /// - Parameters:
    ///   - userInfo: userInfo dictionary associated with notification.
    ///   - rootVC: the root view controller, which is a tab bar controller.
    func handleNavigation(for userInfo: [AnyHashable : Any], rootVC: UITabBarController) {
        guard let type = userInfo[userInfoTypeKey] as? String else {
            os_log("Couldn't handle user info for notification.")
            return
        }
        
        switch type {
        case NotificationType.addMealLunch.identifier, NotificationType.addMealDinner.identifier:
            rootVC.selectedViewController = rootVC.viewControllers?.first(where: { (viewController) -> Bool in
                return viewController.restorationIdentifier == "MealNavigationViewController"
            })
            
        case NotificationType.weaklyUpdate.identifier:
            guard let profileVC = rootVC.selectedViewController as? ProfileViewController else { return }
            profileVC.performSegue(withIdentifier: R.segue.profileViewController.toEditData.identifier, sender: nil)
        default: return
            
        }
    }
}

// MARK: - Notification Types enum
extension NotificationService {
    enum NotificationType {
        case addMealLunch
        case addMealDinner
        case weaklyUpdate
        
        var identifier: String {
            switch self {
            case .addMealLunch:
                return "addMealLunch"
            case .addMealDinner:
                return "addMealDinner"
            case .weaklyUpdate:
                return "weaklyUpdate"
            }
        }
        
        var body: String {
            switch self {
            case .addMealLunch, .addMealDinner:
                return "Não se esqueça de marcar sua refeição!"
            case .weaklyUpdate:
                return "Que tal atualizar seu peso e meta?"
            }
        }
        
        var defaultConfig: NotificationInfoTuple {
            switch self {
            case .addMealLunch:
                return ([1,2,3,4,5,6,7], 12, 0)
            case .addMealDinner:
                return ([1,2,3,4,5,6,7], 20, 0)
            case .weaklyUpdate:
                return ([1], 12, 0)
            }
        }
    }
}
