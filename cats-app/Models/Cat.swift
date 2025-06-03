//
//  Cat.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import Foundation

struct Cat: Decodable {
    let id: String
    let tags: [String]
    //let mimeType: String
    let createdAt: String
    
    init(id: String, tags: [String], createdAt: String) {
            self.id = id
            self.tags = tags
            self.createdAt = createdAt
        }
}
