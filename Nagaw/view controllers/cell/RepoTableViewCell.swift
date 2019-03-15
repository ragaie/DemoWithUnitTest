//
//  RepoTableViewCell.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/12/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setdata(object : Repo){
        
        nameLabel.text = object.full_name ?? ""
        idLabel.text  = String(object.id ?? 0)//(describing: object.id )
        descriptionLabel.text = object.repo_description ?? ""
    }

}
