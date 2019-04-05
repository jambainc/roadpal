//
//  LibraryController.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit

class LibraryController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var uiTableView: UITableView!
    
    var parkingSigns: [ParkingSign] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow()
        // after the view load, create some temporary data
        parkingSigns = createTempData()
        
    }
    
    func setShadow(){
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowOffset = CGSize.zero
        titleView.layer.shadowRadius = 10
    }
    
    func createTempData() -> [ParkingSign] {
        var tempParkingSigns: [ParkingSign] = []
        
        let parkingSign1 = ParkingSign(image: UIImage(named: "parkingSign1")!, title: "parkingSign1")
        let parkingSign2 = ParkingSign(image: UIImage(named: "parkingSign2")!, title: "parkingSign2")
        let parkingSign3 = ParkingSign(image: UIImage(named: "parkingSign3")!, title: "parkingSign3")
        let parkingSign4 = ParkingSign(image: UIImage(named: "parkingSign4")!, title: "parkingSign4")
        let parkingSign5 = ParkingSign(image: UIImage(named: "parkingSign5")!, title: "parkingSign5")
       
        tempParkingSigns.append(parkingSign1)
        tempParkingSigns.append(parkingSign2)
        tempParkingSigns.append(parkingSign3)
        tempParkingSigns.append(parkingSign4)
        tempParkingSigns.append(parkingSign5)
        
        return tempParkingSigns
    }
}

extension LibraryController: UITableViewDataSource, UITableViewDelegate {
    
    // decide how many parking signs in the table view (section)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkingSigns.count
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parkingSign = parkingSigns[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell") as! LibraryCell
        cell.setParkingSign(parkingSign: parkingSign)
        return cell
    }

}
