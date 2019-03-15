//
//  RepoCD.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/12/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import Foundation
import CoreData
class RepoCD : NSManagedObject{

    @NSManaged public var fork: Bool
    @NSManaged public var full_name: String?
    @NSManaged public var html_url: String?
    @NSManaged public var id: Int64
    @NSManaged public var node_id: String?
    @NSManaged public var repo_description: String?


}

