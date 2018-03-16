//
//  CityWeatherTableViewController.swift
//  WeatherApp
//
//  Created by kishor on 3/15/18.
//  Copyright © 2018 shreyas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class CityWeatherTableViewController: UITableViewController, sendCityIdDelegate{
    
  
    var weatherData = [Weather]()
    
    var navigationTitle = String()
    
    var cityId = String()
    var weatherUrl =  String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.showInfo(withStatus: "Loading...")
        
        self.title = navigationTitle
        //print(navigationTitle)
        //print(cityId)
        tableView.rowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        self.tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell1")
       
        self.weatherUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?id=" + cityId + "&cnt=16&APPID=cb9fe4c528e41a6c8e40c1abb6183e8c"
        
        FetchWeather(url: weatherUrl)
        print(weatherUrl)
        
    }
    func userSelectedCity(cityId: String) {
        self.cityId = cityId
    }
    func userSelectedCityName(cityName: String) {
        self.navigationTitle = cityName
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        })
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell1", for: indexPath) as! WeatherTableViewCell
        
        let weatherObject = weatherData[indexPath.row]
        
        cell.date.text =  getDate(epochTime: weatherObject.date)
        cell.weatherDescription.text = weatherObject.description.capitalized
        
        let iconUrlString  = "https://openweathermap.org/img/w/" + weatherObject.icon + ".png"
        let iconUrl = URL(string: iconUrlString)
        cell.icon?.sd_setImage(with: iconUrl)
        
        
//        cell.textLabel?.text = weatherObject.description
//        cell.detailTextLabel?.text = getDate(epochTime: weatherObject.date)
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: iconUrl!) { (data, response, error) in
//            // The download has finished.
//            if let e = error {
//                print("Error downloading cat picture: \(e)")
//            } else {
//                // No errors found. Response check
//                if let res = response as? HTTPURLResponse {
//                    print("Icon Downloaded,response code: \(res.statusCode)")
//                    if let imageData = data {
//                       //Icon is set on the row of tableView
//                        cell.imageView?.image = UIImage(data: imageData)
//
//                    } else {
//                        print("Couldn't get icon: icon is nil")
//                    }
//                } else {
//                    print("Couldn't get response code for some reason")
//                }
//            }
//            }.resume()
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
 
    
    //This will fetch data from API.
    func FetchWeather(url: String){
            print(url)
            Alamofire.request(url)
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        print("Error while fetching data: \(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let responseJSON = response.result.value as? [String: Any] else {
                        print("Invalid Information.")
                        return
                    }
                    
                  //  print(responseJSON)
                    
                    let json = JSON(responseJSON)
                  
                   // print(json)
                    
                    // Set data in Weather Object
                    for item in json["list"].arrayValue {
                       // print(item["weather"][0]["description"].stringValue)
                       // print(item["weather"][0]["icon"].stringValue)
                       // print(item["dt"].doubleValue)
                        
                        let item = Weather(description: item["weather"][0]["description"].stringValue , icon: item["weather"][0]["icon"].stringValue, date: item["dt"].intValue)
                        self.weatherData.append(item)
                        
                    }
                }
      
        }
    
                 func getDate(epochTime: Int) -> String {
                        if epochTime == 0 {return ""}
                        let date = NSDate(timeIntervalSince1970: TimeInterval(epochTime))
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "dd/MM/YYYY"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        return dateString
                }
    

    
}
