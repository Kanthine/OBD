//
//  LoginThirdPartyView.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

// 高54
class LoginThirdPartySingleView: UIView
{
    private let viewHeight:Float = Float((UIScreen.main.bounds.size.width - 120) / 252 * 54.0)
    public var button:UIButton?
    
    var title = ""
    var logo = ""
    
    
    
    func setSubView()
    {
        self.backgroundColor = UIColor.RGBA(76, 76 , 76, 1 )
        self.layer.cornerRadius = CGFloat(viewHeight / 2.0)
        self.clipsToBounds = true
        
        
        let titleLable:UILabel = UILabel.init()
        titleLable.text = self.title
        titleLable.textColor = UIColor.RGBA(155, 155 , 155 , 1)
        titleLable.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLable)
        titleLable.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.centerY.equalTo()(self)
            make.left.mas_equalTo()(10)
        }

        
        let imageView:UIImageView = UIImageView.init(image: UIImage.init(named: self.logo), highlightedImage: UIImage.init(named: "LoginRegister_ThirdIng"))
        imageView.backgroundColor = UIColor.clear
        imageView.tag = 91
        self.addSubview(imageView)
        imageView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            
            make.top.mas_equalTo()(8)
            make.right.mas_equalTo()(-8)
            make.bottom.mas_equalTo()(-8)
            make.width.mas_equalTo()(imageView.mas_height)?.multipliedBy()(1.0)
        }
        
        
        let bigButton = UIButton.init(type: .custom)
        bigButton.backgroundColor = UIColor.clear
        self.addSubview(bigButton)
        bigButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.mas_equalTo()(0)
                make.left.mas_equalTo()(0)
                make.bottom.mas_equalTo()(0)
                make.right.mas_equalTo()(0)
        }

        self.button = bigButton
        
    }
}


class LoginThirdPartyView: UIView
{
    public var qqButton:UIButton?
    public var weChatButton:UIButton?
    public var fbButton:UIButton?

    func setLoginSubView()
    {
        let qqLoginView = LoginThirdPartySingleView()
        qqLoginView.title = "QQ"
        qqLoginView.logo = "LoginRegister_QQ"
        qqLoginView.setSubView()
        self.addSubview(qqLoginView)
        qqLoginView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(0)
                make.left.equalTo()(0)
                make.right.equalTo()(0)
                make.height.mas_equalTo()(qqLoginView.mas_width)?.multipliedBy()(54/262.0)
        }
        
        
        let weChatLoginView = LoginThirdPartySingleView()
        weChatLoginView.title = "微信"
        weChatLoginView.logo = "LoginRegister_WeChat"
        weChatLoginView.setSubView()
        self.addSubview(weChatLoginView)
        weChatLoginView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(qqLoginView.mas_bottom)?.with().offset()(8)
                make.centerX.equalTo()(self.mas_centerX)
                make.height.equalTo()(qqLoginView.mas_height)
                make.width.equalTo()(qqLoginView.mas_width)
        }
        
        
        let fbLoginView = LoginThirdPartySingleView()
        fbLoginView.title = "FaceBook"
        fbLoginView.logo = "LoginRegister_FaceBook"
        fbLoginView.setSubView()
        self.addSubview(fbLoginView)
        fbLoginView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(weChatLoginView.mas_bottom)?.with().offset()(8)
                make.centerX.equalTo()(self.mas_centerX)
                make.height.equalTo()(qqLoginView.mas_height)
                make.width.equalTo()(qqLoginView.mas_width)
                make.bottom.mas_equalTo()(0)

        }
        
        //
        
        self.qqButton = qqLoginView.button
        self.weChatButton = weChatLoginView.button
        self.fbButton = fbLoginView.button

    }
    
    
    
}
