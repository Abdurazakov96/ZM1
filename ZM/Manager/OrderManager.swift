//
//  OrderManager.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 21/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation


class OrderManager {
    
    
    //MARK: Public properties
    
    static let orderUpdatedNotification = Notification.Name("OrderManager.orderUpdated")
    static var shared = OrderManager()
    var order = Order(){
        didSet{
            NotificationCenter.default.post(name: OrderManager.orderUpdatedNotification, object: nil)
        }
    }
    
}
