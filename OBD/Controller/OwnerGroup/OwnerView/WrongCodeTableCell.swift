//
//  WrongCodeTableCell.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/11.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class WrongCodeTableCell: UITableViewCell {

    
    @IBOutlet weak var errorCodeLable: UILabel!
    @IBOutlet weak var copyLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let redLable = self.contentView.viewWithTag(10)
        redLable?.layer.cornerRadius = (56 - 8 - 5 * 2) / 2.0
        
        
        let bigView = redLable?.superview
        bigView?.layer.cornerRadius = (56 - 8) / 2.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let redLable = self.contentView.viewWithTag(10) as! UILabel
        redLable.adjustsFontSizeToFitWidth = true
        
        if selected
        {
            redLable.text = "已复制"
        }
        else
        {
            redLable.text = "复制"
        }
        
    }
    
}
