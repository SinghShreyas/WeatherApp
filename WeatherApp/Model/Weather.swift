//
//  Weather.swift
//  WeatherApp
//
//  Created by kishor on 3/15/18.
//  Copyright © 2018 shreyas. All rights reserved.
//

import Foundation


class Weather {
    let description:String
    let icon:String
    let date:Double
    
    init(description : String, icon : String, date:Double) {
        self.description = description
        self.icon = icon
        self.date = date
        
    }
}
