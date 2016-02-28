//
//  ViewController.swift
//  Where am I?
//
//  Created by Dawood Khan on 2/6/16.
//  Copyright © 2016 Dawood Khan. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class ViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet var nearestAddress: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        let userLocation:CLLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    print(p)
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        subThoroughfare = p.subThoroughfare!
                    }
                    
                    self.nearestAddress.text = "\(subThoroughfare) \(p.thoroughfare!) \n \(p.subLocality!), \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                }
            }
            
        })
        
    }
    
    
    @IBAction func shareLocation(sender: AnyObject) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = self.nearestAddress.text!
            controller.recipients = []
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

