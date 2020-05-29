//
//  DateManager.swift
//  App
//
//  Created by Joao Flores on 25/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class DateManager {
    func getMonths() -> [[Int]]{
        let date1 = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY"
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
        
        return [month2, month1, month0]
    }
}
