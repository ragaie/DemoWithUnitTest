//
//  ViewController.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import UIKit

class RepoListView: UIViewController {

    var myController : RepoListController?
    var repoCellID = "RepoCellID"
    
    @IBOutlet weak var reposTableView: UITableView!
    
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    var message: String{
        get{
            return message
        }
        set {
            
            print("dddddd")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myController = RepoListController()
        myController?.myView = self
        reposTableView.delegate = myController
        reposTableView.dataSource = myController
        // Do any additional setup after loading the view, typically from a nib.
    }

    func    dequeueReusableCell (indexPath : IndexPath)-> UITableViewCell {
        
        return  reposTableView.dequeueReusableCell(withIdentifier: repoCellID, for: indexPath)
        
    }

   @objc func showLoader(show : Bool){
        if show{
            messageLabel.isHidden = false
        }
        else {
            messageLabel.isHidden = true

            
        }
       activityIndecator.isHidden = show
        
        
        
    }

    
  @objc  func setMessage(text : String){
        messageLabel.text = text
    
    
    }
}

