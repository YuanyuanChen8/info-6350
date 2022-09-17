//
//  ViewController.swift
//  Multiply Numbers
//
//  Created by Claire Chen on 9/17/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtFirstNumber: UITextField!
    @IBOutlet weak var txtSecondNumber: UITextField!
    
    @IBOutlet weak var lbResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func multiply(_ sender: Any) {
        let firstNumber =  Int(txtFirstNumber.text ?? "0") ?? 0
        let secondNumber =  Int(txtSecondNumber.text ?? "0") ?? 0
        
        let product = firstNumber * secondNumber
        
        lbResult.text = String(product)
    }

}

