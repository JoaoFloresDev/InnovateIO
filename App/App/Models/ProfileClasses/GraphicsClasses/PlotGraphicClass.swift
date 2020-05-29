//
//  PlotGraphicClass.swift
//  App
//
//  Created by Joao Flores on 30/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import XJYChart
import os.log

class PlotGraphicClass {
    
    var scrollView: UIScrollView!
    var timerGoalsAnimation: Timer!
    private var dataHandler: DataHandler?
    
    
    init() throws {
        do {
            self.dataHandler = try DataHandler.getShared()
        }
        catch {
            throw error
        }
    }
    
    func plotGraphicLine(graphicVIew: UIView, colorLinesArray: [UIColor], datesX: NSMutableArray, numbersArray: [[Int32]], topNumber: Int, bottomNumber: Int) {
        
        var itemArray: [AnyHashable] = []
        
//      Create lines
        for i in 0..<numbersArray.count {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorLinesArray[i])
            itemArray.append(item!)
        }
        
//      Plot graphic
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        configuration.isShowShadow = false
        
        let widthGraphic = graphicVIew.frame.width
        let heightGraphic = graphicVIew.frame.height
        let topNumberGraphic = NSNumber(value: topNumber)
        let bottomNumberGraphic = NSNumber(value: bottomNumber)
        
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: widthGraphic, height: heightGraphic), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: datesX, topNumber: topNumberGraphic, bottomNumber: bottomNumberGraphic, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        
        
        if let views = lineChart?.subviews {
            for viewScroll in views {
                if viewScroll is UIScrollView {
                    if let scroll = viewScroll as? UIScrollView {
                        print(scroll)
                        scrollView = scroll
                        let newOffset = CGPoint(x: scrollView.contentSize.width - graphicVIew.frame.width + 40, y: 0)
                        scrollView.setContentOffset(newOffset, animated: true)
                    }
                }
            }
        }
        
        graphicVIew.addSubview(lineChart!)
    }
    
    func plotGraphicLineAsQualitative(graphicVIew: UIView, colorLinesArray: [UIColor], datesX: NSMutableArray, numbersArray: [[Int32]], topNumber: Int, bottomNumber: Int) {
        
        var itemArray: [AnyHashable] = []
        
        //      Create lines
        for i in 0..<numbersArray.count {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorLinesArray[i])
            itemArray.append(item!)
        }
        
        //      Plot graphic
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        configuration.isShowShadow = false
        
        let widthGraphic = graphicVIew.frame.width
        let heightGraphic = graphicVIew.frame.height
        let topNumberGraphic = NSNumber(value: topNumber)
        let bottomNumberGraphic = NSNumber(value: bottomNumber)
        
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: widthGraphic, height: heightGraphic), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: datesX, topNumber: topNumberGraphic, bottomNumber: bottomNumberGraphic, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        
        
        if let views = lineChart?.subviews {
            for viewScroll in views {
                if viewScroll is UIScrollView {
                    if let scroll = viewScroll as? UIScrollView {
                        print(scroll)
                        scrollView = scroll
                        let newOffset = CGPoint(x: scrollView.contentSize.width - graphicVIew.frame.width + 40, y: 0)
                        scrollView.setContentOffset(newOffset, animated: true)
                    }
                }
            }
        }
        
        graphicVIew.addSubview(lineChart!)
    }
    
    
    func plotGraphicHorizontalBars (view: UIView, greenPercent: Float, yellowPercent: Float) {
        
        let greenView = UIView(frame: CGRect(x: 0, y: 0, width: Int(Float(view.frame.width) * greenPercent), height: Int(view.frame.height)))
        
        let yellowView = UIView(frame: CGRect(x: Int(Float(view.frame.width) * greenPercent), y: 0, width: Int(Float(view.frame.width) * yellowPercent), height: Int(view.frame.height)))
        
        yellowView.backgroundColor = UIColor(named: "rateYellowColor")
        view.backgroundColor = UIColor(named: "rateRedColor")
        greenView.backgroundColor = UIColor(named: "rateGreenColor")
        
        view.addSubview(greenView)
        view.addSubview(yellowView)
        
        StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.height/2))
    }
    
    func setLayoutLegends(views: [UIView]) {
        for view in views {
            StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.width/2))
        }
    }
    
    func generateValues(numLines: Int, datesCount: Int) -> [[Int32]] {
        
        var numbersArray = [[Int32]]()
        
        for _ in 0..<numLines {
            var numberArray = [Int32]()
            
            for _ in 0..<datesCount {
                let num: Int = Int.random(in: 32 ..< 90)
                let number = Int32(num)
                numberArray.append(number)
            }
            numbersArray.append(numberArray)
        }
        
        return numbersArray
    }
    
    
    
    /// Loads the habits values as a tuple containing respectively green percentage and yellow percentage (the red is not necessary) to plot into some chart.
    /// - Throws: Couldn't communicate with the operating system's internal calendar/time system.
    /// - Returns: A tuple containing the percentage respectively for green and yellow (the red is not necessary).
    func loadHabitsAsPercentage() throws -> (Float, Float) {
        
        let daysOfWeek = Date().getAllDaysForWeek()
        
        var greenPercentage: Float = 0.0
        var yellowPercentage: Float = 0.0
        var amountOfGreen: Int = 0
        var amountOfYellow: Int = 0
        
        // Counting the amount of each color per day
        for day in daysOfWeek {

            do {
                // Getting the current day of the week
                let (year, month, day, _, _, _) = try day.getAllInformations()

                do {
                    let entity = try self.dataHandler?.loadDailyDiary(year: year, month: month, day: day)

                    if entity != nil {


                        if entity!.quality == 1 {
                            amountOfGreen += 1
                        }
                        else if entity!.quality == 0 {
                            amountOfYellow += 1
                        }

                    }
                }
                catch {
                    os_log("[WARNING] No entry value for habits chart plotting was found!")
                }
                
            }
            catch {
                throw error
            }
        }
        
        
        // Calculating the percentage based on amount of days in a week
        greenPercentage = Float(amountOfGreen) / 7.0
        yellowPercentage = Float(amountOfYellow) / 7.0

        return (greenPercentage, yellowPercentage)
        
    }
    
    
    
    /// Loads the weights values as a lists of list with type of integer (32 bits) to plot into some chart.
    /// - Throws: Couldn't communicate with the operating system's internal calendar/time system.
    /// - Returns: A list of list with the values for the habits. The index 0 represents the Weights values.
    func loadWeights() throws -> [[Int32]] {
        
        var numbersArray: [[Int32]] = [[]]
        let daysOfWeek = Date().getAllDaysForWeek()
        
        for day in daysOfWeek {
            
            // Getting the current day of the week
            let (year, month, day, _, _, _) = try day.getAllInformations()
            
            // Getting the weight for that day
            var weight: Int32 = 0
            
            do {
                let entity = try self.dataHandler?.loadWeight(year: year, month: month, day: day)
                
                if entity != nil {
                    weight = Int32(entity!.value)
                }
            }
            catch {}
            
            numbersArray[0].append(weight)
        }
        
        return numbersArray
    }
    
    
    
    /// Loads the habits values as a lists of list with type of integer (32 bits) to plot into some chart.
    /// - Throws: Couldn't communicate with the operating system's internal calendar/time system.
    /// - Returns: A list of list with the values for the habits. The index 0 represents the Water value, the index 1 represents the Fruit value and 2 for the Sport.
    func loadHabits() throws -> [[Int32]] {

        let daysOfWeek = Date().getAllDaysForWeek()
        var numbersArray: [[Int32]] = [[], [], []]

        for day in daysOfWeek {

            do {
                // Getting the current day of the week
                let (year, month, day, _, _, _) = try day.getAllInformations()

                // Getting the value for that day according to each category
                var waterConvertedValue: Int32 = 0
                var fruitConvertedValue: Int32 = 0
                var sportConvertedValue: Int32 = 0

                do {
                    let entity = try self.dataHandler?.loadDailyDiary(year: year, month: month, day: day)

                    if entity != nil {


                        if entity!.didDrinkWater {
                            waterConvertedValue = 97
                        }

                        if entity!.didEatFruit {
                            fruitConvertedValue = 97
                        }

                        if entity!.didPracticeExercise {
                            sportConvertedValue = 97
                        }

                    }
                }
                catch {
                    os_log("[WARNING] No entry value for habits chart plotting was found!")
                }

                numbersArray[0].append(waterConvertedValue)
                numbersArray[1].append(fruitConvertedValue)
                numbersArray[2].append(sportConvertedValue)
                
            }
            catch {
                throw error
            }
        }

        return numbersArray
    }
}

