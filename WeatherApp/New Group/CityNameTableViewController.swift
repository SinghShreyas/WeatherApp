//
//  CityNameTableViewController.swift
//  WeatherApp
//
//  Created by kishor on 3/15/18.
//  Copyright © 2018 shreyas. All rights reserved.
//

import UIKit

protocol sendCityIdDelegate {
    func userSelectedCity(cityId: String)
    func userSelectedCityName(cityName: String)
}

class CityNameTableViewController: UITableViewController {
    
    var delegate: sendCityIdDelegate!
    
    let cityName = ["Bangalore","Mumbai","Chennai","Kolkata","Delhi"]
    let cityId = [1277333, 1275339, 1264527, 1275004, 1273294]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
     
     }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityName", for: indexPath)

        cell.textLabel?.text = cityName[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;    //Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let WeatherViewController = Storyboard.instantiateViewController(withIdentifier: "CityWeather") as! CityWeatherTableViewController
         

        WeatherViewController.navigationTitle = cityName[indexPath.row]
        WeatherViewController.cityId = String(cityId[indexPath.row])

       self.navigationController?.pushViewController(WeatherViewController, animated: true)
      
//        if delegate != nil{
//        delegate?.userSelectedCity(cityId: String(cityId[indexPath.row]))
//        delegate?.userSelectedCityName(cityName: cityName[indexPath.row])
//        }
//
    }
    
    

}
