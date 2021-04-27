//
//  GroceryController.swift
//  GroceryListApp
//
//  Created by Myles Cashwell on 4/23/21.
//

import UIKit

class GroceryController {
    
    //MARK: - Properties
    static let shared = GroceryController()
    var groceries = [Grocery(groceryName: "Milk"),
                     Grocery(groceryName: "Eggs"),
                     Grocery(groceryName: "Spinach"),
                     Grocery(groceryName: "Bellpeppers"),
                     Grocery(groceryName: "Cheese"),
                     Grocery(groceryName: "Bacon"),
                     Grocery(groceryName: "Chicken"),
                     Grocery(groceryName: "Steak"),
                     Grocery(groceryName: "Salmon"),
                     Grocery(groceryName: "Potatos")]
    
    //MARK: - Functions
    func isCompleted(grocery: Grocery) {
        grocery.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    func createGrocery(grocery: String) {
        let newGrocery = Grocery(groceryName: grocery)
        groceries.append(newGrocery)
        saveToPersistenceStore()
    }
    
    func deleteGrocery(grocery: Grocery) {
        guard let groceryToDelete = groceries.firstIndex(of: grocery) else { return }
        groceries.remove(at: groceryToDelete)
        saveToPersistenceStore()
    }
}


//MARK: - Persistence
extension GroceryController {
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = url[0].appendingPathComponent("groceries.json")
        return fileUrl
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(groceries)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            groceries = try JSONDecoder().decode([Grocery].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
