//
//  RepoListModel.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import UIKit

class RepoListModel: NSObject {
    
    var urlString  : String{
        
        get {
            
            return "https://api.github.com/users/JeffreyWay/repos?page=\(startIndex)&per_page=\(startIndex + 14)"
            
        }
    }
    //= "https://api.github.com/users/JeffreyWay/repos?page=1&per_page=15"
    
    @objc dynamic var dataList : [Repo]? = []
    @objc dynamic var noMoreData = ""
    @objc dynamic var noConnection = ""
    

    var startIndex = 1
    
    func getRepoData(){

                if !Reachability.isConnectedToNetwork(){
               
                    dataList =    DataBaseManger.shared.getList()
                    noMoreData = "Your data offline"
        
                    return
                }
     

            CHNetwork.shared.requestJson(requestWay: .GET, urlString: urlString, Loader: true) { (result, response, error) in
                
                guard let resultData = result else {return}
                
                
                let decoded =   self.parseData(data: resultData)
              
                    if decoded.count > 0 {
                        self.startIndex = self.startIndex + 15
                        self.dataList?.append(contentsOf: decoded)
                      //  DataBaseManger.shared.saveListOfRepo(repoList: decoded)
                    }
                    else{
                        self.noMoreData = "No more data from server"
                    }
          
            }
    
    }
    
        func parseData(data : Data) -> [Repo]{
    
            do {
                let decoded = try JSONDecoder().decode([Repo].self, from: data)
                return decoded
            } catch {
            }
            return []
        }

}
////
////  RepoListController.swift
////  Nagaw
////
////  Created by Ragaie Alfy on 3/11/19.
////  Copyright © 2019 Ragaie Alfy. All rights reserved.
////
//
//import UIKit
//
//class RepoListController: NSObject {
//    
//    
//    weak var myView :  RepoListView?
//    var startIndex = 1
//    
//    var urlString  : String{
//        
//        get {
//            
//            return "https://api.github.com/users/JeffreyWay/repos?page=\(startIndex)&per_page=\(startIndex + 14)"
//            
//        }
//    }
//    //= "https://api.github.com/users/JeffreyWay/repos?page=1&per_page=15"
//    
//    var dataList : [Repo]? = []
//    var noMoreData = ""
//    var noConnection = ""
//    override init() {
//        super.init()
//        DispatchQueue.main.async {
//            self.getRepoData()
//            
//        }
//        
//    }
//    
//    func getRepoData(){
//        
//        if !Reachability.isConnectedToNetwork(){
//            self.dataList =    DataBaseManger.shared.getList()
//            myView?.setMessage(text: "Your data offline")
//            myView?.showLoader(show: true)
//            myView?.reposTableView.reloadData()
//            return
//        }
//        
//        
//        CHNetwork.shared.requestJson(requestWay: .GET, urlString: urlString, Loader: true) { (result, response, error) in
//            self.myView?.showLoader(show: true)
//            
//            guard let resultData = result else {
//                self.myView?.showLoader(show: true)
//                
//                return
//            }
//            let decoded =   self.parseData(data: resultData)
//            if decoded.count > 0 {
//                self.startIndex = self.startIndex + 15
//                self.dataList?.append(contentsOf: decoded)
//                self.myView?.reposTableView.reloadData()
//                
//                //  DataBaseManger.shared.saveListOfRepo(repoList: decoded)
//            }
//            else{
//                self.myView?.setMessage(text: "No more data from server")
//            }
//        }
//        
//    }
//    
//    func checkNetworkCase(){
//        //device offline
//        if !Reachability.isConnectedToNetwork(){
//            myView?.setMessage(text: "Your data offline")
//            myView?.showLoader(show: true)
//            self.dataList =    DataBaseManger.shared.getList()
//            self.noMoreData = "Your data offline"
//            
//            return
//        }
//        
//    }
//    
//    func parseData(data : Data) -> [Repo]{
//        
//        do {
//            let decoded = try JSONDecoder().decode([Repo].self, from: data)
//            return decoded
//        } catch {
//        }
//        return []
//    }
//    
//    
//    
