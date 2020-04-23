//
//  Meal.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation

extension Meal {
    
    // Overrided functions or "clone" of the non-overridable functions here...
    
    /// Checks if two objects have the same values for the attributes.
    /// - Parameter object: An object to be compared
    /// - Returns: A boolean saying if it's the same or not (It doesn't matter the memory address / reference here)
    public func isAlmostEqual(_ object: Any?) -> Bool {
        
        // Validating the type of the object
        guard let meal = object as? Meal else {
            return false
        }
        
        // Validating the date
        if meal.year != self.year || meal.month != self.month || meal.day != self.day {
            return false
        }
        
        // Validating the time
        if meal.hour != self.hour || meal.minute != self.minute {
            return false
        }
        
        // Validating the quality
        if meal.quality != self.quality {
            return false
        }
        
        return true
    }
    
}
