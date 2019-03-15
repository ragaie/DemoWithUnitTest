//
//  CoreDataTest.swift
//  NagawTests
//
//  Created by Ragaie Alfy on 3/14/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//



import XCTest

@testable import Nagaw
import CoreData
class CoreDataTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

         var managedObjectModel: NSManagedObjectModel = {
            let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
            return managedObjectModel
        }()
        
         var mockPersistantContainer: NSPersistentContainer = {
            
            let container = NSPersistentContainer(name: "Nagaw.xcdatamodeld", managedObjectModel: managedObjectModel)
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false // Make it simpler in test env
            
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (description, error) in
                // Check if the data store is in memory
                precondition( description.type == NSInMemoryStoreType )
                
                // Check if creating container wrong
                if let error = error {
                    fatalError("Create an in-mem coordinator failed \(error)")
                }
            }
            return container
        }()
        
        
        
        DataBaseManger.shared.managedContext =  mockPersistantContainer.viewContext
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      //  sut.flushData()
    }

    func testInsert() {
       
        let  repo = Repo()
        repo.id = 3
        repo.full_name = "dfsfsdf"
        repo.fork = false
       // let todo = sut.insertItem(item: repo)
        
        
      let result =   DataBaseManger.shared.insertItem(item: repo)
        
        XCTAssertEqual(result, nil)
        
    }
    func testItemAvailable() {
       
        let  repo = Repo()
        repo.id = 3
        repo.full_name = "dfsfsdf"
        repo.fork = false
        // let todo = sut.insertItem(item: repo)
        
        
         DataBaseManger.shared.insertItem(item: repo)
        
        let result =   DataBaseManger.shared.existRepoObject(object: repo)
        //Assert return five todo items
        XCTAssertEqual(result, false)
        
    }
    
 
    func test_fetch_all_Repo() {
        
        //Given a storage with two todo
        //When fetch
        
        
        let  repo = Repo()
        repo.id = 3
        repo.full_name = "dfsfsdf"
        repo.fork = false
        // let todo = sut.insertItem(item: repo)
        
        
        DataBaseManger.shared.insertItem(item: repo)
        
        let list  =   DataBaseManger.shared.getList()

        
        //Assert return five todo items
        XCTAssertEqual(list.count, 1)
        
    }
    
    
    
    
    func test_Delete_all_Repo() {
        
        //Given a storage with two todo
        //When fetch
        
        
        
        let  repo = Repo()
        repo.id = 3
        repo.full_name = "dfsfsdf"
        repo.fork = false
        // let todo = sut.insertItem(item: repo)
        
        
        DataBaseManger.shared.insertItem(item: repo)
        
        DataBaseManger.shared.flushData()
        let results = DataBaseManger.shared.getList()

    
         XCTAssertEqual(results.count, 0)


    }
}
