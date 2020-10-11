//
//  LoginInputView.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class LoginInputView: UIView
{
    
    var forgetButton:UIButton?
    var loginButton:UIButton?
    
    
    
    func setSubView()
    {

       self.backgroundColor = UIColor.RGBA(76, 76 , 76, 1 )
       self.layer.cornerRadius = 15
       self.clipsToBounds = true
        
        let viewHeight:Float = Float((UIScreen.main.bounds.size.width - 100 - 16) / 252 * 54.0)
        
        let accountView = InputView.init(placterText: "输入邮箱或手机号", isVerBtn: false)!
        accountView.layer.cornerRadius = CGFloat(viewHeight / 2.0)
        accountView.tag = 1
        self.addSubview(accountView)
        accountView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            
            make.top.mas_equalTo()(8)
            make.left.mas_equalTo()(8)
            make.right.mas_equalTo()(-8)
            make.height.mas_equalTo()(accountView.mas_width)?.multipliedBy()(54/262.0)
        }

        
        
        
        let passwordView = InputView.init(placterText: "密码", isVerBtn: false)!
        passwordView.textFiled.isSecureTextEntry = true
        passwordView.layer.cornerRadius = accountView.layer.cornerRadius
        passwordView.tag = 2
        self.addSubview(passwordView)
        passwordView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.top.equalTo()(accountView.mas_bottom)?.with().offset()(5)
            make.centerX.equalTo()(accountView.mas_centerX)
            make.height.equalTo()(accountView.mas_height)
            make.width.equalTo()(accountView.mas_width)
        }


        
        
        
        let forgetButton = UIButton.init(type: .custom)
        forgetButton.setTitle("忘记密码", for: .normal)
        forgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetButton.contentHorizontalAlignment = .left
        forgetButton.setTitleColor(UIColor.RGBA(153, 153, 153, 1), for: .normal)
        self.addSubview(forgetButton)
        forgetButton.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            
            make.top.equalTo()(passwordView.mas_bottom)?.with().offset()(0)
            make.left.equalTo()(20)
            make.height.equalTo()(50)
            make.bottom.mas_equalTo()(-6)
        }

        
        
        let loginButton = UIButton.init(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.setTitleColor(UIColor.RGBA(153, 153, 153, 1), for: .normal)
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor.RGBA(239, 101, 82, 1).cgColor
        loginButton.layer.cornerRadius = 19
        loginButton.clipsToBounds = true
        self.addSubview(loginButton)
        loginButton.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                
                make.centerY.equalTo()(forgetButton.mas_centerY)
                make.left.equalTo()(forgetButton.mas_right)?.with().offset()(0)
                make.right.equalTo()(-15)
                make.width.equalTo()(100)
                make.height.equalTo()(38)
        }
        
        
        self.forgetButton = forgetButton
        self.loginButton = loginButton

    }
}
