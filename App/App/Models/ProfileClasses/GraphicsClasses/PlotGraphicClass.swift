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
        
        yellowView.backgroundColor = UIColor(named: "rateYellowColor")
        view.backgroundColor = UIColor(named: "rateRedColor")
        greenView.backgroundColor = UIColor(named: "rateGreenColor")
        
        view.addSubview(greenView)
        view.addSubview(yellowView)
        
        StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.height/2))
    }
    
//    dataLoads
    
    
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
            catch {
                throw error
            }
        }

        return numbersArray
    }
}

