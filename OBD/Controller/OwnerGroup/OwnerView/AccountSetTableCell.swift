//
//  AccountSetTableCell.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/12.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class AccountSetTableCell: UITableViewCell {

    public let detailLabel:UILabel = UILabel.init()
    public let headerImageView:UIImageView = UIImageView.init()
    
    
    
    
    // Class 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.RGBA(75, 75, 75, 1)
        self.selectionStyle = .none
        
        self.textLabel?.textColor = UIColor.white
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        self.contentView.addSubview(self.detailLabel)
        self.contentView.addSubview(self.headerImageView)
        
        self.detailLabel.textColor = UIColor.white
        self.detailLabel.textAlignment = .right
        self.detailLabel.font = UIFont.systemFont(ofSize: 14)
        self.headerImageView.contentMode = .scaleAspectFit
        
        self.detailLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self.contentView.mas_centerY)
            make.right.mas_equalTo()(-10)
            make.width.mas_equalTo()(200)
        }
        
        self.headerImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(10)
            make.right.mas_equalTo()(-10)
            make.bottom.mas_equalTo()(-10)
            make.width.equalTo()(self.headerImageView.mas_height)?.multipliedBy()(1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
