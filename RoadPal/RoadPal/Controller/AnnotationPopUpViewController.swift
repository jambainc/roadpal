//
//  annotationPopUpViewController.swift
//  RoadPal
//
//  Created by Michael Wong on 4/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit

class AnnotationPopUpViewController: UIViewController {

    @IBOutlet weak var popUpPanelUIView: UIView!
    
    @IBOutlet weak var descriptUILabel: UILabel!
    @IBOutlet weak var durationUILabel: UILabel!
    @IBOutlet weak var dismissUIButton: UIButton!
    @IBAction func dismissUIButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var descript = ""
    var duration = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set round corner for the popup panel and the dismiss buttom
        popUpPanelUIView.layer.cornerRadius = 10
        dismissUIButton.layer.cornerRadius = 5
        // set shadow for popup panel
        popUpPanelUIView.layer.shadowColor = UIColor.lightGray.cgColor
        popUpPanelUIView.layer.shadowOpacity = 0.5
        popUpPanelUIView.layer.shadowOffset = CGSize.zero
        popUpPanelUIView.layer.shadowRadius = 10
        // set label value
        descriptUILabel.text = descript
        durationUILabel.text = "Max " + String(duration) + " hours"
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
