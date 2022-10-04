//
//  ViewController.swift
//  Tourist
//
//  Created by Claire Chen on 10/3/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let touristNames = ["Grieg Garden", "HUB Yard", "Pike Market", "Raitt Hall", "Savery Hall"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touristNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TouristCell
//        cell.imgTourist.image = UIImage(named: touristNames[indexPath.row])
//        cell.lblTourist.text = touristNames[indexPath.row]
        let cell = Bundle.main.loadNibNamed("TouristCell", owner: self)?.first as! TouristCell
        cell.imgTourist.image = UIImage(named: touristNames[indexPath.row])
        cell.lblTourist.text = touristNames[indexPath.row]
        
        return cell
    }

    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        
    }
    
}
