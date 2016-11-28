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



class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet var SelectedDate: UIDatePicker!
    @IBOutlet var TimeSlot: UICollectionView!
    
    let reuseIdentifier = "Cell"
    
    
    var jsonArray: NSMutableArray?
    var newArray: Array<String> = []
    
    let dateformatter = NSDateFormatter()
    
    var basearray :Array<String> = ["9:00", "9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00"]

    var array: Array<String> = []
    
    override func viewDidLoad() {
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
        
        
    }
    
    @IBAction func datechanged(sender: AnyObject) {
        //print("date change")
        self.Reload()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem?.enabled = false
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
        //print(self.array)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath:indexPath) as! CollectionCellVC
          // Configure the cell
        cell.backgroundColor = UIColor.greenColor()
        cell.selected = false
        cell.timelabel.text! = self.basearray[indexPath.item]
        cell.userInteractionEnabled = true
        if(array.contains(cell.timelabel.text!)){
            cell.userInteractionEnabled = false
            cell.timelabel.text = "reserved"
        }
        
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.append(cell.timelabel.text!)
       self.navigationItem.rightBarButtonItem?.enabled = true
        //print(newArray)
        //print("test")
    }
    
     func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.removeAtIndex(self.newArray.indexOf(cell.timelabel.text!)!)
        if (self.newArray.isEmpty)
        {
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
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
            destinationVC.selectedDate = dateformatter.stringFromDate(SelectedDate.date)
        //}
    }
    
    func Reload()-> Void {
        dateformatter.dateFormat = "MMddyyyy"
        Alamofire.request(.GET, "http://131.96.181.143:3000/reload",parameters: ["selectedDate": dateformatter.stringFromDate(SelectedDate.date)]).responseJSON{
            // Alamofire.request(request).responseJSON{
            response in
            //to get status code
            switch response.result{
            case .Success(let value):
                let json = JSON(value)
                self.array = json["RTS"].arrayValue.map{$0.stringValue}
                //self.array.sortInPlace();
                self.newArray.removeAll()
                self.TimeSlot.reloadData()
               // print(self.array)
            case .Failure(let error):
                print(error)
            }
        }
    }
    

}



 