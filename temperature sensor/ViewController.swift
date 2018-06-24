//
//  ViewController.swift
//  temperature sensor
//
//  Created by Sophie Amin on 2018-06-22.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        temperatureReceived(temperature: "23.5", date: "Feb 16")
    }

   
    let baseURL = "http://192.168.1.169/temperaturejson.php"
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    func temperatureReceived(temperature: String, date: String)
    {
        currentTempLabel.text = "\(temperature) °C"
        lastUpdateLabel.text = "\(date)"
    }
    func getTemperatureData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the Temperature data")
                    let temperatureJSON : JSON = JSON(response.result.value!)
                    self.updateTemperatureData(json: temperatureJSON)
                    print(temperatureJSON.count)
                    
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.currentTempLabel.text = "Connection Issues"
                    
                }
        }
        
    }
    
    func updateTemperatureData(json : JSON) {
        var temperatureArrayLength = json.count - 1 
        if let tempResult = json[temperatureArrayLength]["Temp"].string {
            currentTempLabel.text =  String(tempResult) + "°C"
            lastUpdateLabel.text = json[temperatureArrayLength]["Date"].string
        }else{
            currentTempLabel.text = "Temperautre Unavailable"
            lastUpdateLabel.text = json[temperatureArrayLength]["Date"].string
        }
    }
    @IBAction func refreshTemp(_ sender: Any) {
         getTemperatureData(url: baseURL)
        
    }
    

}

