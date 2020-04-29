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
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 10
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
        } catch {
            print("Couldn't get hour and minute from date picker.")
        }
    }
}
