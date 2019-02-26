//
//  GetPeopleResponse.swift
//  DecodeFailable_Example
//
//  Created by George Marmaridis on 17.01.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import DecodeFailable

struct GetPeopleResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case people
    }
    let people: [Person]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.people = try container.decode(DecodeFailableArray<Person>.self, forKey: .people).elements
    }
}

struct Person: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case age
        case isMarried = "married"
    }
    
    let id: String
    let firstName: String
    let lastName: String
    let age: Int
    let isMarried: Bool
}
