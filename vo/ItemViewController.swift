//
//  ItemViewController.swift
//  vo
//
//  Created by COFFEE on 2018/05/26.
//  Copyright © 2018年 tsuyoshi hyuga. All rights reserved.
//

import UIKit
import AVFoundation

class ItemViewController: UIViewController {

    @IBOutlet weak var shopItemLabel: UILabel!
    @IBOutlet weak var buyButtom: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var kaeruLabel: UILabel!
    @IBOutlet weak var iineButton: UIButton!
    
    var data:ShopItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shopItemLabel.text = data.title
//        let attributedString = NSMutableAttributedString(string: "Hello iPhone")
        
        let key = NSAttributedStringKey(
            rawValue: UIAccessibilitySpeechAttributeIPANotation
        )
        let attributedString = NSAttributedString(
            string: "Hello iPhone", attributes: [key: "ˈa͡ɪ.ˈfo͡ʊn"]
        )
        
        self.kaeruLabel.accessibilityAttributedLabel = attributedString
        
        // Do any additional setup after loading the view.
        if let str = data.imageUrl,let url = URL(string: str) {
            
            //        cell.isAccessibilityElement = true
            
            
            self.imageView.isAccessibilityElement = true
            self.imageView.image = nil
            
            self.imageView.accessibilityTraits = UIAccessibilityTraitImage
            let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
