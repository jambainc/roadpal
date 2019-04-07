//
//  LibraryPopUpViewController.swift
//  RoadPal
//
//  Created by Michael Wong on 5/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit
//dismiss(animated: true, completion: nil)
class LibraryPopUpViewController: UIViewController {

    
    @IBOutlet weak var dismissUIView: UIView!
    @IBOutlet weak var uiTableView: UITableView!
    
    var categoryNum = -1
    
    let imageNames = [
        ["parkingSignP1", "parkingSignP2",  "parkingSignP3", "parkingSignP1"],
        ["parkingSign3", "parkingSign4", "parkingSign5"],
        ["parkingSign1", "parkingSign2"],
        ["parkingSign1", "parkingSign2", "parkingSign3", "parkingSign4"],
        ["parkingSign1", "parkingSign2", "parkingSign3", "parkingSign4", "parkingSign5"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the dismiss view shadow
        dismissUIView.layer.shadowColor = UIColor.lightGray.cgColor
        dismissUIView.layer.shadowOpacity = 0.5
        dismissUIView.layer.shadowOffset = CGSize.zero
        dismissUIView.layer.shadowRadius = 10
        //when click on the dismiss view, dismiss the LibraryPopUpView
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismissLibraryPopUpView))
        self.dismissUIView.addGestureRecognizer(gesture)
        
        // set table view delegate and dataSource
        uiTableView.delegate = self
        uiTableView.dataSource = self
        // make table not clickable
        uiTableView.allowsSelection = false
    }
    
    @objc func dismissLibraryPopUpView(sender : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
}

extension LibraryPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    // decide how many row in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames[categoryNum].count
    }
    
    // loop throught the cell and assign image to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageName = imageNames[categoryNum][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryPopUpUITableViewCell") as! LibraryPopUpUITableViewCell
        cell.imageUIView.image = UIImage(named: imageName)
        return cell
    }
    
}
