//
//  ViewController.swift
//  ReferenceGenerator
//
//  Created by WH Software on 3/12/19.
//  Copyright © 2019 WH Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var generatorButton: UIButton!


    let formatter = DateFormatter()

    
//    var dateComponent: DateComponents = .second
    
    override func viewDidLoad() {
        super.viewDidLoad()
       formatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let generator = ReferenceGenerator()
        textField.text = generator.generateReference()


    }


    
   
}





