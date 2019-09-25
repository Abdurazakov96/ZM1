//
//  PreparationTime.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 22/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import Foundation


struct PreparationTime: Codable {
    
    
    //Mark: Public Properties
    
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
