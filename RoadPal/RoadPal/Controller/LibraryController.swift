//
//  LibraryController.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit
import Foundation


// define the library PanelUIView (card) style including round corner and shadow
class LibraryCardUIImageView: UIImageView{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //define the imageView style
        self.layer.cornerRadius = 3
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 1.7
        self.layer.shadowOpacity = 0.45
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}


class LibraryController: UIViewController {

    @IBOutlet weak var firstUIImageView: LibraryCardUIImageView!
    @IBOutlet weak var secondUIImageView: LibraryCardUIImageView!
    @IBOutlet weak var thirdUIImageView: LibraryCardUIImageView!
    @IBOutlet weak var fourthUIImageView: LibraryCardUIImageView!
    @IBOutlet weak var fifthUIImageView: LibraryCardUIImageView!
    
    
    //define a var to store which card user choose and used for navigation segue
    var libraryPopUpViewSegueData = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.popUpGesture1TableView))
        self.firstUIImageView.addGestureRecognizer(gesture1)
        self.firstUIImageView.isUserInteractionEnabled = true
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.popUpGesture2TableView))
        self.secondUIImageView.addGestureRecognizer(gesture2)
        self.secondUIImageView.isUserInteractionEnabled = true
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector(self.popUpGesture3TableView))
        self.thirdUIImageView.addGestureRecognizer(gesture3)
        self.thirdUIImageView.isUserInteractionEnabled = true
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector(self.popUpGesture4TableView))
        self.fourthUIImageView.addGestureRecognizer(gesture4)
        self.fourthUIImageView.isUserInteractionEnabled = true
        let gesture5 = UITapGestureRecognizer(target: self, action:  #selector(self.popUpGesture5TableView))
        self.fifthUIImageView.addGestureRecognizer(gesture5)
        self.fifthUIImageView.isUserInteractionEnabled = true
    }
    
    //the 5 card onclick listener
    @objc func popUpGesture1TableView(sender : UITapGestureRecognizer) {
        //pop up the table view of selected category
        libraryPopUpViewSegueData = 0
        self.performSegue(withIdentifier: "libraryPopUpViewSegue", sender: nil)
    }
    @objc func popUpGesture2TableView(sender : UITapGestureRecognizer) {
        //pop up the table view of selected category
        libraryPopUpViewSegueData = 1
        self.performSegue(withIdentifier: "libraryPopUpViewSegue", sender: nil)
    }
    @objc func popUpGesture3TableView(sender : UITapGestureRecognizer) {
        //pop up the table view of selected category
        libraryPopUpViewSegueData = 2
        self.performSegue(withIdentifier: "libraryPopUpViewSegue", sender: nil)
    }
    @objc func popUpGesture4TableView(sender : UITapGestureRecognizer) {
        //pop up the table view of selected category
        libraryPopUpViewSegueData = 3
        self.performSegue(withIdentifier: "libraryPopUpViewSegue", sender: nil)
    }
    @objc func popUpGesture5TableView(sender : UITapGestureRecognizer) {
        //pop up the table view of selected category
        libraryPopUpViewSegueData = 4
        self.performSegue(withIdentifier: "libraryPopUpViewSegue", sender: nil)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let libraryPopUpViewController = segue.destination as? LibraryPopUpViewController
        libraryPopUpViewController?.categoryNum = libraryPopUpViewSegueData
    }
    
}

