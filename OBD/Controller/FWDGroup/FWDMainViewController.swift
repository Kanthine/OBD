//
//  FWDMainViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/27.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class FWDMainViewController: UIViewController ,UINavigationControllerDelegate
{
    private let topHeight = UIScreen.ScrWidth() * 162 / 750.0
    private var _leftViewShow:Bool = false
    private var _isHaveError:Bool = false

    
    private let _leftView:UIView = UIView.init(frame: CGRect.init(x: -UIScreen.ScrWidth(), y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight()))
    
    private let _rightScrollView:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight()))

    
    deinit
    {
        OBDCentralMangerModel.shared().removeObserver(self, forKeyPath: "linkState")
        print("FWDMainViewController ======= 释放")
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        OBDCentralMangerModel.shared().addObserver(self, forKeyPath: "linkState", options: .new, context: nil)

        self.setSelfView(superView: self.view)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
        
        let personalView = _leftView.viewWithTag(12) as! PersonalMainView
        personalView.updateUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = self
        
        if _leftViewShow
        {
            recoverNormalAnimation()
        }
        
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
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setSelfView(superView:UIView)
    {
        let screenEdgePanGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(screenEdgePanGesture(screenEdgeGesture:)))
        screenEdgePanGesture.edges = .left
        superView.addGestureRecognizer(screenEdgePanGesture)
        
        
        let backImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseBack"))
        backImageView.backgroundColor = UIColor.clear
        superView.addSubview(backImageView)
        backImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.edges.equalTo()(superView)
        }
        
        
        superView.addSubview(_rightScrollView)
        superView.addSubview(_leftView)
        
        _rightScrollView.panGestureRecognizer.require(toFail: screenEdgePanGesture)
        
        self.setTopView(superView: superView)
    
        self.setLeftViewSubView(leftSuperView: _leftView)
        self.setScrollViewSubView(superScrollView: _rightScrollView)
    }
    
    private func setTopView(superView:UIView)
    {
        let topImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_BaseTop"))
        topImageView.backgroundColor = UIColor.clear
        superView.addSubview(topImageView)
        topImageView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.left.mas_equalTo()(0)
                make.top.mas_equalTo()(0)
                make.right.mas_equalTo()(0)
                make.height.mas_equalTo()(self.topHeight)
        }
        
        
        let topLogoImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_TopNormal"), highlightedImage: UIImage.init(named: "FWD_TopBad"))
        topLogoImageView.backgroundColor = UIColor.clear
        topLogoImageView.contentMode = .scaleAspectFit
        superView.addSubview(topLogoImageView)
        topLogoImageView.mas_makeConstraints
            {[weak self]
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self?.view.mas_centerX)
                make.top.mas_equalTo()((self?.topHeight)! * 0.5)
                make.height.mas_equalTo()((self?.topHeight)! * 0.7)
                make.width.mas_equalTo()((self?.topHeight)! * 0.7)
        }

        
        let topButton:UIButton = UIButton.init(type: .custom)
        topButton.backgroundColor = UIColor.clear
        topButton.addTarget(self, action: #selector(topButtonClick), for: .touchUpInside)
        superView.addSubview(topButton)
        topButton.mas_makeConstraints
            {[weak self]
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self?.view.mas_centerX)
                make.top.mas_equalTo()((self?.topHeight)! * 0.4)
                make.height.mas_equalTo()((self?.topHeight)! * 0.8)
                make.width.mas_equalTo()((self?.topHeight)! * 0.8)
        }

        
        CurrentOBDModel.shared().obdErrorcodeNumChange {[weak self] (errcodeNum:String?) in
            
            
            if (errcodeNum != nil)
            {
                
                let number:Int = Int(errcodeNum!)!
                
                if number > 0
                {
                    self?._isHaveError = true
                    topLogoImageView.isHighlighted = true
                }
                else
                {
                    self?._isHaveError = false
                    topLogoImageView.isHighlighted = false
                }
            }
        }
        
        let bottomView = FWDBottomBarView.init()
        bottomView.setFWDBottomBarView(navBarShow: false)
        bottomView.barButton.addTarget(self, action: #selector(bottomButtonClick), for: .touchUpInside)
        self.view.addSubview(bottomView)
    }
    
    
    private func setLeftViewSubView(leftSuperView:UIView)
    {
        leftSuperView.backgroundColor = UIColor.clear

        
        _leftViewShow = false
        
        
        let personalView:PersonalMainView = PersonalMainView.init(frame: CGRect.init(x: 0, y: 0, width: 160, height: UIScreen.ScrHeight()), controller: self, topHeight: topHeight)
        personalView.tag = 12
        leftSuperView.addSubview(personalView)
        
        
        
        let gestureView = UIView.init(frame: CGRect.init(x: personalView.frame.maxX, y: 0, width: UIScreen.ScrWidth() - personalView.frame.maxX, height: UIScreen.ScrHeight()))
        gestureView.backgroundColor = UIColor.clear
        leftSuperView.addSubview(gestureView)

        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureClick(tapGesture:)))
        gestureView.addGestureRecognizer(tapGesture)

        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeGestureClick(swipeGesture:)))
            swipeGesture.direction = .left
        gestureView.addGestureRecognizer(swipeGesture)

    }
    
    
    private func setScrollViewSubView(superScrollView:UIScrollView)
    {
        superScrollView.backgroundColor = UIColor.clear
        superScrollView.isPagingEnabled = true
        
        let spaceScreen:CGFloat = 25.0
        let spaceView:CGFloat = spaceScreen * 2
        
        
        let circleImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "FWD_Circle"))
        circleImageView.backgroundColor = UIColor.clear
        circleImageView.frame = CGRect.init(x:0, y: (UIScreen.ScrHeight() - 15) / 2.0, width: 15, height: 15)
        superScrollView.addSubview(circleImageView)
        
        
        let engineView:FWDBrokenLineView = FWDBrokenLineView.init(frame: CGRect.init(x: spaceScreen, y: topHeight + 40, width: UIScreen.ScrWidth() - spaceView, height: UIScreen.ScrHeight() - topHeight * 2 - 80), type: .engine)
        superScrollView.addSubview(engineView)
        
        
        let throttleView:FWDBrokenLineView = FWDBrokenLineView.init(frame: CGRect.init(x: engineView.frame.maxX + spaceView, y: topHeight + 40, width: engineView.frame.width, height: engineView.frame.height), type: .throttle)
        superScrollView.addSubview(throttleView)
        
        let airSuctionView:FWDAirSuctionView = FWDAirSuctionView.init(frame: CGRect.init(x: throttleView.frame.maxX + spaceView, y: topHeight + 40, width: engineView.frame.width, height: engineView.frame.height))
        superScrollView.addSubview(airSuctionView)
        
        let waterView:FWDDonutView = FWDDonutView.init(frame: CGRect.init(x: airSuctionView.frame.maxX + spaceView, y: topHeight + 40, width: engineView.frame.width, height: engineView.frame.height), type:.waterTemperature)
        superScrollView.addSubview(waterView)

        let airView:FWDDonutView = FWDDonutView.init(frame: CGRect.init(x: waterView.frame.maxX + spaceView, y: topHeight + 40, width: engineView.frame.width, height: engineView.frame.height), type:.airFuelRatio)
        superScrollView.addSubview(airView)

        let moreDataView:FWDMoreDataView = FWDMoreDataView.init(frame: CGRect.init(x: airView.frame.maxX + spaceView, y: topHeight + 40, width: airView.frame.width, height: airView.frame.height))
        superScrollView.addSubview(moreDataView)

        
        superScrollView.contentSize = CGSize.init(width: moreDataView.frame.maxX + spaceScreen, height: superScrollView.frame.height)

    }
    
    //GestureClick
    @objc func swipeGestureClick(swipeGesture:UISwipeGestureRecognizer)
    {
        recoverNormalAnimation()
    }
    
    @objc private func tapGestureClick(tapGesture:UITapGestureRecognizer)
    {
        recoverNormalAnimation()
    }

    //恢复原状
    private func recoverNormalAnimation()
    {
        UIView.animate(withDuration: 0.25) { 
            
            self._leftView.frame = CGRect.init(x: -UIScreen.ScrWidth(), y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
            
            self._rightScrollView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
            
        }
        
        _leftViewShow = false
    }
    
    //侧滑展示左视图
    private func leftViewShowAnimation()
    {
        UIView.animate(withDuration: 0.25) {
            
            self._leftView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
            
            self._rightScrollView.frame = CGRect.init(x: 160 + 10, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
            
        }
        
        _leftViewShow = true
    }
    
    @objc func screenEdgePanGesture(screenEdgeGesture:UIScreenEdgePanGestureRecognizer)
    {
        if _leftViewShow
        {
            return
        }
        
        let point = screenEdgeGesture.location(in: self.view) 
        var frame = _leftView.frame
        frame.origin.x = point.x - UIScreen.ScrWidth()
        _leftView.frame = frame
        
        if _leftView.frame.origin.x + 160 + 10 > 0
        {
            _rightScrollView.frame = CGRect.init(x: _leftView.frame.origin.x + 160 + 10, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
        }
        
        if screenEdgeGesture.state == .ended || screenEdgeGesture.state == .cancelled
        {
            leftViewShowAnimation()
        }
        
    }
    
    
    @objc private func topButtonClick()
    {
//        if _isHaveError
//        {
            //查询故障码
            OBDOrderManager.shared().setOrderWithOrderIndex(10, isCheck: true, newOrder: "")
            
            let wrongVC = WrongCodeViewController()
            self.navigationController?.pushViewController(wrongVC, animated: true)
//        }
    }
    
    @objc private func bottomButtonClick()
    {
        let controlCenterVC = ControlCenterViewController()
        self.navigationController?.pushViewController(controlCenterVC, animated: true)
    }

    //K-V-O 监听蓝牙状态
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        let linkState = change?[NSKeyValueChangeKey.newKey]
        
        let state : OBDLinkState = OBDLinkState(rawValue: linkState as! UInt)!
        
        switch state
        {
        case .bluetoothOff:
            
            let alertController = UIAlertController.init(title: "蓝牙关闭", message: "我们检测到您的蓝牙处于关闭状态，无法连接到设备，请您打开蓝牙", preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            let openAction = UIAlertAction.init(title: "打开", style: .default, handler: { (action:UIAlertAction) in
                
                let url:NSURL = NSURL(string: "App-Prefs:root=Bluetooth")!
                if UIApplication.shared.canOpenURL(url as URL)
                {
                    UIApplication.shared.openURL(url as URL)
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(openAction)
            self.present(alertController, animated: true, completion: nil)
            
            break
        case .bluetoothOn:
            
            break
        case .startScan://连接中...

            break
        case .scanSuccess://连接成功

            
            break
        case .scanFail://连接错误
            
            let alertController = UIAlertController.init(title: "连接失败", message: "由于未知原因，我们无法连接到您的设备", preferredStyle: .alert)
            let cancelAction = UIAlertAction.init(title: "知道了", style: .cancel, handler: nil)
            let openAction = UIAlertAction.init(title: "再次连接", style: .default, handler: { (action:UIAlertAction) in
                OBDCentralMangerModel.shared().scanPeripherals()
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(openAction)
            self.present(alertController, animated: true, completion: nil)
            
            break
        default:
            
            
            break
        }
    }

}
