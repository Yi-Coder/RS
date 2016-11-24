//
//  ReservationList.swift
//  RS
//
//  Created by liangyi on 11/7/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class ReservationList: UITableViewController{
    
    var reservationList: Array<String> = ["one","two","three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Reserved")
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservationList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Res", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.reservationList[indexPath.row]
        
        return cell
    }
    
    
  
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func Reload()-> Void {
        Alamofire.request(.GET, "http://131.96.181.143:3000/reload",parameters: ["name": "yi"]).responseJSON{
            // Alamofire.request(request).responseJSON{
            response in
            //to get status code
            switch response.result{
            case .Success(let value):
                let json = JSON(value)
                self.reservationList = json["RTS"].arrayValue.map{$0.stringValue}
                //self.array.sortInPlace()
                self.tableView.reloadData()
                print(self.reservationList)
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}
