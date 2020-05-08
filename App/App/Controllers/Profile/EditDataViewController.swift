//
//  EditDataViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class EditDataViewController: ViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: - Variables
    var defaults = UserDefaults.standard
    
    //    MARK: - IBOutlets
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var plainingTextView: UITextView!
    
    //    MARK: - IBAction
    
    @IBAction func saveViewController(_ sender: Any) {
        saveNewData()
        self.dismiss(animated: true, completion: nil)
        updateDataProfile()
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearGoals(_ sender: Any) {
        plainingTextView.text = ""
    }
    
    //    MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupStyle()
        
        let thePicker = UIPickerView()
        weightTextField.inputView = thePicker
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
    
    let myPickerData = ["Peter", "Jane", "Paul", "Mary", "Kevin", "Lucy"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return myPickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightTextField.text = myPickerData[row]
    }
}
