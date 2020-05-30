//
//  DetailsViewController.swift
//  App
//
//  Created by Joao Flores on 21/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class DetailsWeightViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    //    MARK: - IBOutlet
    @IBOutlet weak var detailsTableview: UITableView!
    @IBOutlet weak var detaisNavigation: UINavigationItem!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightDateLabel: UILabel!
    @IBOutlet weak var viewInsertWeight: UIView!
    @IBOutlet weak var cellViewInsertWeight: UIView!
    
    //    MARK: - IBOutlet
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showInsertWeightView(_ sender: Any) {
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "100" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 53
                self.view.layoutIfNeeded()
            }
        }
        weightTextField.becomeFirstResponder()
    }
    
    
    //    MARK: - Variables
    var titleDetails = "Detalhes"
    
    let integerPickerData = (30...120).map { String($0) }
    var decimalPickerData2 = (0...9).map { String($0) }
    var weightDates = [String]()
    var weightValues = [Int32]()
    
    //    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
        setupPickerView()
        setupStyle()
        detaisNavigation.title = titleDetails
    }
    
    //    MARK: - Style
    func setupStyle() {
        cellViewInsertWeight.layer.cornerRadius = 10
    }
    
    //    MARK: - TableView
    func setupTableView() {
        detailsTableview.delegate = self
        detailsTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            weightDates.remove(at: indexPath.row)
            weightValues.remove(at: indexPath.row)
            detailsTableview.beginUpdates()
            detailsTableview.deleteRows(at: [indexPath], with: .automatic)
            detailsTableview.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let valueLabel = cell.viewWithTag(1000) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]]) + " Kg"
        
        let dateLabel = cell.viewWithTag(1001) as! UILabel
        dateLabel.text = weightDates[weightDates.count - 1  - indexPath[1]]
        
        let cellViewWithe = cell.viewWithTag(100)!
        cellViewWithe.layer.cornerRadius = 10
        
        return cell
    }
    
    func loadData() {
        do {
            let plotter = try PlotGraphicClass()
            
            let months = DateManager().getMonths()
            
            // Getting the current days last two months
            let dates: NSMutableArray = plotter.getDates(months)
            
            // Starting to populate and draw the charts...
            let numbersArray: [[Int32]] = plotter.getWeightsValues(months)
            
            var datesArray = [String]()
            for x in 0...(dates.count - 1) {
                let aString = dates[x]
                let newString = (aString as AnyObject).replacingOccurrences(of: "\n", with: "/")
                datesArray.append(newString)
            }
            weightDates = datesArray
            weightValues = numbersArray[0]
        }
        catch {
            os_log("[ERROR] Couldn't communicate with the operating system's internal calendar/time system or memory is too low!")
        }
    }
    
    //    MARK: - Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //    MARK: - Picker View
    fileprivate func setupPickerView() {
        let thePicker = UIPickerView()
        thePicker.delegate = self
        weightTextField.delegate = self
        weightTextField.inputView = thePicker
        
        var i = 0
        for value in decimalPickerData2 {
            decimalPickerData2[i] = String((Int(value)!) * 10)
            if(decimalPickerData2[i] == "0") {
                decimalPickerData2[i] = "00"
            }
            i = i + 1
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
        selectInitialRowPickerView(thePicker)
        
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "100" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Adicionar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        return toolbar
    }
    
    @objc func cancelDatePicker() {
        print("cancel")
        dismissKeyboard()
        
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "100" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func doneDatePicker() {
        print("doneDatePicker")
        dismissKeyboard()
        
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "100" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
            }
        }

        do {
            let dataHandler = try DataHandler.getShared()
            try dataHandler.createWeight(value: convertWeightStringToFloat(), date: nil)
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
        
        loadData()
        detailsTableview.reloadData()
    }
    
    func convertWeightStringToFloat() -> Float {
        let valueArray = self.weightTextField.text!.split(separator: ",")
        let integer = Float(valueArray[0])
        var convertedValue = integer ?? 0
        
        if let decimal = Float(valueArray[1]) {
            convertedValue = convertedValue + decimal/100
        }
        
        return convertedValue
    }
    
    func selectInitialRowPickerView(_ thePicker: UIPickerView) {
        thePicker.selectRow(Int(weightDates.count - 1), inComponent: 3, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var sizeValue: Int!
        switch component {
        case 0:
            sizeValue = integerPickerData.count
        case 1:
            sizeValue = 1
            
        case 2:
            sizeValue = decimalPickerData2.count
        default:
            sizeValue = weightDates.count
        }
        return sizeValue
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var dataValue: String!
        switch component {
        case 0:
            dataValue = integerPickerData[row]
        case 1:
            dataValue = ","
            
        case 2:
            dataValue = decimalPickerData2[row]
            
        default:
            dataValue = weightDates[row]
        }
        
        return dataValue
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let rowInteger = pickerView.selectedRow(inComponent: 0)
        let rowDecimal = pickerView.selectedRow(inComponent: 2)
        let rowDate = pickerView.selectedRow(inComponent: 3)
        
        weightTextField.text = integerPickerData[rowInteger] + "," + decimalPickerData2[rowDecimal]
        weightDateLabel.text = weightDates[rowDate]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        var sizeValue: CGFloat!
        switch component {
        case 0:
            sizeValue = 50.0
            
        case 1:
            sizeValue = 15.0
            
        case 2:
            sizeValue = 50.0
            
        default:
            sizeValue = 200.0
        }
        return sizeValue
    }
    
    
}
