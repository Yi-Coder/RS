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

class TableCellVC: UITableViewCell {
    
    @IBOutlet weak var userlabel: UILabel!
    @IBOutlet weak var purposelabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var timeslotlabel: UILabel!
}

class ReservationList: UITableViewController{
    
    var purpose: [String] = []
    var date: [String] = []
    var timeslot: Array<JSON> = []
    
    
    var reservationID: [String] = []
    
    
    private let reuseIdentifier = "ReservedCell"
 
    override func viewDidLoad() {
        super.viewDidLoad()
         print("good")
    }
    override func viewWillAppear(animated: Bool) {
         self.Reload()
    }
    
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeslot.count
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier,forIndexPath: indexPath) as! TableCellVC
      //NSLog("the cell is %@", self.reservationList[indexPath.row].type)
       //print(self.timeslot[indexPath.row].string)
       //cell.TCellLabel.text = self.reservationList[indexPath.row]
        var str = ""
        for s in self.timeslot[indexPath.row]{
        str = str+" "+s.1.string!
        }
    
       cell.timeslotlabel.text = str
       cell.userlabel.text = loginUser.name[0]
       //cell.userlabel.text = room.roomNum
       cell.datelabel.text = self.date[indexPath.row]
       cell.purposelabel.text = self.purpose[indexPath.row]
        return cell
    }

   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if editingStyle == .Delete{
                Alamofire.request(.DELETE, "http://131.96.181.143:3000/reservation",parameters: ["_id": self.reservationID[indexPath.row]]).responseJSON{
                    response in
                    //to get status code
                    switch response.result{
                    case .Success(_):
                        //let json = JSON(value)
                        self.timeslot.removeAtIndex(indexPath.row)
                        self.reservationID.removeAtIndex(indexPath.row)
                        self.date.removeAtIndex(indexPath.row)
                        self.purpose.removeAtIndex(indexPath.row)
                        
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        self.tableView.reloadData()
                    case .Failure(let error):
                        print(error)
                    }
                }

            }
        }
    }
    
    func Reload()-> Void {
        print(loginUser.name)
        Alamofire.request(.GET, "http://131.96.181.143:3000/reservation",parameters: ["name": loginUser.name]).responseJSON{
            // Alamofire.request(request).responseJSON{
            response in
            //to get status code
            switch response.result{
            case .Success(let value):
                let json = JSON(value)
                self.purpose = json.arrayValue.map{$0["PurposeOfUse"].stringValue}
                self.date = json.arrayValue.map{$0["ReservedDate"].stringValue}
                
                self.timeslot = json.arrayValue.map{$0["ReservedTimeSlot"]}
                self.reservationID = json.arrayValue.map{$0["_id"].stringValue}
                
                //self.array.sortInPlace()
                //print(self.reservationID)
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}
