//
//  DataModel.swift
//  TechieButler
//
//  Created by Ravindra Arya on 03/05/24.
//

import Foundation

struct DataModel: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

