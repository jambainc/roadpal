//
//  ParkingController.swift
//  RoadPal
//
//  Created by Michael Wong on 2/4/19.
//  Copyright © 2019 MWstudio. All rights reserved. ParkingController
//

// melbourne cental: -37.809992, 144.962757
// caulfield       : -37.876472, 145.044806
// mapbox token    : pk.eyJ1IjoibWljaGFlbGlzbSIsImEiOiJjamw5Nzh3ZjYzcjNkM3Fuc21taThlam9tIn0.tnug_ZQm-Iauvw3bfoUqrA

import Mapbox

struct ParkingSignDecodable: Decodable {
    let bayid: Int
    let lat: Double
    let long: Double
    let description: String
    let disabilityExt: Int
    let duration: Int
    let effectiveOnPH: Int
    let endTime: String
    let exemption: String
    let fromDay: Int
    let startTime: String
    let toDay: Int
    let typeDesc: String
    let adjFromDay: Int
    let adjToday: Int
    
    init(json: [String: Any]) {
        adjFromDay = json["adjFromDay"] as? Int ?? -1
        adjToday = json["adjToday"] as? Int ?? -1
        bayid = json["bayid"] as? Int ?? -1
        description = json["description"] as? String ?? ""
        disabilityExt = json["disabilityExt"] as? Int ?? -1
        duration = json["duration"] as? Int ?? -1
        effectiveOnPH = json["effectiveOnPH"] as? Int ?? -1
        endTime = json["endTime"] as? String ?? ""
        exemption = json["exemption"] as? String ?? ""
        fromDay = json["fromDay"] as? Int ?? -1
        lat = json["lat"] as? Double ?? -1
        long = json["long"] as? Double ?? -1
        startTime = json["startTime"] as? String ?? ""
        toDay = json["toDay"] as? Int ?? -1
        typeDesc = json["typeDesc"] as? String ?? ""
    }
}

// MGLPointAnnotation subclass (modify)
class MyCustomPointAnnotation: MGLPointAnnotation {
    var bayid = -1
    var lat = -1
    var long = -1
    var descript = "" // cannot name to 'description' because the name is dupicate
    var disabilityExt = -1
    var duration = -1
    var effectiveOnPH = -1
    var endTime = ""
    var exemption = ""
    var fromDay = -1
    var startTime = ""
    var toDay = -1
    var typeDesc = ""
    var adjFromDay = -1
    var adjToday = -1
}


