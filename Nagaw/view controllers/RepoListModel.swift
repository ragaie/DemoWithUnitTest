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
