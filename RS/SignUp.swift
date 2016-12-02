//
//  SignUp.swift
//  RS
//
//  Created by liangyi on 12/1/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class SignUp: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var conpassword: UITextField!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        email.delegate = self
        password.delegate = self
        conpassword.delegate = self
    }
    
    @IBAction func backToLogin(sender: AnyObject) {
         self.performSegueWithIdentifier("unwindToLogin", sender: self)
    }
    
    @IBAction func unwindToLogin(sender: UIStoryboardSegue) {
        
        let param : [String: AnyObject] = [
            "name": self.name.text!,
            "email": self.email.text!,
            "password": self.password.text!
        ]
        
        if (name.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty || conpassword.text!.isEmpty) {
            let alert = UIAlertController(title: "missing field", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if (self.password.text! == self.conpassword.text!){
        
            let url = NSURL(string: "http://131.96.181.143:3000/signup")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject( param, options: [])
            
            Alamofire.request(request).responseJSON{
                response in
            //to get status code
            switch response.result{
                case .Success(let value):
                    print(value)
                    let alertView = UIAlertController(title: "Signed Up!", message: "Thank you for your Sign Up.\nWe'll ship it to you soon!", preferredStyle:.Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: {
                        (_)in
                        self.performSegueWithIdentifier("unwindToLogin", sender: self)
                    })
                    alertView.addAction(OKAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
            case .Failure(let error):
                    let alert = UIAlertController(title: "Duplicae User", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
                    print(error)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
        }else{
            
            let alert = UIAlertController(title: "password not match", message: "please re-try", preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if !text.isEmpty{//Checking if the input field is not empty
            SignUpButton.userInteractionEnabled = true //Enabling the button

        } else {
            SignUpButton.userInteractionEnabled = false //Disabling the button
        }
        return true
    }
    
}
