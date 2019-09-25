//
//  File.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 21/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation


struct Order {
    
    
    //MARK: Public properties
    
    var MenuItems = [MenuItem]()
    
    
    //MARK: Init
    
    init(menuItems: [MenuItem] = []){
        self.MenuItems = menuItems
    }
}
