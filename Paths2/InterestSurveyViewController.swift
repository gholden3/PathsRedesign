//
//  InterestSurveyViewController.swift
//  Paths2
//
//  Created by Gina Holden on 3/27/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import Foundation
import UIKit



class InterestSurveyViewController: UITableViewController{
    
    var interests: [InterestItem]
    var interestlist: InterestList!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        interests = [InterestItem]()
        
        
        let row0item = InterestItem()
        row0item.text = "Outdoors"
        row0item.checked = false
        interests.append(row0item)
        
        let row1item = InterestItem()
        row1item.text = "Nightlife"
        row1item.checked = false
        interests.append(row1item)
        
        let row2item = InterestItem()
        row2item.text = "Coffee/Tea Shops"
        row2item.checked = false
        interests.append(row2item)
        
        let row3item = InterestItem()
        row3item.text = "Restaurants"
        row3item.checked = false
        interests.append(row3item)
        
        let row4item = InterestItem()
        row4item.text = "Food"
        row4item.checked = false
        interests.append(row4item)

        let row5item = InterestItem()
        row5item.text = "Arts & Entertainment"
        row5item.checked = false
        interests.append(row5item)
        
        let row6item = InterestItem()
        row6item.text = "Pets"
        row6item.checked = false
        interests.append(row6item)
        
        let row7item = InterestItem()
        row7item.text = "Beauty/Spas"
        row7item.checked = false
        interests.append(row7item)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("InterestItem", forIndexPath: indexPath)
        
        let interest = interests[indexPath.row]
        
        configureTextForCell(cell, withInterestItem: interest)
        configureCheckmarkForCell(cell, withInterestItem: interest)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let interest = interests[indexPath.row]
            interest.toggleChecked()
            //if row is newly checked
            if interest.checked == true{
            //add its children interests
                addChildren(interest.text)
            }
            //if row is newly unchecked
            else if interest.checked == false{
            //remove its children interests
            }
            configureCheckmarkForCell(cell, withInterestItem: interest)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath) {
        
        interests.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func configureTextForCell(cell: UITableViewCell, withInterestItem interest: InterestItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = interest.text
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withInterestItem item: InterestItem) {
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
    func addChildren( parent: String){
        var numInterests = interests.count
        switch parent {
            case "Outdoors":
                let row0item = InterestItem()
                row0item.text = "Hiking"
                row0item.checked = false
                interests.append(row0item)
                var indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                var indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row1item = InterestItem()
                row1item.text = "Running Trails"
                row1item.checked = false
                interests.append(row1item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row2item = InterestItem()
                row2item.text = "Biking"
                row2item.checked = false
                interests.append(row2item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row3item = InterestItem()
                row3item.text = "Beaches"
                row3item.checked = false
                interests.append(row3item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row4item = InterestItem()
                row4item.text = "National Parks"
                row4item.checked = false
                interests.append(row4item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
            
            case "Nightlife":
                let row0item = InterestItem()
                row0item.text = "Pubs"
                row0item.checked = false
                interests.append(row0item)
                var indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                var indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row1item = InterestItem()
                row1item.text = "Clubs"
                row1item.checked = false
                interests.append(row1item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row2item = InterestItem()
                row2item.text = "Brewery"
                row2item.checked = false
                interests.append(row2item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row3item = InterestItem()
                row3item.text = "Wine Bar"
                row3item.checked = false
                interests.append(row3item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row4item = InterestItem()
                row4item.text = "Sports Bars"
                row4item.checked = false
                interests.append(row4item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
            case "Food":
                let row0item = InterestItem()
                row0item.text = "Cooking"
                row0item.checked = false
                interests.append(row0item)
                var indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                var indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row1item = InterestItem()
                row1item.text = "Farmers Markets"
                row1item.checked = false
                interests.append(row1item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
            case "Arts & Entertainment":
                let row0item = InterestItem()
                row0item.text = "Movies"
                row0item.checked = false
                interests.append(row0item)
                var indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                var indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row1item = InterestItem()
                row1item.text = "Arts & Crafts"
                row1item.checked = false
                interests.append(row1item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row2item = InterestItem()
                row2item.text = "Theatre"
                row2item.checked = false
                interests.append(row2item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row3item = InterestItem()
                row3item.text = "DIY"
                row3item.checked = false
                interests.append(row3item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row4item = InterestItem()
                row4item.text = "Festivals"
                row4item.checked = false
                interests.append(row4item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
            
                
                let row5item = InterestItem()
                row5item.text = "Concerts"
                row5item.checked = false
                interests.append(row5item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
                
                let row6item = InterestItem()
                row6item.text = "Comedy"
                row6item.checked = false
                interests.append(row6item)
                indexPath = NSIndexPath(forRow: numInterests, inSection: 0)
                indexPaths = [indexPath]
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                numInterests++
            default:
                return
        }
    }
    
    @IBAction func done() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
}
