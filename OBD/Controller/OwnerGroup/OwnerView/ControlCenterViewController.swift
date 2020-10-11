//
//  ControlCenterViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class ControlCenterViewController: UIViewController,UINavigationControllerDelegate
{
    private let topHeight = UIScreen.ScrWidth() * 162 / 750.0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseBack"))
        backImageView.backgroundColor = UIColor.clear
        self.view.addSubview(backImageView)
        backImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(self.view)
        }

        
        setMainView(selfView: self.view)
        
        
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: topHeight))
        setTopView(topView: topView)
        self.view.addSubview(topView)
        
        let bottomView = FWDBottomBarView.init()
        bottomView.setFWDBottomBarView(navBarShow: false)
        bottomView.barButton.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        self.view.addSubview(bottomView)
    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
        
        
        let patterView:ControlCenterPatternView = self.view.viewWithTag(20) as! ControlCenterPatternView
        patterView.updateControlCenterPatternInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        
        let isShowHomePage:Bool = viewController.isKind(of: self.classForCoder)
        
        if isShowHomePage
        {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftButtonClick()
    {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func rightButtonClick()
    {
        let controlPatternVC = ControlPatternViewController()
        self.navigationController?.pushViewController(controlPatternVC, animated: true)
    }
    
    private func setTopView(topView:UIView)
    {
        let topImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseTop"))
        topImageView.backgroundColor = UIColor.clear
        topView.addSubview(topImageView)
        topImageView.mas_makeConstraints
            {(make:MASConstraintMaker!) in
                make.edges.equalTo()(topView)
        }
        
        
        let leftButton = UIButton.init(type: .custom)
        leftButton.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        leftButton.setImage(UIImage.init(named: "nav_LeftBack"), for: .normal)
        topView.addSubview(leftButton)
        leftButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.left.mas_equalTo()(0)
                make.top.mas_equalTo()(5)
                make.width.mas_equalTo()(50)
                make.height.mas_equalTo()(UIScreen.ScrWidth() * 162 / 750.0)
        }
        
        
        let rightButton = UIButton.init(type: .custom)
        rightButton.setTitle("设置", for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        topView.addSubview(rightButton)
        rightButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.right.mas_equalTo()(0)
                make.top.mas_equalTo()(5)
                make.width.mas_equalTo()(50)
                make.height.mas_equalTo()(UIScreen.ScrWidth() * 162 / 750.0)
        }
    }
    
    private func setMainView(selfView:UIView)
    {
        let offView = ControlTypeView.init(frame: CGRect.init(x: 60, y: (UIScreen.ScrHeight() - 60)/2.0, width: UIScreen.ScrWidth() - 120, height: 60), type: .off)
        offView?.tag = 11
        offView?.button.addTarget(self, action: #selector(controlTypeViewButtonClick(sender:)), for: .touchUpInside)
        offView?.isSelected = false
        selfView.addSubview(offView!)
        
        let onView = ControlTypeView.init(frame: CGRect.init(x: 60, y: (offView?.frame.minY)! - 90, width: UIScreen.ScrWidth() - 120, height: 60), type: .on)
        onView?.isSelected = false
        onView?.tag = 10
        onView?.button.addTarget(self, action: #selector(controlTypeViewButtonClick(sender:)), for: .touchUpInside)
        selfView.addSubview(onView!)
        
        
        let autoView = ControlTypeView.init(frame: CGRect.init(x: 60, y: (offView?.frame.maxY)! + 30, width: UIScreen.ScrWidth() - 120, height: 60), type: .auto)
        autoView?.tag = 12
        autoView?.button.addTarget(self, action: #selector(controlTypeViewButtonClick(sender:)), for: .touchUpInside)
        autoView?.isSelected = false
        selfView.addSubview(autoView!)
        
        
        
        if CurrentOBDModel.shared().switchStatusNum == 0
        {
            //ON
            onView?.isSelected = true
            offView?.isSelected = false
            autoView?.isSelected = false
        }
        else if CurrentOBDModel.shared().switchStatusNum == 1
        {
            //OFF
            onView?.isSelected = false
            offView?.isSelected = true
            autoView?.isSelected = false
        }
        else if CurrentOBDModel.shared().switchStatusNum == 2
        {
            //AUTO
            onView?.isSelected = false
            offView?.isSelected = false
            autoView?.isSelected = true
        }
        
        CurrentOBDModel.shared().obdSwitchStatusChange { (switchStatus:String?) in
            
            //            print("控制盒状态 ============= \(String(describing: switchStatus))")
            
            if (switchStatus != nil)
            {
                if switchStatus == "MANOFF" || switchStatus == "MAN_OFF"
                {
                    onView?.isSelected = false
                    offView?.isSelected = true
                    autoView?.isSelected = false
                }
                else if switchStatus == "MANON"
                {
                    onView?.isSelected = true
                    offView?.isSelected = false
                    autoView?.isSelected = false
                }
                else if switchStatus == "AUTON" || switchStatus == "AUTO_OFF"
                {
                    onView?.isSelected = false
                    offView?.isSelected = false
                    autoView?.isSelected = true
                }
                
            }
        }
        
        
        
        let patterView = ControlCenterPatternView.init(frame: CGRect.init(x: 60, y: (autoView?.frame.maxY)! + 30, width: UIScreen.ScrWidth() - 120, height: 50))
        patterView.tag = 20
        selfView.addSubview(patterView)
    }
    
    
    
    @objc func controlTypeViewButtonClick(sender:UIButton)
    {
        let onView = self.view.viewWithTag(10) as! ControlTypeView
        let offView = self.view.viewWithTag(11) as! ControlTypeView
        let autoView = self.view.viewWithTag(12) as! ControlTypeView
        let superView = sender.superview as! ControlTypeView
        
        switch superView.tag
        {
            case 10:
                onView.isSelected = true
                offView.isSelected = false
                autoView.isSelected = false
                
                CurrentOBDModel.shared().localSwitchStatus = "MANON"

                break
            case 11:
                onView.isSelected = false
                offView.isSelected = true
                autoView.isSelected = false
                
                CurrentOBDModel.shared().localSwitchStatus = "MANOFF"

                break
            case 12:
                onView.isSelected = false
                offView.isSelected = false
                autoView.isSelected = true
                
                CurrentOBDModel.shared().localSwitchStatus = "AUTON"

                break
            default:
                break
        }
        
        //控制盒状态
        OBDOrderManager.shared().setOrderWithOrderIndex(3, isCheck: false, newOrder: CurrentOBDModel.shared().localSwitchStatus)
    }

}
