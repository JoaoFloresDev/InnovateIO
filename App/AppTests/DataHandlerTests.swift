//
//  DataLoaderTests.swift
//  AppTests
//
//  Created by Vinicius Hiroshi Higa on 22/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

@testable import App
import XCTest

class DataHandlerTests: XCTestCase {

    var dataHandler: DataHandler?
    
    override func setUp() {
        
        do {
            self.dataHandler = try DataHandler.getShared()
        }
        catch {}
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataCreation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do {
            try self.dataHandler?.createDailyDiary(quality: 1, meal: Meal())
        }
        catch {
            print((error as! PersistenceError) == PersistenceError.cantSave)
            XCTFail()
        }
        
        
    }
    
    func testDataLoad() {
        
        do {
            let result = try self.dataHandler?.loadDailyDiary(year: 2020, month: 4, day: 22)
            print("Was found a register in day: \(String(describing: result!.day))")
        }
        catch {
            print((error as! PersistenceError) == PersistenceError.cantSave)
            XCTFail()
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
