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

class CityWeatherTableViewController: UITableViewController {
    
    var weatherData = [Weather]()
    
    var description1 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FetchWeather()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // Put your code which should be executed with a delay here
           print(self.weatherData[2].icon)
            print(self.weatherData.count)
           self.tableView.reloadData()
            
        })
        
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        let weatherObject = weatherData[indexPath.row]
        
        cell.textLabel?.text = weatherObject.description
        cell.detailTextLabel?.text = String(weatherObject.date)
        
        let iconUrl = "https://openweathermap.org/img/w/" + weatherObject.icon + ".png"
        let catPictureURL = URL(string: iconUrl)
      
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        session.dataTask(with: catPictureURL!) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        
                        // Do something with your image.
                        cell.imageView?.image = UIImage(data: imageData)
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
            }.resume()
        
        
        return cell
    }
 
    //This will fetch data from API.
    func FetchWeather(){
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast/daily?id=1275004&cnt=16&APPID=cb9fe4c528e41a6c8e40c1abb6183e8c")
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    //  completion([String]())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    //completion([String]())
                    
                    return
                }
                
              //  print(responseJSON)
                
                let json = JSON(responseJSON)
              
               // print(json)
                
                for item in json["list"].arrayValue {
                    print(item["weather"][0]["description"].stringValue)
                    print(item["weather"][0]["icon"].stringValue)
                    print(item["dt"].doubleValue)
                    
                    let item = Weather(description: item["weather"][0]["description"].stringValue , icon: item["weather"][0]["icon"].stringValue, date: item["dt"].doubleValue)
                    self.weatherData.append(item)
                    
                  //  self.description1.append(item["weather"][0]["description"].stringValue)
                }
        }
    }
    
//    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            completion(data, response, error)
//            }.resume()
//    }
//
//    func downloadImage(url: URL) {
//        print("Download Started")
//        getDataFromUrl(url: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                cell.imageView?.image = UIImage(data: data)
//            }
//        }
//    }
    
    func downloadImage(url: String) -> UIImage {
        let catPictureURL = URL(string: url)!
        var image: UIImage?
    // Creating a session object with the default configuration.
    // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
    let session = URLSession(configuration: .default)
    
    // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let  downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
        // The download has finished.
        if let e = error {
            print("Error downloading cat picture: \(e)")
        } else {
            // No errors found.
            // It would be weird if we didn't have a response, so check for that too.
            if let res = response as? HTTPURLResponse {
                print("Downloaded cat picture with response code \(res.statusCode)")
                if let imageData = data {
                    // Finally convert that Data into an image and do what you wish with it.
                      image = UIImage(data: imageData)
                    // Do something with your image.
                    
                } else {
                    print("Couldn't get image: Image is nil")
                }
            } else {
                print("Couldn't get response code for some reason")
            }
        }
    }.resume()
      return image!
    }
    
  //  self.downloadPicTask.resume()

}
