//
//  CollectionViewCell.swift
//  vo
//
//  Created by COFFEE on 2018/05/20.
//  Copyright © 2018年 tsuyoshi hyuga. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    private var _data:ShopItem!
    var data:ShopItem! {
        set {
            _data = newValue
            if let str = newValue.imageUrl,let url = URL(string: str) {
                
                //        cell.isAccessibilityElement = true
                
                self.imageView.accessibilityLabel = data.title
                
                self.imageView.isAccessibilityElement = true
                self.imageView.image = nil
                self.imageView.backgroundColor = UIColor.gray
                
                self.imageView.accessibilityTraits = UIAccessibilityTraitImage
//                let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data!)
//                    }
//                }
//                task.resume()
            }
        }
        get {
            return _data
        }
    }
}
