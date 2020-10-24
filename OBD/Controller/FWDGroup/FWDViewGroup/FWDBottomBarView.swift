//
//  FWDBottomBarView.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/23.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class FWDBottomBarView: UIView {

    public var barButton: UIButton!


    public func setFWDBottomBarView(navBarShow:Bool)
    {
        let bottomHeight = (UIScreen.ScrWidth() * 150.0 / 750.0) + (isIPhoneNotchScreen() ? 34 : 0)
        
        if navBarShow{
            self.frame = CGRect.init(x: 0, y: UIScreen.ScrHeight() - bottomHeight - getNavigationBarHeight(), width: UIScreen.ScrWidth(), height: bottomHeight)
        }else{
            self.frame = CGRect.init(x: 0, y: UIScreen.ScrHeight() - bottomHeight, width: UIScreen.ScrWidth(), height: bottomHeight)
        }
        
        self.backgroundColor = UIColor.clear
        
        let bottomImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseBottom"))
        bottomImageView.backgroundColor = UIColor.clear
        self.addSubview(bottomImageView)
        bottomImageView.mas_makeConstraints
            {[weak self](make:MASConstraintMaker!) in
                make.edges.equalTo()(self)
        }
        
        let logoWidth:CGFloat = 45.0
        let bottomLogoButton = UIButton.init(type: .custom)
        bottomLogoButton.backgroundColor = UIColor.RGBA(255, 221, 33, 1)
        bottomLogoButton.setImage(UIImage.init(named: "FWD_BottomFWD"), for: .normal)
        bottomLogoButton.adjustsImageWhenDisabled = false
        bottomLogoButton.adjustsImageWhenHighlighted = false
        bottomLogoButton.layer.cornerRadius = logoWidth / 2.0
        bottomLogoButton.clipsToBounds = true
        bottomLogoButton.imageEdgeInsets = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)
        self.addSubview(bottomLogoButton)
        bottomLogoButton.mas_makeConstraints
            {[weak self](make:MASConstraintMaker!) in
            make.top.mas_equalTo()(20)
                make.centerX.equalTo()(self)
                make.height.mas_equalTo()(logoWidth)
                make.width.mas_equalTo()(logoWidth)
        }

        barButton = bottomLogoButton
    }
}
