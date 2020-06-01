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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupTableView()
    }
    
//    func setupTableView() {
//        notificationsTableView.delegate = self
//        notificationsTableView.dataSource = self
//    }
}

//extension NotificationSettingsViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}
