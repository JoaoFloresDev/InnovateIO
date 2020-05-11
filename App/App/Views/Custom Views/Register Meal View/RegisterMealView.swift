//
//  RegisterMealView.swift
//  App
//
//  Created by Priscila Zucato on 29/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

protocol RegisterMealViewDelegate {
    func saveMeal(quality: Int, hour: Int, minute: Int)
    func presentAlert(_ alert: UIAlertController)
}

class RegisterMealView: UIView {
    @IBOutlet var contentView: RoundedView!
    @IBOutlet weak var thisMealRatingView: RatingView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: RegisterMealViewDelegate?
    var selectedDate: Date = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(R.nib.registerMealView.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setup(delegate: RegisterMealViewDelegate) {
        self.delegate = delegate
        thisMealRatingView.setup()
        setupDatePicker()
    }
    
    func set(meal: Meal) {
        thisMealRatingView.setInitiallySelectedRating(Rating(rawValue: Int(meal.quality)))
        
        let (year, month, day, hour, minute) = (Int(meal.year), Int(meal.month), Int(meal.day), Int(meal.hour), Int(meal.minute))
        datePicker.date = Date.fromComponents(year: year, month: month, day: day, hour: hour, minute: minute) ?? Date()
    }
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 10
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let thisMealRate = thisMealRatingView.selectedRating else {
            let alert = UIAlertController(title: "Atenção!", message: "Selecione uma avaliação para sua refeição.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            delegate?.presentAlert(alert)
            return
        }
        do {
            print(selectedDate)
            let (_, _, _, hour, minute, _) = try selectedDate.getAllInformations()
            
            delegate?.saveMeal(quality: thisMealRate.rawValue, hour: hour, minute: minute)
            
            let alert = UIAlertController(title: "Salvo!", message: "Sua refeição foi registrada.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true)
                self.datePicker.date = Date()
                self.thisMealRatingView.setInitiallySelectedRating(nil)
            }))
            delegate?.presentAlert(alert)
        } catch {
            print("Couldn't get hour and minute from date picker.")
            
            let alert = UIAlertController(title: "Ops!", message: "Algo deu errado, tente novamente!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            delegate?.presentAlert(alert)
        }
    }
}
