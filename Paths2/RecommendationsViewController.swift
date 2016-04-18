//
//  RecommendationsViewController.swift
//  Paths2
//
//  Created by Gina Holden on 4/17/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import Foundation
//
//  FirstViewController.swift
//  Paths2
//
//  Created by Gina Holden on 3/27/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import UIKit
import CoreLocation
//import SwiftHTTP

class RecommencationViewController: UITableViewController, CLLocationManagerDelegate {
    var recs: [RecommendationItem]
    let user = User.sharedInstance
    var anyObj: AnyObject?
    var dataStringToPaste = ""
    @IBOutlet weak var textView: UITextView!

    
    required init?(coder aDecoder: NSCoder) {
        recs = [RecommendationItem]()

        let row0item = RecommendationItem()
        row0item.coordinates = "coordinates here"
        row0item.rating = "1"
        recs.append(row0item)
    
       
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   print("in view did load")
        getRecsFromServer()
        print("got recs from server")
         print("DATA STRING TO PASTE: \(self.dataStringToPaste)")
        while(dataStringToPaste==""){
          //  print("waiting for a data string")
        }
        //put recs into
        //self.textView.text = dataStringToPaste
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("visits.count: " + "\(visits.count)")
        print("\(recs.count)")
        return recs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecItem", forIndexPath: indexPath)
        let rec = recs[indexPath.row]
        configureTextForCell(cell, withRecItem: rec)
        return cell
    }
    
    func configureTextForCell(cell: UITableViewCell, withRecItem rec: RecommendationItem) {
        let label = cell.viewWithTag(1008) as! UILabel
        label.text = " rec. place: "  + "\(rec.coordinates)" + " rating: " + "\(rec.rating)"
    }
    
    
    
   func getRecsFromServer(){
        print("in get recs")
        let url:NSURL = NSURL(string: "http://ec2-52-38-102-67.us-west-2.compute.amazonaws.com:8097")!
        let session = NSURLSession.sharedSession()
        let jsonObject: [String: AnyObject] = [
        "user": "\(user.id)"
        ]
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
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
        let task = session.dataTaskWithRequest(request) {
            (
            let dataD, let response, let error) in
            guard let _:NSData = dataD, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: dataD!, encoding: NSUTF8StringEncoding){
                self.dataStringToPaste = dataString as String
               // print("string: \(dataString)")
                var error: NSError
                do {
                    self.anyObj = try NSJSONSerialization.JSONObjectWithData(dataD!, options: [])
                } catch {
                    print("Fetch failed: \((error as NSError).localizedDescription)")
                }
           //     var names: [String] = []
          //      var contacts: [String] = []
                if let json = self.anyObj as? Array<AnyObject> {
                    
                    print(json)
                    for index in 0...json.count-1 {
                        
                        let rec : AnyObject? = json[index]
                    //    print("printing rec!")
                   //     print(rec)
                        let collection = rec! as! Dictionary<String, AnyObject>
                     //   print(collection)
                        print("printing coords and rating")
                        print(collection["placeID"])
                         print(collection["rating"])
                        
                        var newitem = RecommendationItem()
                        newitem.coordinates = collection["placeID"] as! String
                        newitem.rating = collection["rating"] as! String
                        self.recs.append(newitem)
                            self.tableView.reloadData()
                    
                    }
                }
                
                
                
                
               // var list:Array<RecommendationItem> = []
               // list = self.parseJson(self.anyObj!)
               // self.recs = list
            //    self.tableView.reloadData()
                
             /*   var rec2 = list[2]
               var ratingS = rec2.rating
                var placeIDS = rec2.coordinates
                 print("rating[2] \(ratingS)")
                print("placeIDS[2] \(placeIDS)")
                
               var  rec3 = list[3]
                 ratingS = rec3.rating
                 placeIDS = rec3.coordinates
                print("rating[3] \(ratingS)")
                print("placeIDS[3] \(placeIDS)") */
            }
            else {
                print("no data string")
            }
        }
        
        task.resume()

    }
    

    
    func parseJson(anyObj:AnyObject) -> Array<RecommendationItem>{
        
        var list:Array<RecommendationItem> = []
        
        if  anyObj is Array<AnyObject> {
            
            var r:RecommendationItem = RecommendationItem()
            
            for json in anyObj as! Array<AnyObject>{
                r.coordinates = (json["placeID"] as AnyObject? as? String) ?? "" // to get rid of null
                r.rating =  (json["rating"]  as AnyObject? as? String) ?? ""
                list.append(r)
            }// for
            
        } // if
        
        return list
        
    }//func
    
    
}

