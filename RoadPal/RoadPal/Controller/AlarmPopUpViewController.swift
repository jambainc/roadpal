//
//  AlarmPopUpViewController.swift
//  RoadPal
//
//  Created by Michael Wong on 6/4/19.
//  Copyright © 2019 MWstudio. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmPopUpViewController: UIViewController {

    //minute for alarm and set 30 to default
    var alarmMinutes = 10
    //is the alarm on? defaule value is false
    var alarmOn = false
    
    
    @IBOutlet var backgroundUIView: UIView! //for on click to dismiss
    @IBOutlet weak var popUpPanelUIView: UIView! //for set style
    @IBOutlet weak var dismissUIButton: UIButton! // for set style
    @IBAction func dismissUIButton(_ sender: Any) {
        //every time the dismiss button is click, change the value of alarmOn
        alarmOn = !alarmOn
        //if the alarm is set off, reset the alarmMinutes to 10 and turn off all notification
        if !alarmOn {
            self.alarmMinutes = 10
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            print("notification off")
        }else{
            //if the alarm is set on, set up notification
            //set up notification content
            let content = UNMutableNotificationContent()
            content.title = "Times up"
            content.subtitle = "You should take your car"
            content.badge = 1
            //set a count down timer to trigger notification
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(alarmMinutes), repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            print("notification on")
        }
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeUISliderOutlet: UISlider!
    @IBAction func timeUISlider(_ sender: UISlider) {
        //when the slider is move, it will change the alarmMinutes value
        alarmMinutes = Int(sender.value)
        //and update the timeLabel value immidately
        timeLabel.text = String(alarmMinutes) + " minutes"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("alarmOn" + String(alarmOn) + String(alarmMinutes))
        // set round corner for the popup panel and the dismiss buttom
        popUpPanelUIView.layer.cornerRadius = 10
        dismissUIButton.layer.cornerRadius = 5
        // set shadow for popup panel
        popUpPanelUIView.layer.shadowColor = UIColor.lightGray.cgColor
        popUpPanelUIView.layer.shadowOpacity = 0.5
        popUpPanelUIView.layer.shadowOffset = CGSize.zero
        popUpPanelUIView.layer.shadowRadius = 10
        // set button color based on the alarm on/off
        if self.alarmOn {
            dismissUIButton.backgroundColor = UIColor.red
            dismissUIButton.setTitleColor(UIColor.white, for: .normal)
            dismissUIButton.setTitle("Turn off", for: .normal)
            timeUISliderOutlet.setValue(Float(alarmMinutes), animated: true)
        }else{
            dismissUIButton.backgroundColor = UIColor.yellow
            dismissUIButton.setTitle("Trun on", for: .normal)
        }
        //set the slider value
        timeUISliderOutlet.setValue(Float(alarmMinutes), animated: true)
        timeLabel.text = String(alarmMinutes) + " minutes"
        //when click on background, dismiss the pop up view
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.dismissAlarmPopUpView))
        self.backgroundUIView.addGestureRecognizer(gesture)
        //ask for notificaion Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }
    
    @objc func dismissAlarmPopUpView(sender : UITapGestureRecognizer){
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
