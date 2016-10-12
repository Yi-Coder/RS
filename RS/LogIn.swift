//
//  LogIn.swift
//  RS
//
//  Created by liangyi on 8/30/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import Foundation
import Alamofire

struct loginUser {
    static var id = ""
    static var name = ""
    static var email = ""
}

class login : UIViewController {
    
    var jsonArray:NSMutableArray?

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func signIn(sender: AnyObject) {
        
        if (email.text == "" || name.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Failed Again!", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        Alamofire.request(.GET,"http://131.96.181.143:3000/userbyname/"+self.name.text!, parameters: ["name": self.name.text!]).responseJSON{
            response in
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                if( self.jsonArray!.count > 0){
                    for item in self.jsonArray! {
                        //print(item)
                        //print(item["email"])
                        let string: String = item["email"] as! String
                        if(string == self.email.text)
                        {
                            loginUser.id = item["_id"] as! String
                            loginUser.name = item["name"] as! String
                            loginUser.email = item["email"] as! String
                            self.performSegueWithIdentifier("login", sender: self)
                        }else{
                            let alert = UIAlertController(title: "error name or email", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
                            //print("login error")
                            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            //showViewController(alert, sender: self);
                        }
                    }
                }
            }else{
                let alert = UIAlertController(title: "error name or email", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
                //print("login error")
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                //showViewController(alert, sender: self);
            }
        }
    }
}
