//
//  ViewController.swift
//  GetStockPrices
//
//  Created by Claire Chen on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var arr : [CompanyDetail] = [ CompanyDetail]()
      
    var indexSelected = 0;
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllValue()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str =  "Name is \(arr[indexPath.row].name)(\(arr[indexPath.row].symbol)), Price is \(arr[indexPath.row].price)"
        cell.textLabel?.text = str
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        // Send the symbol  to next VC
        indexSelected = indexPath.row
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueDetails"){
            let destVC = segue.destination as! DetailsViewController
            let selectedStock = arr[indexSelected]
            destVC.Symboltxt = selectedStock.symbol
            destVC.Nametxt = "Company name is \(selectedStock.name) "
            destVC.Pricetxt = "Company price is \(selectedStock.price) "
        }
    }
    func getAllValue(){
        let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
        SwiftSpinner.show("Getting All Stock Values")
        AF.request(url).responseJSON {responseData in
            SwiftSpinner.hide()
            if responseData.error != nil{
                print(responseData.error!)
                return
            }

            self.arr = [CompanyDetail]()
            var quote = CompanyDetail()
            let stockData = JSON(responseData.data as Any)
            for stock in stockData{
                let stockJSON = JSON(stock.1)
                print(stockJSON)
                var quote = CompanyDetail()
                quote.symbol = stockJSON["Symbol"].stringValue
                quote.name = stockJSON["CompanyName"].stringValue
                quote.price = stockJSON["Price"].floatValue
                self.arr.append(quote)
                
            }
            self.tblView.reloadData()
            
            
        }
    }
}

