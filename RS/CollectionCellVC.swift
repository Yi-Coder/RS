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
                self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor.blackColor().CGColor;
            } else {
                // animate deselection
                self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor.whiteColor().CGColor
            }
        }
    }
}
