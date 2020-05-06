//
//  MealHistoryHeader.swift
//  App
//
//  Created by Priscila Zucato on 07/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealHistoryHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!

    func setup(date: Date) {
        let formatter = DateFormatter()
        let weekday = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        
        titleLabel.text = weekday
    }
}