class ParkingController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var alarmUIButtonOutlet: UIButton!
    
    let locationManager = CLLocationManager()
    
    var parkingSignDecodables: [ParkingSignDecodable]!
    
    //is the alarm on? defaule value is false
    var alarmOn = false
    
    //alarm minute
    var alarmMinutes = 10
    
    //when this button is click, the view will center back to user location
    @IBAction func centerViewOnUserUIButton(_ sender: Any) {
        centerViewOnUserLocation()
    }
    
    
    // A array stored data for navigating to annotationPopUpContoller
    var annotationPopUpViewSegueData = ["",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the alarm icon based on the alarm on/off
        if self.alarmOn {
            alarmUIButtonOutlet.setImage(UIImage(named: "alarmOn-50"), for: .normal)
        }else{
            alarmUIButtonOutlet.setImage(UIImage(named: "alarmOff-50"), for: .normal)
        }
        
        
        /** 暂时停掉map功能**/
        
        // Set map view's delegate
        mapView.delegate = self
        // Set map user annotation style (light blue)
        mapView.tintColor = UIColor(red: 117/255, green: 188/255, blue: 236/255, alpha: 1)
        // after the view is load, check the location service
        checkLocationServices()
        //test
        readJsonFile()
        // add Annotations to the map
        addParkingSignAnnotation()

 
    }
    
    func checkLocationServices(){
        // if location service is enabled
        if CLLocationManager.locationServicesEnabled(){
            // set up location manager
            setupLocationManager()
            // and check location authorization
            checkLocationAuthorization()
        }else{
            // show an alert to ask user to turn on location service
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse: // if have this permission,
            mapView.showsUserLocation = true // map display user's current location
            centerViewOnUserLocation() // center the screen to user location
            locationManager.startUpdatingLocation() //
            break
        case .denied: // if permission is denied, tell them how to do setting
            break
        case .notDetermined: // if permission is not determined, ask for 'authorizedWhenInUse' permission
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways: // do not do anything
            break
        }
    }
    
    func centerViewOnUserLocation(){
        // if the location of locationManager is not null, center the view to user location
        if let location = locationManager.location?.coordinate{
            mapView.setCenter(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), zoomLevel: 12, animated: true)
        }
    }
    
    
    //test
    func readJsonFile(){
        let path = Bundle.main.path(forResource: "parking_json2", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        //useless, just for print out jsons
        let jsons = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(jsons)
        let parkingSignDecodables = try! JSONDecoder().decode([ParkingSignDecodable].self, from: data)
        self.parkingSignDecodables = parkingSignDecodables
    }
    
    func addParkingSignAnnotation(){
        // define an array to store annotation that need to be displayed
        var annotations = [MyCustomPointAnnotation]()
        // loop through the parkingSignDecodables array
        for parkingSignDecodable in self.parkingSignDecodables{
            //create annotation
            let myCustomPointAnnotation = MyCustomPointAnnotation()
            myCustomPointAnnotation.coordinate = CLLocationCoordinate2D(latitude: parkingSignDecodable.lat, longitude: parkingSignDecodable.long)
            // set callout title
            myCustomPointAnnotation.title = "Hi~"
            // set myCustomPointAnnotation added attributes
            myCustomPointAnnotation.bayid = parkingSignDecodable.bayid
            myCustomPointAnnotation.descript = parkingSignDecodable.description
            myCustomPointAnnotation.disabilityExt = parkingSignDecodable.disabilityExt
            myCustomPointAnnotation.duration = parkingSignDecodable.duration
            myCustomPointAnnotation.effectiveOnPH = parkingSignDecodable.effectiveOnPH
            myCustomPointAnnotation.endTime = parkingSignDecodable.endTime
            myCustomPointAnnotation.exemption = parkingSignDecodable.exemption
            myCustomPointAnnotation.fromDay = parkingSignDecodable.fromDay
            myCustomPointAnnotation.startTime = parkingSignDecodable.startTime
            myCustomPointAnnotation.toDay = parkingSignDecodable.toDay
            myCustomPointAnnotation.typeDesc = parkingSignDecodable.typeDesc
            myCustomPointAnnotation.adjFromDay = parkingSignDecodable.adjFromDay
            myCustomPointAnnotation.adjToday = parkingSignDecodable.adjToday
            // append the annotation to the array
            annotations.append(myCustomPointAnnotation)
        }
        // add annotations using the annotation array
        mapView.addAnnotations(annotations)
    }
    
    // Allow callouts to popup when annotations are tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    // This method called when the annotation is clicked
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        // convert the Annotation object back to MyCustomPointAnnotation object
        let myCustomPointAnnotation = annotation as! MyCustomPointAnnotation
        // print to console
        print("bayid: " + String(myCustomPointAnnotation.bayid))
        print("descript: " + myCustomPointAnnotation.descript)
        print("disabilityExt: " + String(myCustomPointAnnotation.disabilityExt))
        print("duration: " + String(myCustomPointAnnotation.duration))
        print("effectiveOnPH: " + String(myCustomPointAnnotation.effectiveOnPH))
        print("endTime: " + myCustomPointAnnotation.endTime)
        print("exemption: " + myCustomPointAnnotation.exemption)
        print("fromDay: " + String(myCustomPointAnnotation.fromDay))
        print("startTime: " + myCustomPointAnnotation.startTime)
        print("toDay: " + String(myCustomPointAnnotation.toDay))
        print("typeDesc: " + myCustomPointAnnotation.typeDesc)
        print("adjFromDay: " + String(myCustomPointAnnotation.adjFromDay))
        print("adjToday: " + String(myCustomPointAnnotation.adjToday))
        
        // put all the data to instance valuable annotationPopUpViewSegueData
        annotationPopUpViewSegueData[0] = myCustomPointAnnotation.descript
        annotationPopUpViewSegueData[1] = String(myCustomPointAnnotation.duration)
        
        
        
        //pop up the panel to show detail information of the annotation
        self.performSegue(withIdentifier: "annotationPopUpViewSegue", sender: nil)
    }
    
    // This delegate method is where you tell the map to load an image for a annotation
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // For better performance, always try to reuse existing annotations.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "annotationImage")
        // If there is no reusable annotation image available, initialize a new one.
        if(annotationImage == nil) {
            annotationImage = MGLAnnotationImage(image: UIImage(named: "annotationImage")!, reuseIdentifier: "annotationImage")
        }
        return annotationImage
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the destination is AnnotationPopUpViewController
        if let annotationPopUpViewController = segue.destination as? AnnotationPopUpViewController {
            // set up the destination view's label
            annotationPopUpViewController.descript = annotationPopUpViewSegueData[0]
            annotationPopUpViewController.duration = annotationPopUpViewSegueData[1]
        } //if the destination is AlarmPopUpViewController
        else if let alarmPopUpViewController = segue.destination as? AlarmPopUpViewController{
            alarmPopUpViewController.alarmOn = self.alarmOn
            alarmPopUpViewController.alarmMinutes = self.alarmMinutes
        }
     }
    
    // This method deal with the action after unwill from AlarmPopUpView
    @IBAction func backFromAlarmPopUpViewController(sender: UIStoryboardSegue){
        guard let alarmPopUpViewController = sender.source as? AlarmPopUpViewController else {return}
        self.alarmOn = alarmPopUpViewController.alarmOn
        self.alarmMinutes = alarmPopUpViewController.alarmMinutes
        //set the alarm icon based on the alarm on/off
        if self.alarmOn {
            alarmUIButtonOutlet.setImage(UIImage(named: "alarmOn-50"), for: .normal)
        }else{
            alarmUIButtonOutlet.setImage(UIImage(named: "alarmOff-50"), for: .normal)
        }
    }
}

extension ParkingController: CLLocationManagerDelegate{
    //This method deal with updating location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return} // if last location is the same (nil), the following code do not run
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) // if have new location, create a center according to the new location
        mapView.setCenter(CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude), zoomLevel: 12, animated: true) // set center to the map. zoomLevel should be consistent with centerViewOnUserLocation()
    }
    
    // this method deal with the Authorization changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // if the Authorization is changed, check which Authorization the user gives and handle each case accordingly
        checkLocationAuthorization()
    }
    
}
