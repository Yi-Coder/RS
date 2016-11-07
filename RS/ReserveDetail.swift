//
//  ReserveDetail.swift
//  RS
//
//  Created by liangyi on 11/7/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit
import Foundation

class ReserveDetail: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    //there are three attributes to tell
    
    @IBOutlet weak var hmpDatePicker: UIPickerView!

    @IBOutlet weak var pouDatePicker: UIPickerView!

    @IBOutlet weak var comment: UITextView!
    
    @IBOutlet weak var makeReserve: UIBarButtonItem!
    
    var selectedArray: Array<String>?
    
    // datasource for picker view
     var hmpDataSource = ["5-10","10-20","20-30","30-40"];
     var pouDataSurce = ["Meeting","Event","Discussion","Colloquium"]
    
    func reserve(sender: AnyObject?){
        print("reserve")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.makeReserve.action = #selector(self.reserve)
        makeReserve.target = self
        self.comment.layer.borderColor = UIColor.blackColor().CGColor;
        comment.layer.borderWidth = 1.0;
        print(selectedArray)
        self.hmpDatePicker.dataSource = self
        self.hmpDatePicker.delegate = self
        self.pouDatePicker.dataSource = self
        self.pouDatePicker.delegate = self
        
    }
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == hmpDatePicker){
        return hmpDataSource.count;
        }else if (pickerView == pouDatePicker){
            return pouDataSurce.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == hmpDatePicker){
            return hmpDataSource[row];
        }else if (pickerView == pouDatePicker){
            return pouDataSurce[row]
        }
        return "default"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor.redColor();
        }
        else if(row == 2)
        {
            self.view.backgroundColor =  UIColor.greenColor();
        }
        else
        {
            self.view.backgroundColor = UIColor.blueColor();
        }
    }
  
}