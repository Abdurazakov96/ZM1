//
//  MenuItem.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 15/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit

class MenuItem:Codable {
    let id: Int
    var name: String
    let description: String
    let price: Int
    let category: String
    let image_url: URL
    var image: Data?
    
    init(
        id: Int,
        name: String,
        description: String,
        price: Int,
        category: String,
        image_url: URL,
        image: Data? = nil
        ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.image_url = image_url
        self.image = image
    }
}



