//
//  SettingsViewController.swift
//  App
//
//  Created by Priscila Zucato on 19/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var optionsTableView: UITableView!
    
    var dataSource: [SettingsHeaders] = []
    var isNotificationEnabled: Bool = false {
        didSet {
            notificationEnabledDidChange()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        isNotificationEnabled = false // TODO: precisa ser recuperado do user defaults através do Notification Service
        setupTableView()
    }
    // MARK: - Methods
    func setupTableView() {
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
    }
    
    fileprivate func notificationEnabledDidChange() {
        dataSource = [.tools(isNotificationEnabled), .tutorials, .about]
        if isNotificationEnabled {
            optionsTableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
        } else {
            optionsTableView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
        }
        
        // TODO: precisa chamar o Notification Service para salvar a mudança no user defaults.
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: implementar as segues para cada tipo de célula.
        
        switch segue.identifier {
//        case SettingsCells.shareResults.segueId:
//
//        case SettingsCells.notificationSettings.segueId:
//
//        case SettingsCells.howToUse.segueId:
//
//        case SettingsCells.healthyMeal.segueId:
//
//        case SettingsCells.about.segueId:
//
        default:
            return
        }
    }
    
    @objc func notificationSwitchChanged(_ sender: UISwitch) {
        isNotificationEnabled = sender.isOn
    }
}
// MARK: - Table View delegate and data source
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = dataSource[section]
        return section.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let section = dataSource[indexPath.section]
        let settingCell = section.cells[indexPath.row]
        cell.textLabel?.text = settingCell.title
        
        if settingCell == .enableNotifications {
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(isNotificationEnabled, animated: false)
            switchView.addTarget(self, action: #selector(self.notificationSwitchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = dataSource[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = dataSource[indexPath.section]
        let settingCell = section.cells[indexPath.row]
        
        if let segueID = settingCell.segueId {
            performSegue(withIdentifier: segueID, sender: nil)
        }
        
        return
    }
}
// MARK: - Enums to serve as data source for settings table view.
enum SettingsHeaders {
    case tools(Bool)
    case tutorials
    case about
    
    var cells: [SettingsCells] {
        switch self {
        case .tools(let isNotificationOn):
            if isNotificationOn {
                return [.shareResults, .enableNotifications, .notificationSettings]
            } else {
                return [.shareResults, .enableNotifications]
            }
        case .tutorials:
            return [.howToUse, .healthyMeal]
        case .about:
            return [.about]
        }
    }
    
    var title: String {
        switch self {
        case .tools:
            return "Ferramentas"
        case .tutorials:
            return "Tutoriais"
        case .about:
            return "Sobre"
        }
    }
}

enum SettingsCells {
    case shareResults
    case enableNotifications
    case notificationSettings
    case howToUse
    case healthyMeal
    case about
    
    var title: String {
        switch self {
        case .shareResults:
            return "Compartilhar resultados"
        case .enableNotifications:
            return "Ativar notificações"
        case .notificationSettings:
            return "Horários de notificações"
        case .howToUse:
            return "Como utilizar"
        case .healthyMeal:
            return "Alimentação saudável"
        case .about:
            return "Sobre o aplicativo"
        }
    }
    
    // TODO: preencher conforme as segues forem criadas no storyboard (dica: usar o Rswift evita termos que digitar na mão esses ids das segues).
    var segueId: String? {
        switch self {
        default:
            return nil
        }
    }
}
