//
//  ViewController.swift
//  Weather forecast
//
//  Created by Claire Chen on 11/19/22.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON



class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    var temps: [String] = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = temps[indexPath.row]
        return cell
    }
    
    


    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblCity: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
         lat = location.coordinate.latitude
         lon = location.coordinate.longitude
        
        print(lat)
        print(lon)
        
        
    }
    
    @IBAction func getCurrentLoc(_ sender: Any) {
        var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
        url += String(format: "%f",lat!) + "," + String(format: "%f", lon!)+"&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"
        AF.request(url).responseJSON{ responseData in
            if responseData.error != nil{
                print(responseData.error!)
                return
            }
            self.temps = [String]()
            let weatherData = JSON(responseData.data as Any)
            let forecastValues = weatherData["locations"][String(format: "%f", self.lat!) + "," + String(format: "%f", self.lon!)]["values"]
            print(forecastValues.count)
            
            self.temps = [String]()
            for forecast in forecastValues{
                print(forecast)
                let forecastJSON = JSON(forecast.1)
                let temp = forecastJSON["temp"].floatValue
                let condition = forecastJSON["conditions"].stringValue
                let str = "Temperature = \(temp), \(condition)"
                self.temps.append(str)
            }
            self.tblView.reloadData()
            
            
        }
        
    }
    
        @IBAction func getWeather(_ sender: Any) {
            let cityName = lblCity.text
            var url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/forecast?locations="
            url += (cityName ?? "") +  "&aggregateHours=24&unitGroup=us&shortColumnNames=false&contentType=json&key=AYQR6QM5KHFYVPH9M4EXXJUCC"
            AF.request(url).responseJSON{responseData in
                if responseData.error != nil{
                    print(responseData.error!)
                    return
                }
                let weatherData = JSON(responseData.data as Any)
                let cityName = self.lblCity.text
                let forecastValues = weatherData["locations"][String(cityName ?? "")]["values"]
                print(forecastValues.count)
                
                self.temps = [String]()
                for forecast in forecastValues{
                    print(forecast)
                    let forecastJSON = JSON(forecast.1)
                    let temp = forecastJSON["temp"].floatValue
                    let condition = forecastJSON["conditions"].stringValue
                    let str = "Temperature = \(temp), \(condition)"
                    self.temps.append(str)
                }
                self.tblView.reloadData()
                
                
            }
            
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

