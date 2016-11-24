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
    
    @IBOutlet weak var TCellLabel: UILabel!
}

class ReservationList: UITableViewController{
    
    var reservationList: Array<JSON> = []
   // @IBOutlet weak var RSTable: UITableView!
    
    private let reuseIdentifier = "ReservedCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("good")
       self.tableView.dataSource = self
        self.tableView.delegate = self
       
       //self.tableView.backgroundColor = UIColor.blueColor()
        //let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        //RSTable.registerNib(nib, forCellReuseIdentifier: "Reserved")
        //self.tableView.registerClass(TableCellVC.self, forCellReuseIdentifier: "Reserved")
    }
    
    override func viewWillAppear(animated: Bool) {
         self.Reload()
    }
    
    
    
    
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservationList.count
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier,forIndexPath: indexPath) as! TableCellVC
       //NSLog("the cell is %@", cell)
        cell.TCellLabel.text = self.reservationList[indexPath.row].rawValue.stringValue
      // cell.TCellLabel.text = "good"
        return cell
    }

   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func Reload()-> Void {
        Alamofire.request(.GET, "http://131.96.181.143:3000/reservation",parameters: ["name": "yi"]).responseJSON{
            // Alamofire.request(request).responseJSON{
            response in
            //to get status code
            switch response.result{
            case .Success(let value):
                let json = JSON(value)
               // print(json)
               // self.reservationList = json["User"].arrayValue.map{$0.stringValue}
                self.reservationList = json.array!
                //self.array.sortInPlace()
                 print(self.reservationList)
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}
