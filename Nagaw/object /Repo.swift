//
//  Repo.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import Foundation

import CoreData
class Repo : NSObject, Codable{
    
     var  id : Int?
    var node_id : String?
    var full_name : String?
    var html_url : String?
    var repo_description : String?
    var fork : Bool?
    
    
    
    
     enum CodingKeys : String, CodingKey {
        case id, node_id = "zip_code", full_name, html_url ,repo_description = "description", fork
    }
    
//
//    // MARK: - Decodable
//    required convenience init(from decoder: Decoder) throws {
//       guard let entity = NSEntityDescription.entity(forEntityName: "Repo", in: DataBaseManger.shared.managedContext) else { return}
//
//
//        self.init(entity: entity, insertInto: DataBaseManger.shared.managedContext)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decodeIfPresent(String.self, forKey: .id)
//        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
//        self.html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
//    }
//
////
//    // MARK: - Encodable
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(full_name, forKey: .full_name)
//        try container.encode(html_url, forKey: .html_url)
//    }
}
