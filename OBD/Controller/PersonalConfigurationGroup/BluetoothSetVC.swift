//
//  BluetoothSetVC.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/27.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

//蓝牙链接
class BluetoothSetVC: UIViewController
{
    let logoImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_Bluetooth1"))
    let mainLable = UILabel.init()
    let describeLable = UILabel.init()

    
    
    deinit
    {
        OBDCentralMangerModel.shared().removeObserver(self, forKeyPath: "linkState")
        NotificationCenter.default.removeObserver(self)
        print("BluetoothSetVC ======= 释放")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterForegroundNotification(notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        OBDCentralMangerModel.shared().addObserver(self, forKeyPath: "linkState", options: .new, context: nil)
        
        let backImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseBack"))
        backImageView.backgroundColor = UIColor.clear
        self.view.addSubview(backImageView)
        backImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(self.view)
        }
        
        
        let jumpView = BluetoothJumpView.init(frame: CGRect.init(x: UIScreen.ScrWidth() - 95, y: 30, width: 80, height: 33))
        jumpView.jumpButton.addTarget(self, action: #selector(jumpJoinMainHomePage), for: .touchUpInside)
        self.view.addSubview(jumpView)

        
        let backButton = UIButton.init(type: .custom)
        backButton.addTarget(self, action: #selector(bluetoothSetButtonClick), for: .touchUpInside)
        backButton.adjustsImageWhenHighlighted = false
        backButton.setImage(UIImage.init(named: "FWD_BluetoothBack"), for: .normal)
        self.view.addSubview(backButton)
        backButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.centerX.equalTo()(backImageView.mas_centerX)
                make.centerY.equalTo()(backImageView.mas_centerY)
                make.width.mas_equalTo()(170)
                make.height.equalTo()(backButton.mas_width)?.multipliedBy()(350.0/305.0)
        }
        
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.backgroundColor = UIColor.clear
        self.view.addSubview(logoImageView)
        logoImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
                make.centerY.equalTo()(self.view.mas_centerY)
                make.width.equalTo()(backButton.mas_width)?.multipliedBy()(80/300)
                make.height.equalTo()(self.logoImageView.mas_width)?.multipliedBy()(1.0)
        }
        
        mainLable.textAlignment = .center
        mainLable.font = UIFont.systemFont(ofSize: 15)
        mainLable.textColor = UIColor.RGBA(234, 105, 86, 1)
        self.view.addSubview(mainLable)
        mainLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.bottom.equalTo()(backButton.mas_top)?.with().offset()(-70)
                make.centerX.equalTo()(self.view)
        }
        
        describeLable.textAlignment = .center
        describeLable.font = UIFont.systemFont(ofSize: 12)
        describeLable.textColor = UIColor.RGBA(234, 105, 86, 1)
        self.view.addSubview(describeLable)
        describeLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(self.mainLable.mas_bottom)?.with().offset()(10)
                make.centerX.equalTo()(self.view)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lookBluetoothLinkStatus()
        
