//
//  CellManager.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 15/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit
class CellManager {
    let networkManager = NetworkManager()
    func configure(_ cell: UITableViewCell, with category: String) {
        cell.textLabel?.text = category.localizedCapitalized
    }
    
    func configure(
        _ cell: UITableViewCell,
        with menuItem: MenuItem,
        for tableView: UITableView,
        indexPath: IndexPath
        ) {
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(menuItem.price)
        
        if let imageData = menuItem.image {
            cell.imageView?.image = UIImage(data: imageData) } else {
            
            networkManager.getImage(menuItem.image_url) { data, error in
                
                menuItem.image = data
                DispatchQueue.main.async {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
                
            }
            
        }
        
    }
    
 
}


