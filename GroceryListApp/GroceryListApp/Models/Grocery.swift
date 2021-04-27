//
//  Grocery.swift
//  GroceryListApp
//
//  Created by Myles Cashwell on 4/23/21.
//

import UIKit

class Grocery: Codable {
    let groceryName: String
    var isComplete: Bool
    let uuid: String
    
    init(groceryName: String, isComplete: Bool = false, uuid: String = UUID().uuidString) {
        self.groceryName = groceryName
        self.isComplete = isComplete
        self.uuid = uuid
    }
}

//MARK: - Extensions
extension Grocery: Equatable {
    static func == (lhs: Grocery, rhs: Grocery) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
