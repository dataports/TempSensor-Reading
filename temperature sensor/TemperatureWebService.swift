//
//  TemperatureWebService.swift
//  temperature sensor
//
//  Created by Sophie Amin on 2018-06-22.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation

import UIKit

protocol TemperatureWebServiceDelegate
    
{
    func temperatureReceived(temperature: String, date: String)
}

class TemperatureWebService: NSObject, NSURLConnectionDelegate
{
    
    var delegate: TemperatureWebServiceDelegate?
    
    var data = NSMutableData()
    var jsonResult: NSArray = []
    
    func startConnection()
    {
        let urlPath: String = "http://192.168.0.11/temperaturejson.php"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(url: url as URL)
        
        var connection: NSURLConnection = NSURLConnection(request: request as URLRequest, delegate: self, startImmediately: true)!
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        self.data.append(data as Data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        var err: NSError
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        }catch{
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
        
        getLatestTempReading()
    }
    
    func getLatestTempReading()
    {
        var dictionary: NSDictionary = jsonResult.lastObject as! NSDictionary
        var tempValue = dictionary.object(forKey: "Temp") as! String
        var dateValue = dictionary.object(forKey: "Date") as! String
        
        
        if (delegate != nil)
        {
            delegate?.temperatureReceived(temperature: tempValue, date: dateValue)
        }
    }
}
