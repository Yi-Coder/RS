//
//  User.swift
//  RS
//
//  Created by liangyi on 8/22/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import Foundation

class User{
    
     var name: String
     var email: String    
    //MARK init
    init? (name: String, email: String){
        self.name = name
        self.email = email
        
        if (name.isEmpty || email.isEmpty)
        {
            return nil
        }
    }
    


}
