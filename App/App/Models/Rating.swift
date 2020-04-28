//
//  Ratings.swift
//  App
//
//  Created by Priscila Zucato on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

enum Rating: String {
    case bad = "Ruim"
    case average = "Médio"
    case good = "Bom"
    
    var color: UIColor? {
        switch self {
        case .bad:      return R.color.badColor()
        case .average:  return R.color.mediumColor()
        case .good:     return R.color.goodColor()
        }
    }
}
