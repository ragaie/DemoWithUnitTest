//
//  RepoListController.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import UIKit

class RepoListController: NSObject {

    
    weak var myView :  RepoListView?
    @objc var myModel : RepoListModel?
    
    override init() {
        
        super.init()
   
        myModel = RepoListModel()
        addObserver(self, forKeyPath: #keyPath(myModel.dataList), options: [.old, .new], context: nil)
        addObserver(self, forKeyPath: #keyPath(myModel.noMoreData), options: [.old, .new], context: nil)
        DispatchQueue.main.async {
            self.myModel?.getRepoData()

        }

    }
   //notify contoller when data update from model
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(myModel.noMoreData) {
            myView?.showLoader(show: true)
            myView?.setMessage(text: myModel!.noMoreData)
            
        }
        
        if keyPath == #keyPath(myModel.dataList) {
            myView?.showLoader(show: true)
            myView?.reposTableView.reloadData()

            DataBaseManger.shared.saveListOfRepo(repoList: myModel?.dataList ?? [])

        }
    }
    
    
  
    
    
    
    
    
    
    
}

extension RepoListController  : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel?.dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = myView?.dequeueReusableCell(indexPath: indexPath) as! RepoTableViewCell
        cell.setdata(object: myModel!.dataList![indexPath.row]  )
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  
        if myModel!.startIndex  - 1 ==  myModel!.dataList!.count{
            if (myModel!.dataList!.count - indexPath.row ) == 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if tableView.visibleCells.contains(cell) {
                        
                        self.myView?.showLoader(show: false)
                        self.myModel?.getRepoData()

                    }
                }
                
            }
        }
        
        
        
    }
    
    
    
    
}
