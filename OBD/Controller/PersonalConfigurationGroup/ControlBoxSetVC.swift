//
//  ControlBoxSetVC.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

//控制盒匹配
class ControlBoxSetVC: UIViewController {

    private let _waveView = ControlBoxWaveView()
    private var _isMatching:Bool = false
    
    deinit
    {
//        OBDCentralMangerModel.shared().removeObserver(self, forKeyPath: "linkState")
        NotificationCenter.default.removeObserver(self)
        print("BluetoothSetVC ======= 释放")
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.RGBA(38, 38, 38, 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterForegroundNotification(notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)

        
        let backImageView = UIImageView.init(image: UIImage.init(named: "FWD_Back"))
        self.view.addSubview(backImageView)
        backImageView.mas_makeConstraints
            {[weak self]
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(self?.view)
        }
        
        
        let zhiImageView = UIImageView.init(image: UIImage.init(named: "FWD_ZhiWen"))
        self.view.addSubview(zhiImageView)
        zhiImageView.mas_makeConstraints
            {[weak self]
                (make:MASConstraintMaker!) in
                make.bottom.mas_equalTo()(-15)
                make.centerX.equalTo()(self?.view.mas_centerX)
                make.width.mas_equalTo()(20)
                make.height.mas_equalTo()(20)
        }
        
        
        self.view.addSubview(_waveView)
        
        
        let titleLable:UILabel = UILabel.init()
        titleLable.text = "控制盒匹配"
        titleLable.tag = 1
        titleLable.backgroundColor = UIColor.clear
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.textColor = UIColor.RGBA(234, 105 , 86, 1 )
        self.view.addSubview(titleLable)
        titleLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.bottom.equalTo()(self._waveView.mas_top)?.with().offset()(-30)
                make.centerX.equalTo()(self.view.mas_centerX)
                make.height.equalTo()(20)
        }
        
        
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.mas_makeConstraints { (make:MASConstraintMaker!) in
            make?.left.mas_equalTo()(0)
            make?.right.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
            make?.height.mas_equalTo()(60)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        startMatchingBoxClick()
        
        _waveView.startFWDAnimation()
        
        

    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        _waveView.stopFWDAnimation()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func buttonClick(sender:UIButton)
    {
        if (sender != nil) && (_isMatching == false)
        {
            startMatchingBoxClick()
        }
    }
    
    
    private func startMatchingBoxClick()
    {
        _isMatching = true
        
        let lable = self.view.viewWithTag(1) as! UILabel
        lable.text = "开始匹配..."

        
        //开始匹配
        DispatchQueue.main.async{
            OBDOrderManager.shared().setOrderWithOrderIndex(9, isCheck: true, newOrder: "")
        }
        
        CurrentOBDModel.shared().orderManagerGetBoxIdChange { [weak self] (boxID:String?) in
            
            self?._isMatching = false
            
            if (boxID != nil)
            {
                
                if boxID == "ERROR"
                {
                    //匹配失败
                    self?.matchingBoxFailedClick()
                    lable.text = "控制盒匹配失败"
                    
                    LocalConfigurationData.setBoxLinkStatus(false)
                }
                else
                {
                    //匹配成功
                    self?.matchingBoxSuccessClick()
                    lable.text = "控制盒匹配成功"
                    
                    LocalConfigurationData.setBoxLinkStatus(true)
                }
            }
        }
    }
    
    //匹配成功事件
    private func matchingBoxSuccessClick()
    {
        _waveView.matchSuccessAnimationBlock {[weak self] (image:UIImage!, size:CGSize!) in
            
            let imageView = UIImageView.init(image: image)
            imageView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.width)
            imageView.center = (self?.view.center)!
            self?.view.addSubview(imageView)
            
            
            UIView.animate(withDuration: 0.8, animations: {
                
                imageView.frame = CGRect.init(x: (UIScreen.ScrWidth() - 30) / 2.0, y: 40, width: 30, height: 30)
                
            }, completion: { (finish) in

            })
            
            self?.perform(#selector(self?.resertWindowRootController), with: self, afterDelay: 0.5)
        }
    }

    private func matchingBoxFailedClick()
    {
        _waveView.stopFWDAnimation()
    }
    
    //匹配成功，页面跳转
    @objc private func resertWindowRootController()
    {
        if AuthorizationManager.getUserBrandType() == .default
        {
            print("默认")
            
            let pageVC = PageOneViewController()
            
            let nav = UINavigationController.init(rootViewController: pageVC)
            nav.isNavigationBarHidden = true
            let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
            
            UIView.transition(from: self.view, to: pageVC.view, duration: 1, options: .transitionCrossDissolve)
            { (finished) in
                window.rootViewController = nil
                window.rootViewController = nav
            }
        }
        else if AuthorizationManager.getUserBrandType() == .FWD
        {
            print("FWD")
            
            let fwdVC = FWDMainViewController()
            let nav = UINavigationController.init(rootViewController: fwdVC)
            
            
            UIView.transition(from: self.view, to: fwdVC.view, duration: 1, options: .transitionCrossDissolve)
            { (finished) in
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
        else
        {
            print("其余品牌")
            
            let fwdVC = FWDMainViewController()
            let nav = UINavigationController.init(rootViewController: fwdVC)
            
            
            UIView.transition(from: self.view, to: fwdVC.view, duration: 1, options: .transitionCrossDissolve)
            { (finished) in
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
    }
    
    //程序重新进入前台通知
    @objc func enterForegroundNotification(notification:Notification)
    {
        print("程序重新进入前台通知")
        
        _waveView.startFWDAnimation()
    }
}
