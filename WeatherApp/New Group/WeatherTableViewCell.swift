//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by kishor on 3/16/18.
//  Copyright © 2018 shreyas. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var date: UILabel!
   
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
