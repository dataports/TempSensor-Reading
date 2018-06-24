//
//  ViewController.swift
//  temperature sensor
//
//  Created by Sophie Amin on 2018-06-22.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TemperatureWebServiceDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        var webService = TemperatureWebService()
        webService.delegate = self
        webService.startConnection()
    }
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    func temperatureReceived(temperature: String, date: String)
    {
        currentTempLabel.text = "\(temperature) °C"
        lastUpdateLabel.text = "\(date)"
    }

}

