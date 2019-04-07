//
//  AboutPopUpViewController.swift
//  RoadPal
//
//  Created by Michael Wong on 7/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit

class AboutPopUpViewController: UIViewController {

    @IBOutlet weak var dismissUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismissLibraryPopUpView))
        self.dismissUIView.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissLibraryPopUpView(sender : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
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
