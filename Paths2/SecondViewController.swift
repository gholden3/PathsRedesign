//
//  SecondViewController.swift
//  Paths2
//
//  Created by Gina Holden on 3/27/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController{
let user = User.sharedInstance
@IBOutlet weak var userName: UITableViewCell!
    override func viewDidLoad() {
        //print("view did load")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

