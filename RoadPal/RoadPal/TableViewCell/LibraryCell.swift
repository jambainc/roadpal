//
//  LibraryCell.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    @IBOutlet weak var imageUIView: UIImageView!
    @IBOutlet weak var titleUILabel: UILabel!
    
    func setParkingSign(parkingSign: ParkingSign){
        imageUIView.image = parkingSign.image
        titleUILabel.text = parkingSign.title
    }
}
