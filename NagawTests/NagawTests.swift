//
//  NagawTests.swift
//  NagawTests
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//


///this class for test repo list (view,controller,model)
import XCTest
@testable import Nagaw

class NagawTests: XCTestCase {

    
    
    var repoListView : RepoListView!
    
    var modelLayer : RepoListModel!
    var repoController : RepoListController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        repoListView =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RepoListScreenID") as? RepoListView
        repoListView.loadView()
        

        modelLayer = RepoListModel()
        repoController = RepoListController()
        repoListView.reposTableView.delegate = repoController
        repoListView.reposTableView.dataSource = repoController
        repoController.myView = repoListView
        repoController.myModel = modelLayer
        

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        repoListView = nil
        repoController = nil
    }

 
    func testMyView() {
        
        XCTAssertNotNil(repoListView.view)
        XCTAssertNotNil(repoListView.reposTableView)
        
        repoListView.showLoader(show: true)
        XCTAssertEqual(repoListView.activityIndecator.isHidden, true)
        XCTAssertEqual(repoListView.messageLabel.isHidden, false)
        
        repoListView.showLoader(show: false)
        XCTAssertEqual(repoListView.activityIndecator.isHidden, false)
        XCTAssertEqual(repoListView.messageLabel.isHidden, true)
        
        repoListView.setMessage(text: "Hello")
        
       // XCTAssertNotNil(repoListView.myController)

        XCTAssertEqual(repoListView.messageLabel.text, "Hello")

        XCTAssertNotNil( repoListView.dequeueReusableCell(indexPath:  IndexPath.init(row: 0, section: 0) ))
     
    }
    
    
    
    
    func testMyController() {
        
        
        XCTAssertNotNil(repoController.myView)

        XCTAssertNotNil(repoController.conforms(to : UITableViewDelegate.self))
        XCTAssertNotNil(repoController.conforms(to : UITableViewDataSource.self))
        
        let  repo = Repo()
        repo.id = 3
        repo.full_name = "dfsfsdf"
        repo.fork = false
        
        modelLayer.dataList = [repo]
        
      //  modelLayer.getRepoData()
        let tableView = repoController.myView!.reposTableView
        tableView?.reloadData()
        
        // Check the number of table rows
        XCTAssertEqual(1, tableView?.dataSource?.tableView(tableView!, numberOfRowsInSection: 0))
        
        // Check label text of the cell in the first row
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = tableView?.dataSource?.tableView(tableView!, cellForRowAt: indexPath) as! RepoTableViewCell
        XCTAssertEqual("dfsfsdf", cell.nameLabel.text)
        
    }
    
    
    
    
  // test model layer 
    func testparseFunc() {
        
        let file = "response.json"
        var contentData :Data!
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                contentData = data
                
            } catch let error{
                // handle error
                
            }
        }

        
        XCTAssertEqual(modelLayer.parseData(data: contentData).count, 15)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
