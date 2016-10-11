//
//  ViewController.swift
//  RS
//
//  Created by liangyi on 8/16/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit
import Alamofire
//import CoreMotion

let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    
    @IBOutlet var SelectedDate: UIDatePicker!
    @IBOutlet var TimeSlot: UICollectionView!
    
    //var manager = CMMotionManager()
    
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    
    let dateformatter = NSDateFormatter()
    
    
    let array  = ["9:00", "9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00"]
    
     override func viewDidLoad() {
        
        //Alamofire.request(.GET,"http://131.96.181.143:3000/test", parameters: ["data": "no data"])
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //Reload();
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return array.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath:indexPath) as! CollectionCellVC
        cell.backgroundColor = UIColor.greenColor()
        cell.timelabel.text = self.array[indexPath.item]
                // Configure the cell
        return cell
    }
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.append(cell.timelabel.text!)
        print(cell.timelabel.text!)
        cell.selected = true
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.blackColor().CGColor;
    }
    
     func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionCellVC
        self.newArray.removeLast()
        print(newArray.count)
        cell.selected = false
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.whiteColor().CGColor
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
        if(segue.identifier == "dataUpdate"){
            print("hello");
        }
        
    }
    
    internal func Reload()-> Void {
        dateformatter.dateFormat = "MMddyyyy"
        Alamofire.request(.GET, "http://131.96.181.143:3000/reload",parameters: ["selectedDate": dateformatter.stringFromDate(SelectedDate.date)]).responseJSON{
            response in
            if let JSON = response.result.value{
              // self.jsonArray = JSON as? NSMutableArray
                print(JSON)
                //for item in self.jsonArray! {
                   // print(item["name"])
                   // let string = item["name"]
                   // self.newArray.append(string! as! String)
               // }
            }
        }
        
    }

}



 