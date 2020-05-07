//
//  WeightTests.swift
//  AppTests
//
//  Created by Vinicius Hiroshi Higa on 07/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

@testable import App
import XCTest
import CoreData

class WeightTests: XCTestCase {

    var dataHandler: DataHandler?
    
    override func setUp() {

        do {
            dataHandler = try DataHandler.getShared()
        }
        catch {}
        
    }


    func testCRUD() {
        do {
            try self.create()
            try self.load()
            try self.delete()
        }
        catch {
            XCTFail()
        }
    }
    
    func create() throws {
        
        do {
            try self.dataHandler?.createWeight(weight: 65)
        }
        catch {
            throw error
        }
        
    }
    
    func load() throws {
        
        do {
            _ = try self.dataHandler?.loadWeight(year: 2020, month: 5, day: 7)
        }
        catch {
            throw error
        }
        
    }
    
    func delete() throws {
        
        do {
            try self.dataHandler?.deleteWeight(year: 2020, month: 5, day: 7)
        }
        catch {
            throw error
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
