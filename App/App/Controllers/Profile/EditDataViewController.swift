//
//  EditDataViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class EditDataViewController: ViewController {
    
    
    //MARK: - Variables
    var defaults = UserDefaults.standard
    
    // MARK: - IBOutlets
    // Interface builder outlets
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var plainingTextView: UITextView!
    
    
    //MARK: - Variables
    // Private properties related to the Edit View
    private var dataHandler: DataHandler?
    
    
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
        
        do {
            self.dataHandler = try DataHandler.getShared()
        }
        catch {
            os_log("[ERROR] Can't get Data Handler instance, maybe the memory is too low?")
        }
        
        setupTexts()
        setupStyle()
        
    }
    
    func updateDataProfile() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateDataProfile"),
                                        object: nil, userInfo: nil)
    }
    
    //    MARK: - UserDefaults
    
    /// Setups the initial state of the components on the view.
    func setupTexts() {
        
        // Loading the Plain
        plainingTextView.text = defaults.string(forKey: "Plain")
        
        // Loading the Weight
        weightTextField.text = defaults.string(forKey: "Weight")
    }
    
    
    
    /// Saves the new data into local storage.
    /// The data that will be saved by using the User Defaults and the Core Data.
    func saveNewData() {
        
        // Saving the Plain
        defaults.set (plainingTextView.text, forKey: "Plain")
        
        // Saving the Weight
        defaults.set (weightTextField.text, forKey: "Weight")
        
        if self.weightTextField.text != nil && !self.weightTextField.text!.isEmpty {
            let convertedValue = Float(self.weightTextField.text!)
            do {
                try self.dataHandler?.createWeight(value: convertedValue!, date: nil)
            }
            catch DateError.calendarNotFound {
                os_log("[ERROR] Couldn't get the iOS calendar system!")
            }
            catch PersistenceError.cantSave {
                os_log("[ERROR] Couldn't save into local storage due to low memory!")
            }
            catch {
                os_log("[ERROR] Unknown error occurred while registering the weight inside local storage!")
            }
        }
        
    }
    
    
    
    //    MARK: - Style
    func setupStyle() {
        plainingTextView.layer.cornerRadius = 10
    }
}
