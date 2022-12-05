//
//  User.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import Foundation


struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let address: Address
}


struct Address: Codable {
    let street: String
    let suite: String
    let zipcode: String
    let city: String
}
