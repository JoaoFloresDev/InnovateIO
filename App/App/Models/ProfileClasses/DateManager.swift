//
//  DateManager.swift
//  App
//
//  Created by Joao Flores on 25/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class DateManager {
    func teste() {
        let date1 = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YY"
        var year = Int(formatter.string(from: date1))!
        
        formatter.dateFormat = "MM"
        var month = Int(formatter.string(from: date1))!
        
        let month0 = [month, year]
        month -= 1
        if(month == 0) {
            month = 12
            year -= 1
        }
        
        let month1 = [month, year]
        month -= 1
        if(month == 0) {
            month = 12
            year -= 1
        }
        
        let month2 = [month, year]
        
//        let dateComponents = DateComponents(year: year, month: month)
//        let calendar = Calendar.current
//        let date = calendar.date(from: dateComponents)!
//
//        let range = calendar.range(of: .day, in: .month, for: date)!
//        let numDays = range.count
//        print(year!, month!, numDays)
    }
}
