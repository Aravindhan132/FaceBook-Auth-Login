//
//  ViewController.swift
//  Facebook-Auth
//
//  Created by aravind-pt2199 on 24/09/18.
//  Copyright © 2018 aravind-pt2199. All rights reserved.
//

import UIKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate{
    
   

    let loginbutton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(loginbutton)
        loginbutton.center = view.center
        loginbutton.delegate = self
        }
    func fetchprofile() {
        
 
        let parameters = ["fields": "email, name, picture.type(large)"]

        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {(connection, result, error) -> Void in
            if error != nil {
                NSLog(error.debugDescription)
                return
            }
            
            // Result
            print("Result: \(String(describing: result))")
            
            // Handle vars
            if let result = result as? [String:String],
                let email: String = result["email"],
                let fbId: String = result["id"],
                let name: String = result["name"],
                // Add this lines for get image
                let picture: NSDictionary = result["picture"] as! NSDictionary,
                let data: NSDictionary = picture["data"] as? NSDictionary,
                let url: String = data["url"] as? String {
                
                print("Email: \(email)")
                print("fbID: \(fbId)")
                print("Name: \(name)")
                print("URL Picture: \(url)")
            }
        }
        print("fetch profile")
        
    }
 
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("login completed")
        fetchprofile()
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout button clicked")
    }
    
}

