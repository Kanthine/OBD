//
//  LoginBaseViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class LoginBaseViewController: UIViewController{
    deinit{
        NotificationCenter.default.removeObserver(self)
        print("释放")
    }
    
    public lazy var navBar:UIView = {
        let nav = UIView()
        nav.backgroundColor = UIColor.clear
                
        let loginButton = UIButton.init(type: .custom)
        loginButton.tag = 1
        loginButton.contentHorizontalAlignment = .left
        loginButton.contentVerticalAlignment = .bottom
        loginButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        loginButton.setImage(UIImage.init(named: "LoginRegister_Back"), for: .normal)
        nav.addSubview(loginButton)
        loginButton.mas_makeConstraints{
            (make:MASConstraintMaker!) in
            make.top.equalTo()(0)
            make.left.equalTo()(0)
            make.bottom.equalTo()(0)
            make.height.mas_equalTo()(loginButton.mas_width)?.multipliedBy()(1.0)
        }
        
        return nav
    }()
   
    
    public lazy var titleView:UIView =
    {
        let titleView = UIView()
        
        let logoImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "appLogo"))
        logoImageView.backgroundColor = UIColor.clear
        titleView.addSubview(logoImageView)
        logoImageView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(0)
            make.bottom.mas_equalTo()(0)
            make.height.mas_equalTo()(logoImageView.mas_width)?.multipliedBy()(1.0)
        }
        
        let titleImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "LoginRegister_Title"))
        titleImageView.backgroundColor = UIColor.clear
        titleView.addSubview(titleImageView)
        titleImageView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            
            make.top.mas_equalTo()(0)
            make.bottom.mas_equalTo()(0)

            make.left.equalTo()(logoImageView.mas_right)?.with().offset()(10)
            make.centerX.equalTo()(titleView.mas_centerX)?.with().offset()(CGFloat((10 + 30) / 2.0))
            make.width.mas_equalTo()(titleImageView.mas_height)?.multipliedBy()(150 / 33.0)
        }

        
        
        return titleView
    }()


    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
        let backImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "LoginRegister_LoginBack"))
        backImageView.contentMode = .scaleAspectFill
        backImageView.backgroundColor = UIColor.clear
        self.view.addSubview(backImageView)
        backImageView.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(self.view)
        }

        
        self.view.addSubview(self.navBar)
        
        self.navBar.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
                
                make.top.mas_equalTo()(0)
                make.left.mas_equalTo()(0)
                make.right.mas_equalTo()(0)
                make.height.mas_equalTo()(64)
        }
        
        
        
        self.view.addSubview(self.titleView)
        
        self.titleView.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                
                make.top.mas_equalTo()(self.navBar.mas_bottom)?.with().offset()(0)
                make.left.mas_equalTo()(0)
                make.right.mas_equalTo()(0)
                make.height.mas_equalTo()(30)
        }

        
        
        
        let button:UIButton = self.navBar.viewWithTag(1) as! UIButton
        button.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
    }
    
    @objc func keyBoardChange(notification:Notification){}
    
    @objc func backButtonClick(){
        self.navigationController?.popViewController(animated: true)
    }
}
