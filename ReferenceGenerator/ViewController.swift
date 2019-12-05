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


    

    
//    var dateComponent: DateComponents = .second
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ///Test input date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MMM-dd HH.mm:ss"
        let testDate = formatter.date(from: "2019-Dec-01 13.30:10")
        guard let date = testDate else{return}
        //        let date = Date()
        
        let generator = ReferenceGenerator()
        textField.text = generator.generateReference(date)


    }


    
   
}





