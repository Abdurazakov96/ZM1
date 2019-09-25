//
//  OrderConfirmationViewController.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 22/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


class OrderConfirmationViewController: UIViewController {
    
    
    //MARK: IBOtlet
    @IBOutlet var timeRemainingLabel: UILabel!
    
    
    //MARK: Public properties
    
    var minutes: Int!
    
    
    //MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order!  Your waiting time is approximately \(minutes!) minutes."
    }
}

