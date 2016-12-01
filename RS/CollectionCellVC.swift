//
//  CollectionCellVC.swift
//  RS
//
//  Created by liangyi on 8/17/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit

class CollectionCellVC: UICollectionViewCell {

    @IBOutlet weak var timelabel: UILabel!
    
    
    override var selected: Bool {
        didSet {
            if self.selected {
                // animate selection
                //self.layer.borderWidth = 2.0
                self.layer.backgroundColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0).CGColor
                self.timelabel.textColor = UIColor.whiteColor()
                self.layer.borderColor = UIColor.whiteColor().CGColor;
            } else {
                // animate deselection
                //self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor.greenColor().CGColor
                self.timelabel.textColor = UIColor.blackColor()
                self.layer.backgroundColor = UIColor.whiteColor().CGColor
            }
        }
    }
}
