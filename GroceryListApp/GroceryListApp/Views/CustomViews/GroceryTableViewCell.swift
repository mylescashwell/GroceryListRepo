//
//  GroceryTableViewCell.swift
//  GroceryListApp
//
//  Created by Myles Cashwell on 4/23/21.
//

import UIKit

protocol GroceryCellDelegate: class {
    func completionButtonTapped(for cell: GroceryTableViewCell)
}

class GroceryTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var grocery: Grocery? {
        didSet {
            guard let grocery = grocery else { return }
            updateViews(for: grocery)
        }
    }
    
    weak var delegate: GroceryCellDelegate?
    
    
    //MARK: - Outlets
    @IBOutlet weak var grogeryNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    
    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.completionButtonTapped(for: self)
    }
    
    
    //MARK: - Functions
    func updateViews(for grocery: Grocery) {
        grogeryNameLabel.text = grocery.groceryName
        if grocery.isComplete {
            let image = UIImage(named: "complete")
            completionButton.setBackgroundImage(image, for: .normal)
        } else {
            let image = UIImage(named: "incomplete")
            completionButton.setBackgroundImage(image, for: .normal)
        }
    }
}
