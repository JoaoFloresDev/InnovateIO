//
//  EditDataViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log
import NumericPicker

class EditDataViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: - Variables
    var defaults = UserDefaults.standard
    
    // MARK: - IBOutlets
    // Interface builder outlets
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var plainingTextView: UITextView!
    
    //MARK: - Variables
    // Private properties related to the Edit View
    private var dataHandler: DataHandler?
    let integerPickerData = (30...120).map { String($0) }
    var decimalPickerData2 = (0...9).map { String($0) }
    
    //    MARK: - IBAction
    
    /// Saves the new data into local storage.
    /// - Parameter sender: The tap action.
    @IBAction func saveViewController(_ sender: Any) {
        saveNewData()
        self.dismiss(animated: true, completion: nil)
        updateDataProfile()
        
        if let presenter = self.presentingViewController?.children[0] as? ProfileViewController {
            presenter.setupGraphic()
        }
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
        setupPickerView()
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
            let valueArray = self.weightTextField.text!.split(separator: ",")
            let integer = Float(valueArray[0])
            var convertedValue = integer ?? 0
            
            if let decimal = Float(valueArray[1]) {
                convertedValue = convertedValue + decimal/100
            }
            
            do {
                try self.dataHandler?.createWeight(value: convertedValue, date: nil)
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
    
    //    MARK: - Picker View
    fileprivate func setupPickerView() {
        let thePicker = UIPickerView()
        thePicker.delegate = self
        weightTextField.inputView = thePicker
        
        var i = 0
        for value in decimalPickerData2 {
            decimalPickerData2[i] = String((Int(value)!) * 10)
            if(decimalPickerData2[i] == "0") {
                decimalPickerData2[i] = "00"
            }
            i = i + 1
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var sizeValue: Int!
        switch component {
        case 0:
            sizeValue = integerPickerData.count
        case 1:
            sizeValue = 1
        default:
            sizeValue = decimalPickerData2.count
        }
        return sizeValue
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var dataValue: String!
        switch component {
        case 0:
            dataValue = integerPickerData[row]
        case 1:
            dataValue = ","
        default:
            dataValue = decimalPickerData2[row]
        }
        
        return dataValue
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let rowInteger = pickerView.selectedRow(inComponent: 0)
        let rowDecimal = pickerView.selectedRow(inComponent: 2)
        
        weightTextField.text = integerPickerData[rowInteger] + "," + decimalPickerData2[rowDecimal]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40.0
    }
}
