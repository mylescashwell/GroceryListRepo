//
//  GroceryListTableViewController.swift
//  GroceryListApp
//
//  Created by Myles Cashwell on 4/23/21.
//

import UIKit

class GroceryListTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GroceryController.shared.loadFromPersistenceStore()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a grocery item!", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "What do we need?"
        }
        
        let doneAction = UIAlertAction(title: "Add", style: .cancel) { (_) in
            guard let newGrocery = alertController.textFields?.first?.text, !newGrocery.isEmpty else { return }
            GroceryController.shared.createGrocery(grocery: newGrocery)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroceryController.shared.groceries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as? GroceryTableViewCell else { return UITableViewCell()}
        
        let grocery = GroceryController.shared.groceries[indexPath.row]
        cell.grocery = grocery
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groceryToDelete = GroceryController.shared.groceries[indexPath.row]
            GroceryController.shared.deleteGrocery(grocery: groceryToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


//MARK: - Extension
extension GroceryListTableViewController: GroceryCellDelegate {
    func completionButtonTapped(for cell: GroceryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let grocery = GroceryController.shared.groceries[indexPath.row]
        GroceryController.shared.isCompleted(grocery: grocery)
        cell.updateViews(for: grocery)
    }
}
