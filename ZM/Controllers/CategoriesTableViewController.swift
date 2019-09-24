//
//  CategoriesTableViewController.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 15/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    let network = NetworkManager()
    var categories = [String]()
    let cellManager = CellManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.getCategories {categories, error  in
            guard let categories = categories else {return}
            self.categories = categories
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MenuSegue" else { return }
        guard let categoryIndex = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! MenuTableViewController
        destination.category = categories[categoryIndex.row]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cellManager.configure(cell!, with: categories[indexPath.row])
        return cell!
    }
    
}
