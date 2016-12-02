//
//  LogIn.swift
//  RS
//
//  Created by liangyi on 8/30/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct loginUser {
    static var name:[String] = []
    static var email:[String] = []
    static var password:[String] = []
}

class login : UIViewController {
    
    var users: [String] = []

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(sender: AnyObject) {
        
       if (password.text == "" || name.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Failed Again!", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        //self.performSegueWithIdentifier("login", sender: self)
        //loginUser.id = item["_id"] as! String
        //loginUser.name = name.text!
        //loginUser.email = email.text!
        Alamofire.request(.GET,"http://131.96.181.143:3000/userbyname/"+self.name.text!, parameters: ["name": self.name.text!, "password": self.password.text!]).responseJSON{
            response in
            //to get status code
            switch response.result{
                case .Success(let value):
                    let json = JSON(value)
                    loginUser.name = json.arrayValue.map{$0["name"].stringValue}
                    loginUser.email = json.arrayValue.map{$0["email"].stringValue}
                    loginUser.password = json.arrayValue.map{$0["password"].stringValue}
                        if( loginUser.name.count>0 && loginUser.password[0] == self.password.text!)
                        {
                            self.performSegueWithIdentifier("login", sender: self)
                        }else{
                            let alert = UIAlertController(title: "error name or email", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
                            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                case .Failure( _):
                    let alert = UIAlertController(title: "Wrong name or password", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
        }
    }

    
    
    @IBAction func SignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("ToSignUp", sender: self)
    }
    
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login" {
        let barViewControllers = segue.destinationViewController as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
            //barViewControllers.selectedIndex = 0;
        //nav = barViewControllers
        let destinationVC = nav.topViewController as! ViewController
            //topViewController
            destinationVC.username = loginUser.name[0]
        } else if segue.identifier == "ToSignUp"{
            
        }
    }
}
