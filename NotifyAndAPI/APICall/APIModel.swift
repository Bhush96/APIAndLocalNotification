//
//  APIModel.swift
//  NotifyAndAPI
//
//  Created by Bhushan Tambe on 07/04/23.
//

import Foundation

// MARK: - Welcome
struct Response : Codable {
    let type: String
    let value: [Value]
}

// MARK: - Value
struct Value : Codable {
    let id: Int
    let joke: String
    let categories: [String]
}
