//
//  EditDataViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class EditDataViewController: ViewController {
    
    
    // MARK: - IBOutlets
    // Interface builder outlets
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var plainingTextView: UITextView!
    
    
    //MARK: - Variables
    // Private properties related to the Edit View
    private var defaults = UserDefaults.standard
    
    
    //    MARK: - IBAction
    
    /// Saves the new data into local storage.
    /// - Parameter sender: The tap action.
    @IBAction func saveViewController(_ sender: Any) {
        saveNewData()
        self.dismiss(animated: true, completion: nil)
        updateDataProfile()
    }
    
    
    
    /// Closes the view.
    /// - Parameter sender: The tap / swipe action.
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /// Clears the goal field.
    /// - Parameter sender: The tap action.
    @IBAction func clearGoals(_ sender: Any) {
        plainingTextView.text = ""
    }
    
    //    MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupStyle()
    }
    
    func updateDataProfile() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateDataProfile"),
                                        object: nil, userInfo: nil)
    }
    //    MARK: - UserDefaults
    func setupTexts() {
        plainingTextView.text = defaults.string(forKey: "Plain")
        weightTextField.text = defaults.string(forKey: "Weight")
    }
    
    func saveNewData() {
        defaults.set (plainingTextView.text, forKey: "Plain")
        defaults.set (weightTextField.text, forKey: "Weight")
    }
    
    
    //    MARK: - Style
    func setupStyle() {
        plainingTextView.layer.cornerRadius = 10
    }
}
