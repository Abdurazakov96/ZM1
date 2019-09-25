//
//  File.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 21/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation


struct Order {
    
    
    //Mark: Public properties
    
    var MenuItems = [MenuItem]()
    
    
    //Mark: Init
    
    init(menuItems: [MenuItem] = []){
        self.MenuItems = menuItems
    }
}
