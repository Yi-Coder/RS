//
//  ViewController.swift
//  RS
//
//  Created by liangyi on 8/16/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON	
//import CoreMotion

let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet var SelectedDate: UIDatePicker!
    @IBOutlet var TimeSlot: UICollectionView!
    
    
    var jsonArray: NSMutableArray?
    var newArray: Array<String> = []
    
    let dateformatter = NSDateFormatter()
    
    var basearray :Array<String> = ["9:00", "9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00"]

    var array: [String] = []
    
    override func viewDidLoad() {
        
        //Alamofire.request(.GET,"http://131.96.181.143:3000/test", parameters: ["data": "no data"])
        //self.Reload()
        super.viewDidLoad()
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()
        self.SelectedDate.minimumDate = currentDate
        components.year = 1
        let maxDate: NSDate = gregorian.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
        self.SelectedDate.maximumDate = maxDate
        
        self.TimeSlot!.dataSource = self
        self.TimeSlot!.delegate = self
        
        TimeSlot!.allowsMultipleSelection = true
        TimeSlot!.backgroundColor = UIColor.whiteColor();

        //self.TimeSlot!.registerClass(CollectionCellVC.self, forCellWithReuseIdentifier: reuseIdentifier)
        //print(loginUser.email)
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBAction func datechanged(sender: AnyObject) {
       // print(dateformatter.stringFromDate(SelectedDate.date))
        self.Reload()
        print("date change")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.Reload();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //print(self.array)
        return self.basearray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //print(array)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath:indexPath) as! CollectionCellVC
        cell.backgroundColor = UIColor.greenColor()
        cell.selected = false
        cell.timelabel.text! = self.basearray[indexPath.item]
        // Configure the cell
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.append(cell.timelabel.text!)
        print(cell.timelabel.text!)
    }
    
     func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.removeAtIndex(self.newArray.indexOf(cell.timelabel.text!)!)
        print(newArray.count)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    
    /*
     //Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }*/
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if(segue.identifier == "ToReserveDetail"){
            let destinationVC = segue.destinationViewController as! ReserveDetail
            destinationVC.selectedArray = self.newArray
        //}
    }
    
    func Reload()-> Void {
        dateformatter.dateFormat = "MMddyyyy"
        
        //self.TimeSlot.reloadData()
        /*let param  = [
         "ReservedDate": dateformatter.stringFromDate(SelectedDate.date),
         "user": "yi",
         "Room": "713",
         "PurposeOfUse":"meeting",
         "ReservedTimeSlot": newArray
         ]
         
         let url = NSURL(string: "http://131.96.181.143:3000/reload")
         let request = NSMutableURLRequest(URL: url!)
         request.HTTPMethod = "POST"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(param, options: [])
         */
        
        
        Alamofire.request(.GET, "http://131.96.181.143:3000/reload",parameters: ["selectedDate": dateformatter.stringFromDate(SelectedDate.date)]).responseJSON{
            // Alamofire.request(request).responseJSON{
            response in
            //to get status code
            switch response.result{
            case .Success(let value):
                let json = JSON(value)
                self.array = json["RTS"].arrayValue.map{$0.stringValue}
                //self.array.sortInPlace();
                // print(self.array)
                self.newArray.removeAll()
                self.TimeSlot.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
    }
    

}



 