//
//  ItemTableViewController.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 15/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    
    
    
    let cellManager = CellManager()
    let networkManager = NetworkManager()
    var category: String!
    var menuItems = [MenuItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = category.localizedCapitalized
        networkManager.getMenuItems(for: category) { menuItems, error in
            guard let menuItems = menuItems else {return}
            self.menuItems = menuItems
            print(self.menuItems)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")! as? MenuCell
        
        cellManager.configureForMenu(cell!, with: menuItems[indexPath.row], for: tableView, indexPath: indexPath)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "ItemSegue" else {return}
        guard let menuItemIndex = tableView.indexPathForSelectedRow else {return}
        let destination = segue.destination as? itemViewController
        destination?.menuItem = menuItems[menuItemIndex.row]
        
    }
}
