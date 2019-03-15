//
//  DataBaseManger.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/12/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DataBaseManger: NSObject {
    
    override init() {
        super.init()
      
    }
    
    
    static var shared : DataBaseManger = DataBaseManger()
    var managedContext : NSManagedObjectContext!
    
    func setManagedContext (container : NSPersistentContainer){
        managedContext = container.viewContext
        
    }
    
    
    func existRepoObject(object : Repo) ->Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "RepoCD")
        fetchRequest.predicate = NSPredicate(format: "id = %d", object.id!)
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                
                return  false
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        return true
    }
    
    
    
    
    
    func saveListOfRepo( repoList : [Repo]){
        
        
        
        for item in repoList{
          //  existRepoObject(object: item)
            if  existRepoObject(object: item) {
                insertItem(item: item)
            }
        }
        
      
        
        
    }

    
    
    
    
    
    func insertItem( item : Repo)-> NSError?{
        
        
        
        let repo = NSEntityDescription.insertNewObject(forEntityName: "RepoCD", into: managedContext)
        
        repo.setValue(item.id, forKey: "id")
        repo.setValue(item.fork, forKey: "fork")
        repo.setValue(item.full_name, forKey: "full_name")
        repo.setValue(item.node_id, forKey: "node_id")
        repo.setValue(item.html_url, forKey: "html_url")
        repo.setValue(item.repo_description, forKey: "repo_description")
        
        
        do {
            try managedContext.save()
            return nil
        } catch let error as NSError {
            return error
            print("error saving data \(error)")
        }
        
        
    }
    
    
    
    
    
    
    
    func getList()-> [Repo]{
        
        var list : [Repo] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "RepoCD")
        do {
            let result =   try managedContext.fetch(fetchRequest)
            
            for item in result as! [NSManagedObject]{
                var tempRepo = Repo()
                tempRepo.fork = item.value(forKey: "fork") as? Bool
                tempRepo.id = item.value(forKey: "id") as? Int
                tempRepo.full_name = item.value(forKey: "full_name") as? String
                tempRepo.html_url = item.value(forKey: "html_url") as? String
                tempRepo.repo_description = item.value(forKey: "repo_description") as? String
                tempRepo.repo_description = item.value(forKey: "repo_description") as? String
                
                list.append(tempRepo)
                
            }
            
        } catch  {
            print("fail to fetch")
        }
        
        return list
    }
    
    
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "RepoCD")
        let objs = try! managedContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            managedContext.delete(obj)
        }
        try! managedContext.save()
        
    }
}
