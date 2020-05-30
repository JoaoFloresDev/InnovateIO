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

    //    MARK: - Constants
    let constraintViewInsertIdentifier = "Height"
    let viewInsertWeightHeight: CGFloat = 53
    let timeAnimation = 0.5
    let cornerRadiusViews: CGFloat = 10
    let tagLabelValueWeigh = 1000
//    let tagLabelValueWeigh = 1000
    
    //    MARK: - Variables
    let integerPickerData = (30...120).map { String($0) }
    var decimalPickerData2 = (0...9).map { String($0) }
    var weightDates = [String]()
    var weightValues = [Float]()
    
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
        showCellInsert()
    }
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
        setupPickerView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let presenter = self.presentingViewController?.children[0] as? ProfileViewController {
            presenter.setupGraphic()
        }
    }
    
    //    MARK: - TableView
    func setupTableView() {
        detailsTableview.delegate = self
        detailsTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        setupCells(cell, indexPath)
        
        return cell
    }
    
    func setupCells(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        let valueLabel = cell.viewWithTag(tagLabelValueWeigh) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]]) + "0 Kg"
        
        let dateLabel = cell.viewWithTag(1001) as! UILabel
        dateLabel.text = weightDates[weightDates.count - 1  - indexPath[1]]
        
        let cellViewWithe = cell.viewWithTag(100)!
        cellViewWithe.layer.cornerRadius = 10
    }
    
    // Delete Item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weightDates.remove(at: indexPath.row)
            weightValues.remove(at: indexPath.row)
            detailsTableview.beginUpdates()
            detailsTableview.deleteRows(at: [indexPath], with: .automatic)
            detailsTableview.endUpdates()
        }
    }
    
    //    MARK: - Data Management
    func loadData() {
        do {
            let plotter = try PlotGraphicClass()
            
            let months = plotter.getMonths()
            
            // Getting the current days last two months
            let dates: NSMutableArray = plotter.getFullDates(months)
            
            // Starting to populate and draw the charts...
            let numbersArray: [[Float]] = plotter.getWeightsValuesInt(months)
            
            var datesArray = [String]()
            for x in 0...(dates.count - 1) {
                let aString = dates[x]
                datesArray.append(aString as! String)
            }
            weightDates = datesArray
            weightValues = numbersArray[0]
        }
        catch {
            os_log("[ERROR] Couldn't communicate with the operating system's internal calendar/time system or memory is too low!")
        }
    }
    
//    MARK: - Insert Weight Methods
    func showCellInsert() {
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == constraintViewInsertIdentifier }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: timeAnimation) {
                yourConstraint.constant = self.viewInsertWeightHeight
                self.view.layoutIfNeeded()
            }
        }
        weightTextField.becomeFirstResponder()
    }
    
    func hideCellInsertWeight() {
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "Height" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
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
        hideCellInsertWeight()
        cellViewInsertWeight.layer.cornerRadius = cornerRadiusViews
    }
    
    @objc func cancelDatePicker() {
        print("cancel")
        dismissKeyboard()
        
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "Height" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func doneDatePicker() {
        dismissKeyboard()
        
        let filteredConstraints = viewInsertWeight.constraints.filter { $0.identifier == "Height" }
        if let yourConstraint = filteredConstraints.first {
            UIView.animate(withDuration: 0.5) {
                yourConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }

        do {
            let dataHandler = try DataHandler.getShared()

            let fullName    = weightDateLabel.text!
            let fullNameArr = fullName.components(separatedBy: "/")
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let someDateTime = formatter.date(from: fullNameArr[2]+"/"+fullNameArr[1]+"/"+fullNameArr[0])
            try dataHandler.createWeight(value: convertWeightStringToFloat(), date: someDateTime)
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
        
        weightTextField.text = integerPickerData[rowInteger] + "," + decimalPickerData2[rowDecimal] + " Kg"
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - CONVERTIONS
    func convertWeightStringToFloat() -> Float {
        let valueArray = self.weightTextField.text!.split(separator: ",")
        var convertedValue: Float = 0
        if let integer = Float(valueArray[0]) {
            convertedValue = integer
        }
        
        if let decimal = Float(valueArray[1]) {
            convertedValue = convertedValue + decimal/100
        }
        
        return convertedValue
    }
}
