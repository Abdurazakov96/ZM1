//
//  File.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 21/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation
struct Order {
    var MenuItems = [MenuItem]()
    
    init(menuItems: [MenuItem] = []){
        self.MenuItems = menuItems
    }
}
