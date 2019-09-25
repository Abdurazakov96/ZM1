//
//  OrderConfirmationViewController.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 22/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


class OrderConfirmationViewController: UIViewController {
    
    
    //Mark: IBOtlet
    @IBOutlet var timeRemainingLabel: UILabel!
    
    
    //Mark: Public properties
    
    var minutes: Int!
    
    
    //Mark: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order!  Your waiting time is approximately \(minutes!) minutes."
    }
}