        if mainLable.text == "连接中..."
        {
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth3")
            self.rotationCircleAnimation(superView: logoImageView)
        }
    }
    
    private func lookBluetoothLinkStatus()
    {
        switch OBDCentralMangerModel.shared().linkState
        {
        case .bluetoothOff:
            print("蓝牙界面出现 --------- bluetoothOff")
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth1")
            logoImageView.layer.removeAllAnimations()
            mainLable.text = "打开蓝牙连接OBD"
            describeLable.text = "请点击下方按钮"
            break
        case .bluetoothOn:
            print("蓝牙界面出现 --------- bluetoothOn")
            break
        case .startScan:
            print("蓝牙界面出现 --------- startScan")
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth3")
            self.rotationCircleAnimation(superView: logoImageView)
            mainLable.text = "连接中..."
            describeLable.text = ""
            break
            
        case .scanSuccess:
            print("蓝牙界面出现 --------- scanSuccess")
            logoImageView.layer.removeAllAnimations()
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth2")
            mainLable.text = "连接成功"
            describeLable.text = "请点击下方按钮"
            self.scanSuccessStateClick()
            break
            
        case .scanFail:
            print("蓝牙界面出现 --------- scanFail")
            //链接失败 重新扫描链接
            logoImageView.layer.removeAllAnimations()
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth4")
            mainLable.text = "连接错误"
            describeLable.text = "请点击下方按钮"
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //点击按钮事件
    @objc func bluetoothSetButtonClick()
    {
        
        switch OBDCentralMangerModel.shared().linkState
        {
        case .bluetoothOff:
            let url:NSURL = NSURL(string: "App-Prefs:root=Bluetooth")!
            if UIApplication.shared.canOpenURL(url as URL)
            {
                UIApplication.shared.openURL(url as URL)
            }
            break
        case .bluetoothOn:
            
            break

        case .startScan:
            
            break

        case .scanSuccess:
            self.scanSuccessStateClick()
            break

        case .scanFail:
            //链接失败 重新扫描链接
            OBDCentralMangerModel.shared().scanPeripherals()
            break
        default:
            break
        }
    }
    
    
    
    //K-V-O 监听蓝牙状态
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        let linkState = change?[NSKeyValueChangeKey.newKey]
        
        let state : OBDLinkState = OBDLinkState(rawValue: linkState as! UInt)!

        switch state
        {
            case .bluetoothOff:
                logoImageView.image = UIImage.init(named: "FWD_Bluetooth1")
                logoImageView.layer.removeAllAnimations()
                mainLable.text = "打开蓝牙连接OBD"
                describeLable.text = "请点击下方按钮"
                break
            case .bluetoothOn:
                
                break
            case .startScan:
                logoImageView.image = UIImage.init(named: "FWD_Bluetooth3")
                self.rotationCircleAnimation(superView: logoImageView)
                mainLable.text = "连接中..."
                describeLable.text = ""
                break
            case .scanSuccess:
                logoImageView.layer.removeAllAnimations()
                logoImageView.image = UIImage.init(named: "FWD_Bluetooth2")
                mainLable.text = "连接成功"
                describeLable.text = "请点击下方按钮"
                self.scanSuccessStateClick()
                break
            case .scanFail:
                logoImageView.layer.removeAllAnimations()
                logoImageView.image = UIImage.init(named: "FWD_Bluetooth4")
                mainLable.text = "连接错误"
                describeLable.text = "请点击下方按钮"
                break
            default:
                
                
                break
        }
    }
    
    //程序重新进入前台通知
    @objc func enterForegroundNotification(notification:Notification)
    {
        print("程序重新进入前台通知")
        
        if mainLable.text == "连接中..."
        {
            logoImageView.image = UIImage.init(named: "FWD_Bluetooth3")
            self.rotationCircleAnimation(superView: logoImageView)
        }
    }
    
    func rotationCircleAnimation(superView:UIView)
    {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber.init(value: 0)
        animation.toValue = NSNumber.init(value: M_PI * 2)
        animation.duration = 1
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.repeatCount = MAXFLOAT
        superView.layer.add(animation, forKey: "rotationCircleAnimation")
    }
    
    
    @objc private func scanSuccessStateClick()
    {
        // 链接成功
        //1、是否链接到盒子
        //2、跳转至主界面
        
        if  LocalConfigurationData.getBoxControlIsLinked()
        {
            jumpJoinMainHomePage()
        }
        else
        {
            let boxSetVC = ControlBoxSetVC()
            let nav = UINavigationController.init(rootViewController: boxSetVC)
            nav.isNavigationBarHidden = true
            let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
            
            UIView.transition(from: self.view, to: boxSetVC.view, duration: 0.5, options: .transitionFlipFromLeft)
            { (finished) in
                window.rootViewController = nav
            }
        }
    }
    
    //跳过
    @objc private func jumpJoinMainHomePage()
    {
        if AuthorizationManager.getUserBrandType() == .default
        {
            print("默认")
            
            let pageVC = PageOneViewController()
            
            let nav = UINavigationController.init(rootViewController: pageVC)
            nav.isNavigationBarHidden = true
            let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
            
            UIView.transition(from: self.view, to: pageVC.view, duration: 0.5, options: .transitionFlipFromLeft)
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
            
            
            UIView.transition(from: self.view, to: fwdVC.view, duration: 0.5, options: .transitionFlipFromLeft)
            { (finished) in
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
        else
        {
            print("其余品牌")
            
            let fwdVC = FWDMainViewController()
            let nav = UINavigationController.init(rootViewController: fwdVC)
            
            
            UIView.transition(from: self.view, to: fwdVC.view, duration: 0.5, options: .transitionFlipFromLeft)
            { (finished) in
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
    
    }

}
