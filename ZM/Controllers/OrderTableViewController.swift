//
//  OrderTableViewController.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 21/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


class OrderTableViewController: UITableViewController {
    
    //MARK: Public properties
    
    var networkManager = NetworkManager()
    var cellManager = CellManager()
    var minutes = 0
    
    //MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(UITableView.reloadData),
            name: OrderManager.orderUpdatedNotification,
            object: nil
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "OrderConfirmationSegue" else { return }
        let destination = segue.destination as! OrderConfirmationViewController
        destination.minutes = minutes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.shared.order.MenuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderItem = OrderManager.shared.order.MenuItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell")! as? OrderCell
        
        cellManager.configureForOrder(cell!, with: orderItem, for: tableView, indexPath: indexPath)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            OrderManager.shared.order.MenuItems.remove(at: indexPath.row)
            let count = OrderManager.shared.order.MenuItems.count
            if count != 0 { AppDelegate.orderTabBarItem.badgeValue = "\(count)" } else {AppDelegate.orderTabBarItem.badgeValue = nil }
        case .insert:
            break
        case .none:
            break
        default:
            break
        }
        
    }
    
    //MARK: IBActions
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        OrderManager.shared.order = Order()
    }
    
    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal = OrderManager.shared.order.MenuItems.reduce(0) { $0 + $1.price }
        if OrderManager.shared.order.MenuItems.count == 0 {
            let alert = UIAlertController(title: "ERROR", message: "Please add food in order", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(
                title: "Confirm Order",
                message: "You are about to submit your order with a total of \(orderTotal)",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { _ in
                self.uploadOrder()
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
    }

    //MARK: Publish methods
    
    func uploadOrder() {
        let menuIDs = OrderManager.shared.order.MenuItems.map { $0.id }
        networkManager.submitOrder(forMenuIDs: menuIDs) { minutes, error in
            if let error = error {
                print(#line, #function, "ERROR: \(error.localizedDescription)")
            } else {
                guard let minutes = minutes else {
                    print(#line, #function, "ERROR: didn't get minutes from server")
                    return
                }
                self.minutes = minutes
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "OrderConfirmationSegue", sender: nil)
                }
                
            }
            
        }
        
    }
    
}


