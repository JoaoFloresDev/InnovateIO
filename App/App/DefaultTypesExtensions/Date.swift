//
//  TimeInterval+HoursAndMinutes.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 22/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation

extension Date {
    
    
    /// Gets all date information from today  (a.k.a Year, Month, Day, Hour, Minute and Second)
    /// - Returns: An optional tuple with the following order: Year, Month, Day, Hour, Minute and Second
    func getAllInformations() -> (Int?, Int?, Int?, Int?, Int?, Int?) {
        
        // Setting the current date
        let date = Date()
        
        // Getting the User's calendar
        let calendar = Calendar.current
        
        // Mounting the request for the Calendar
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // Getting the components from the Calendar
        let dateComponents = calendar.dateComponents(requestedComponents, from: date)
        
        return (dateComponents.year, dateComponents.month, dateComponents.day,
                dateComponents.hour, dateComponents.minute, dateComponents.second)
        
    }
    
    
    
    /// Gets all date information from a given date (a.k.a Year, Month, Day, Hour, Minute and Second)
    /// - Parameter date: The desired Date object
    /// - Returns: An optional tuple with the following order: Year, Month, Day, Hour, Minute and Second
    func getAllInformations(from date: Date) -> (Int?, Int?, Int?, Int?, Int?, Int?) {
        
        // Getting the User's calendar
        let calendar = Calendar.current
        
        // Mounting the request for the Calendar
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // Getting the components from the Calendar
        let dateComponents = calendar.dateComponents(requestedComponents, from: date)
        
        return (dateComponents.year, dateComponents.month, dateComponents.day,
                dateComponents.hour, dateComponents.minute, dateComponents.second)
        
    }
    
}
