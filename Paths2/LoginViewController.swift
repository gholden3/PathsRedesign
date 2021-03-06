//
//  SecondViewController.swift
//  Paths2
//
//  Created by Gina Holden on 3/27/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    let user = User.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {            // User is already logged in, do work such as go to next view controller.
            self.performSegueWithIdentifier("FBLoginComplete", sender: self)
            // Or Show Logout Button
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            self.returnUserData()
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    }
    override func viewDidAppear(animated: Bool) {
     super.viewDidAppear(animated);
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("user is already logged in")
            self.performSegueWithIdentifier("FBLoginComplete", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        //print("User Logged In")
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            
            self.returnUserData()
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userID : NSString = result.valueForKey("id") as! NSString
                print("ID is: \(userID)")
                // let userEmail : NSString = result.valueForKey("email") as! NSString
                //  print("User Email is: \(userEmail)")
                self.user.id = userID as String
                self.user.name = userName as String
            }
        })
    }
  
    
}

