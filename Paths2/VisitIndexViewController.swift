//
//  FirstViewController.swift
//  Paths2
//
//  Created by Gina Holden on 3/27/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import UIKit
import CoreLocation

class VisitIndexViewController: UITableViewController, CLLocationManagerDelegate {
        var numVisits = 2
        var insideFence = false;
        var visits: [VisitItem]
        var locationManager: CLLocationManager = CLLocationManager()
        var lastLocationError: NSError?
        let user = User.sharedInstance

    
        required init?(coder aDecoder: NSCoder) {
            visits = [VisitItem]()
            
            let row0item = VisitItem()
            row0item.coordinates = "coordinates here"
            row0item.timestamp = "01"
            visits.append(row0item)
            
            let row1item = VisitItem()
            row1item.coordinates = "coordinates2"
            row1item.timestamp = "02"
            visits.append(row1item)
            
            super.init(coder: aDecoder)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let authStatus = CLLocationManager.authorizationStatus()
            if authStatus == .NotDetermined {
                locationManager.requestAlwaysAuthorization()
                return
            }
            if authStatus == .Denied || authStatus == .Restricted {
                showLocationServicesDeniedAlert()
                return
            }
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            //updateLabels()
            //configureGetButton()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        
        func showLocationServicesDeniedAlert() {
            let alert = UIAlertController(title: "Location Services Disabled",
                message: "Please enable location services for this app in Settings.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            presentViewController(alert, animated: true, completion: nil)
            alert.addAction(okAction)
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //print("visits.count: " + "\(visits.count)")
            return visits.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("VisitItem", forIndexPath: indexPath)
            
            let visit = visits[indexPath.row]
            
            configureTextForCell(cell, withVisitItem: visit)
            return cell
        }
        
        func configureTextForCell(cell: UITableViewCell, withVisitItem visit: VisitItem) {
            let label = cell.viewWithTag(1007) as! UILabel
            label.text = " visit. time: "  + "\(visit.timestamp)"
        }
        
        func sendVisitToServer(visit: VisitItem){
            let url = NSURL(string:"http://54.174.70.236:8097")
            let request = NSMutableURLRequest(URL: url!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            //all strings
            //userid, lat, long, timestamp as epoch
           // print("user is : \(user.id)")
            let jsonObject: [String: AnyObject] = [
                "user": "\(user.id)",
                //    "duration": "\(visit.duration)",
                "lat": "\(visit.lat)",
                "long": "\(visit.long)",
                "time": "\(visit.timestamp)"
            ]
            
            let valid = NSJSONSerialization.isValidJSONObject(jsonObject)
            if(valid){
                do {
                    request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(jsonObject, options: [])
                    
                } catch let error as NSError {
                    print("there was an error")
                    print("\(error)")
                    request.HTTPBody = nil
                }
            } else {
                print("not a valid json object")
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in print("Response from send:")})
            //let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")})
            task.resume()
        }

    
    
    
        
        func locationManager(manager: CLLocationManager, didVisit visit: CLVisit)
        {   /*
            let dateComponentsFormatter = NSDateComponentsFormatter()
            dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Full
            //println("visit: \(visit.coordinate.latitude),\(visit.coordinate.longitude)")
            numVisits++
            let newItem = VisitItem()
            newItem.coordinates = "\(visit.coordinate)"
            let date2 = visit.departureDate
            let date1 = visit.arrivalDate
            let interval = date2.timeIntervalSinceDate(date1)
            let duration = dateComponentsFormatter.stringFromTimeInterval(interval)
            newItem.duration = " \(duration)"
            newItem.user = "gholden3"
            visits.append(newItem)
            let indexPath = NSIndexPath(forRow: numVisits, inSection: 0)
            let indexPaths = [indexPath]
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            sendVisitToServer(newItem) */
        }
        
        func dropGeofence( newLocation: CLLocation){
            insideFence = true;
           // print("dropping")
            let coord = newLocation.coordinate
            let identifier = NSUUID().UUIDString
            //var locationManager: CLLocationManager = CLLocationManager()
            let geoRegion:CLCircularRegion = CLCircularRegion(center: coord, radius: 10.0, identifier: identifier)
            //startMonitoringForRegion(_ region: CLRegion)
            locationManager.startMonitoringForRegion(geoRegion)
        }
        
        func pickupFence( oldFence: CLRegion){
          //  print("picking up fence")
            insideFence = false;
            locationManager.stopMonitoringForRegion(oldFence)
        }
        
    
    
        // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //delegate method woo
        //print("updated location")
        lastLocationError = nil
        //extract data from location object
        let newLocation = locations.last! //locations is an array of CLLocation s
        //drop geofence
        if(!insideFence){
           // print("not inside fence")
            dropGeofence(newLocation)
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion){
        if region is CLCircularRegion{
            let Cregion = region as! CLCircularRegion
          //  print("hopped over the fence. ")
         //   print("center: " + "\(Cregion.center)")
            pickupFence(region)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz";
            let time = NSDate().timeIntervalSince1970
            print("\(time)")
            let newItem = VisitItem()
            newItem.coordinates = "\(Cregion.center)"
            newItem.lat = "\(Cregion.center.latitude)"
            newItem.long = "\(Cregion.center.longitude)"
            newItem.timestamp = "\(time)"
            visits.append(newItem)
            let indexPath = NSIndexPath(forRow: numVisits, inSection: 0)
            let indexPaths = [indexPath]
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            //tableView.reloadData()
            sendVisitToServer(newItem)
            numVisits += 1
            }
        }
        
        func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError){
                print("Region monitoring didFailWithError \(error)")
        }
        
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("didFailWithError \(error)")
            if error.code == CLError.LocationUnknown.rawValue { //it just can't get a location rn
                return
            }
            lastLocationError = error //you got a more serious error
            locationManager.stopUpdatingLocation() //obtaining a location seems to be impossible for where the user is. stop location man
            let newItem = VisitItem()
            newItem.coordinates = "ERROR:  "
            visits.append(newItem)
        }
    

}

