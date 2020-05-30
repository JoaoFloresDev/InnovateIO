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
        configuration.isShowShadow = true
        configuration.isEnableNumberAnimation = false
        
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
        
        yellowView.backgroundColor = R.color.mediumColor()
        view.backgroundColor = R.color.badColor()
        greenView.backgroundColor = R.color.goodColor()
        
        view.addSubview(greenView)
        view.addSubview(yellowView)
        
        StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.height/2))
    }
    
    func getWeightsValues(_ months: [[Int]]) -> [[Int32]]{
        var numbersArray: [[Int32]] = [[]]
        for month in months {
            let dateComponents = DateComponents(year: month[1], month: month[0])
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            var numDays = range.count
            var firstDayMonth = 1
            if(month[0] == months[2][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                numDays = Int(format.string(from: date))!
            }
            else if(month[0] == months[0][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                firstDayMonth = Int(format.string(from: date))!
            }
            for day in firstDayMonth...numDays {
                // Getting the weight for that day
                var weight: Int32 = 0
                
                do {
                    let entity = try self.dataHandler?.loadWeight(year: month[1], month: month[0], day: day)
                    
                    if entity != nil {
                        weight = Int32(entity!.value)
                    }
                }
                catch {}
                
                numbersArray[0].append(weight)
            }
        }
        return numbersArray
    }
    
    func getHabitsValues(_ months: [[Int]]) -> [[Int32]]{
        var numbersArray: [[Int32]] = [[], [], []]
        for month in months {
            let dateComponents = DateComponents(year: month[1], month: month[0])
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            var numDays = range.count
            var firstDayMonth = 1
            if(month[0] == months[2][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                numDays = Int(format.string(from: date))!
            }
            else if(month[0] == months[0][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                firstDayMonth = Int(format.string(from: date))!
            }
            for day in firstDayMonth...numDays {
                // Getting the weight for that day
                var waterConvertedValue: Int32 = 0
                var fruitConvertedValue: Int32 = 0
                var sportConvertedValue: Int32 = 0

                do {
                    let entity = try self.dataHandler?.loadDailyDiary(year: month[1], month: month[0], day: day)

                    if entity != nil {


                        if entity!.didDrinkWater {
                            waterConvertedValue = 1
                        }

                        if entity!.didEatFruit {
                            fruitConvertedValue = 1
                        }

                        if entity!.didPracticeExercise {
                            sportConvertedValue = 1
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
        }
        return numbersArray
    }
    
    func getWeightsValuesInt(_ months: [[Int]]) -> [[Float]]{
        var numbersArray: [[Float]] = [[]]
        for month in months {
            let dateComponents = DateComponents(year: month[1], month: month[0])
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            var numDays = range.count
            var firstDayMonth = 1
            if(month[0] == months[2][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                numDays = Int(format.string(from: date))!
            }
            else if(month[0] == months[0][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                firstDayMonth = Int(format.string(from: date))!
            }
            for day in firstDayMonth...numDays {
                // Getting the weight for that day
                var weight: Float = 0.0
                
                do {
                    let entity = try self.dataHandler?.loadWeight(year: month[1], month: month[0], day: day)
                    
                    if entity != nil {
                        weight = entity!.value
                    }
                }
                catch {}
                
                numbersArray[0].append(weight)
            }
        }
        return numbersArray
    }
    
    func getDates(_ months: [[Int]]) -> NSMutableArray {
        let dates: NSMutableArray = []
        for month in months {
            let dateComponents = DateComponents(year: month[1], month: month[0])
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            var numDays = range.count
            var firstDayMonth = 1
            if(month[0] == months[2][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                numDays = Int(format.string(from: date))!
            }
            else if(month[0] == months[0][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                firstDayMonth = Int(format.string(from: date))!
            }
            for day in firstDayMonth...numDays {
                dates.add("\(day)\n\(month[0])")
            }
        }
        return dates
    }
    
    func getFullDates(_ months: [[Int]]) -> NSMutableArray {
        let dates: NSMutableArray = []
        for month in months {
            let dateComponents = DateComponents(year: month[1], month: month[0])
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: date)!
            var numDays = range.count
            var firstDayMonth = 1
            if(month[0] == months[2][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                numDays = Int(format.string(from: date))!
            }
            else if(month[0] == months[0][0]) {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd"
                firstDayMonth = Int(format.string(from: date))!
            }
            for day in firstDayMonth...numDays {
                dates.add("\(day)" + "/" + "\(month[0])" + "/" + "\(month[1])")
            }
        }
        return dates
    }
    
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

