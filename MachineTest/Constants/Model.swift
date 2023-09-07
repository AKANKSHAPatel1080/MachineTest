//
//  Model.swift
//  MachineTest
//
//  Created by Akanksha Patel on 06/09/23.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]

    enum CodingKeys: String, CodingKey {
        case articles
    }
}

struct Article: Codable {
    let title: String
    let url: String
    let imageURL: String?
    

    enum CodingKeys: String, CodingKey {
        case title
        case url
        case imageURL = "urlToImage"
        
    }
}
