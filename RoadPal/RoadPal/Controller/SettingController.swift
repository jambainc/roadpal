//
//  SettingController.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var aboutUIImageView: LibraryCardUIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.popUpAboutView))
        self.aboutUIImageView.addGestureRecognizer(gesture)
        self.aboutUIImageView.isUserInteractionEnabled = true
    }
    
    @objc func popUpAboutView(sender : UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "AboutPopUpViewSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
