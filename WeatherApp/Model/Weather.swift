//
//  Weather.swift
//  WeatherApp
//
//  Created by kishor on 3/15/18.
//  Copyright © 2018 shreyas. All rights reserved.
//

import Foundation


class Weather {
    
    // Data that are required to be displayed on the View
    let description:String
    let icon:String
    let date:Int
    
    init(description : String, icon : String, date:Int) {
        self.description = description
        self.icon = icon
        self.date = date
        
    }
}
