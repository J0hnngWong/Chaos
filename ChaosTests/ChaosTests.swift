//
//  ChaosTests.swift
//  ChaosTests
//
//  Created by john on 2023/3/14.
//

import XCTest
import CoreData
@testable import Chaos

final class ChaosTests: XCTestCase {
    
    let container = PersistentContainer.main

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        saveTimeRecord(start: Date.now.timeIntervalSince1970, end: Date.now.timeIntervalSince1970, detail: "detail with time: \(Date.now.timeIntervalSince1970)")
        let allRecord = try readTimeRecord()
        print(allRecord)
        allRecord.forEach({ deleteTimeRecord(id: $0.objectID) })
        let afterDeleteRecord = try readTimeRecord()
        print(afterDeleteRecord)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func saveTimeRecord(start: TimeInterval, end: TimeInterval, detail: String) {
        let entities = container.managedObjectModel.entitiesByName
        if let timeRecordEntity = entities["TimeRecord"] {
            let record = TimeRecord(entity: timeRecordEntity, insertInto: container.viewContext)
            record.startTimestamp = start
            record.endTimestamp = end
            record.duration = end - start
            record.detail = detail
            record.timestamp = Date.now.timeIntervalSince1970
        }
        
        container.saveContext()
    }
    
    func deleteTimeRecord(id: NSManagedObjectID) {
        let result = container.viewContext.object(with: id)
        container.viewContext.delete(result)
        container.saveContext()
    }
    
    func readTimeRecord() throws -> [TimeRecord] {
//      let predicate = NSPredicate(format: "age > 10")
        let request = NSFetchRequest<TimeRecord>(entityName: "TimeRecord")
//        request.predicate = predicate
        do {
            let result = try container.viewContext.fetch(request)
            return result
        } catch let e {
            print(e.localizedDescription)
            throw e
        }
    }
}
