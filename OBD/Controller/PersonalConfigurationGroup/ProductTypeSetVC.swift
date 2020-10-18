//
//  ProductTypeSetVC.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

//产品类型选择
class ProductTypeSetVC: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let backImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "LoginRegister_LoginBack"))
        backImageView.backgroundColor = UIColor.clear
        self.view.addSubview(backImageView)
        backImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(self.view)
        }
        
        let titleLable:UILabel = UILabel.init()
        titleLable.text = "选择一个品牌进入"
        titleLable.backgroundColor = UIColor.clear
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.textColor = UIColor.RGBA(234, 105 , 86, 1 )
        self.view.addSubview(titleLable)
        titleLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
                make.height.equalTo()(20)
        }
        
        
        let defaultView = LoginThirdPartySingleView()
        defaultView.title = "默认"
        defaultView.logo = "LoginRegister_FaceBook"
        defaultView.setSubView()
        self.view.addSubview(defaultView)
        defaultView.mas_makeConstraints{ (make:MASConstraintMaker!) in
            make.top.equalTo()(titleLable.mas_bottom)?.with().offset()(30)
            make.centerY.equalTo()(self.view.mas_centerY)?.with().offset()(-50)
            make.left.mas_equalTo()(50)
            make.right.mas_equalTo()(-50)
            make.height.mas_equalTo()(defaultView.mas_width)?.multipliedBy()(54/262.0)
        }
        
        let fwdView = LoginThirdPartySingleView()
        fwdView.title = "FWD"
        fwdView.logo = "LoginRegister_FaceBook"
        fwdView.setSubView()
        self.view.addSubview(fwdView)
        fwdView.mas_makeConstraints{ (make:MASConstraintMaker!) in
            make.top.equalTo()(defaultView.mas_bottom)?.with().offset()(30)
            make.centerX.equalTo()(self.view.mas_centerX)
            make.width.equalTo()(defaultView)
            make.height.equalTo()(defaultView)
        }
        defaultView.button?.addTarget(self, action: #selector(defaultButtonClick), for: .touchUpInside)
        fwdView.button?.addTarget(self, action: #selector(fwdButtonClick), for: .touchUpInside)
    }
    
    @objc func defaultButtonClick()
    {
        LocalConfigurationData.setUserBrandType(.default)
        self.bluetoothSetClick()
    }
    
    @objc func fwdButtonClick()
    {
        LocalConfigurationData.setUserBrandType(.FWD)
        self.bluetoothSetClick()
    }
    
    
    func bluetoothSetClick()
    {
        let bluetoothVC = BluetoothSetVC()
        let nav = UINavigationController.init(rootViewController: bluetoothVC)
        nav.isNavigationBarHidden = true
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
        UIView.transition(from: self.view, to: bluetoothVC.view, duration: 0.5, options: .transitionFlipFromLeft)
        { (finished) in
            window.rootViewController = nav
        }

    }

}
