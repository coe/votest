//
//  TimelineTableViewCell.swift
//  snschecker4
//
//  Created by COFFEE on 2017/09/17.
//  Copyright © 2017年 tsuyoshi hyuga. All rights reserved.
//

import UIKit
//import SDWebImage
//import DateToolsSwift

struct Timeline {
    var text:String?
    var userscreen_name:String?
    var created_at:String?
    var username:String?
    var userprofile_image_url:UIImage?
}

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var snsIcon: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createAt: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(timeline:Timeline){
        contentLabel.text = timeline.text

//        if let text = timeline.text {
//            //中身はHTMLなので解釈が必要
//            let data:Data = text.data(using: String.Encoding.utf8)!
//            let options:[NSAttributedString.DocumentReadingOptionKey : Any] = [
//                .documentType : NSAttributedString.DocumentType.html,
//                .characterEncoding: String.Encoding.utf8.rawValue
//                
//                ]
//            do {
//                contentLabel.attributedText = try NSAttributedString(data: data, options: options, documentAttributes: nil)
//            } catch {
//                contentLabel.text = text
//            }
//        } else {
//            contentLabel.text = nil
//        }
        
        userName.text = timeline.username
        userId.text = timeline.userscreen_name
        
        if let date = timeline.created_at {
            
            createAt.text = date
        } else {
            createAt.text = ""
        }
        
        
        if let url = timeline.userprofile_image_url {
            avatar.image = url
        } else {
            avatar.image = nil
        }
        
        
    }
    
}
