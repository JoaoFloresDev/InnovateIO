//
//  NotificationSettingsViewController.swift
//  App
//
//  Created by Priscila Zucato on 01/06/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: UIViewController {
    @IBOutlet weak var notificationsTableView: UITableView!
    
    let dataSource: [NotificationSettingsHeaders] = [.meals, .weeklyUpdate]
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
// MARK: - Methods
    func setupTableView() {
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
    }
}

// MARK: - Table View Delegate and Data Source
extension NotificationSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = dataSource[section]
        return section.notifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = dataSource[section]
        return section.title
    }
}

// MARK: - Enums to serve as data source for settings table view.
enum NotificationSettingsHeaders {
    case meals
    case weeklyUpdate
    
    // TODO: definir os títulos
    var title: String {
        switch self {
        case .meals:
            return "Título meal"
        case .weeklyUpdate:
            return "Título update"
        }
    }
    
    var notifications: [NotificationType] {
        switch self {
        case .meals:
            return [.addMealDinner, .addMealLunch]
        case .weeklyUpdate:
            return [.weaklyUpdate]
        }
    }
}
