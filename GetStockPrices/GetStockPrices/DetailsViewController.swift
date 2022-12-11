//
//  DetailsViewController.swift
//  GetStockPrices
//
//  Created by Claire Chen on 12/10/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = Nametxt
        Symbol.text = "Company symbol is \(Symboltxt)"
        Price.text = Pricetxt

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var Symbol: UILabel!
    
    
    @IBOutlet weak var Price: UILabel!
    
    var Nametxt = ""
    var Symboltxt = ""
    var Pricetxt = ""
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getStockBySymbol() {
            var url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/getstock?symbol="
            url+=Symboltxt
            SwiftSpinner.show("Getting company stock by symbol")
            AF.request(url).responseJSON { responseData in
                      
                      SwiftSpinner.hide()
                      
                      if responseData.error != nil {
                          print(responseData.error!)
                          return
                      }
                     print(responseData)

                  }
        }

}
