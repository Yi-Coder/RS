//
//  MyLayout.swift
//  RS
//
//  Created by liangyi on 10/6/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit

class MyLayout: UICollectionViewLayout {
    
    // 1
    //var delegate: PinterestLayoutDelegate!
    
    // 2
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    // 3
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // 4
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    
    

}
