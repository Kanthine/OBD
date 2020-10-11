//
//  SharePopView.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/17.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

@objc public protocol SharePopViewDelegate:NSObjectProtocol {
    func shareSelectedPlatform(platformType:UMSocialPlatformType)
}


class SharePopView: UIView {

    weak var delegate : SharePopViewDelegate?

    var qqButton: UIButton!
    var qqZoneButton: UIButton!
    var weChatButton: UIButton!
    var weChatSessionButton: UIButton!
    var faceBookButton: UIButton!
    var videoButton: UIButton!
    var backgroundView: UIView!
    var nevermindButton: UIButton!
    var centerHigh: [CGPoint]!
    var centerLow: [CGPoint]!
    var centerMenu: [CGPoint]!
    var isHidding: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initImageView()
        initCenterArray(frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initCenterArray(_ frame: CGRect){
        let widthUnit = frame.width/4
        let heightHigh = frame.origin.y - qqButton.frame.height/2
        let heightLow = frame.height + qqButton.frame.height/2
        let gap = qqButton.frame.height/2 + 5
        centerHigh = [CGPoint]()
        centerHigh.append(CGPoint(x: widthUnit, y: heightHigh))
        centerHigh.append(CGPoint(x: widthUnit*2, y: heightHigh))
        centerHigh.append(CGPoint(x: widthUnit*3, y: heightHigh))
        
        centerLow = [CGPoint]()
        centerLow.append(CGPoint(x: widthUnit, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*2, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*3, y: heightLow))
        centerLow.append(CGPoint(x: widthUnit*2, y: frame.height + nevermindButton.frame.height/2))
        
        centerMenu = [CGPoint]()
        centerMenu.append(CGPoint(x: widthUnit, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit*3, y: frame.height/2 - gap))
        centerMenu.append(CGPoint(x: widthUnit, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*3, y: frame.height/2 + gap))
        centerMenu.append(CGPoint(x: widthUnit*2, y: frame.height - nevermindButton.frame.height/2))
    }
    
    fileprivate func initImageView(){
        let image = UIImage(named: "share_QQ")
        let frame = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        qqButton = UIButton(frame: frame)
        qqButton.setBackgroundImage(UIImage(named: "share_QQ")!, for: .normal)
        
        qqZoneButton = UIButton(frame: frame)
        qqZoneButton.setBackgroundImage(UIImage(named: "share_QQZone")!, for: .normal)
        
        weChatButton = UIButton(frame: frame)
        weChatButton.setBackgroundImage(UIImage(named: "Share_WeChat")!, for: .normal)
        
        weChatSessionButton = UIButton(frame: frame)
        weChatSessionButton.setBackgroundImage(UIImage(named: "Share_WeChatSesssion")!, for: .normal)
        
        faceBookButton = UIButton(frame: frame)
        faceBookButton.setBackgroundImage(UIImage(named: "share_Facebook")!, for: .normal)
        
        videoButton = UIButton(frame: frame)
        videoButton.setBackgroundImage(UIImage(named: "share_Facebook")!, for: .normal)
        videoButton.isHidden = true
        
        nevermindButton = UIButton(type: .system)
        nevermindButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 45)
        nevermindButton.setTitle("取消", for: .normal)
        nevermindButton.backgroundColor = UIColor.red
        backgroundView = UIView(frame: self.frame)
        
        qqButton.tag = 1
        qqZoneButton.tag = 2
        weChatButton.tag = 3
        weChatSessionButton.tag = 4
        faceBookButton.tag = 5
        videoButton.tag = 6
    }
    
    fileprivate func setupView(){
        self.isHidden = true
        backgroundView.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 100/255, alpha: 0.95)
        backgroundView.backgroundColor = UIColor.RGBA(255, 255, 255, 0.8)

        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SharePopView.handleTap(_:))))
        backgroundView.isUserInteractionEnabled = true
        
        nevermindButton.isHidden = true
        nevermindButton.isUserInteractionEnabled = true
        nevermindButton.backgroundColor = UIColor(red: 61/255, green: 77/255, blue: 97/255, alpha: 1.0)
        nevermindButton.tintColor = UIColor(red: 133/255, green: 141/255, blue: 152/255, alpha: 1.0)
        nevermindButton.addTarget(self, action: #selector(SharePopView.handleTap(_:)), for: .touchUpInside)
        
        qqButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        qqZoneButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        weChatButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        weChatSessionButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        faceBookButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(SharePopView.clickMenu(_:)), for: .touchUpInside)
        
        self.addSubview(backgroundView)
        self.addSubview(qqButton)
        self.addSubview(qqZoneButton)
        self.addSubview(weChatButton)
        self.addSubview(faceBookButton)
        self.addSubview(weChatSessionButton)
        self.addSubview(videoButton)
        self.addSubview(nevermindButton)
    }
    
    @objc func clickMenu(_ sender: AnyObject){
        print("clickMenu")
        let index = (sender as! UIButton).tag
        hideMenuView()
        
        var platType:UMSocialPlatformType = .QQ
        switch index {
        case 1:
            platType = .QQ
            break
        case 2:
            platType = .qzone
            break
        case 3:
            platType = .wechatSession
            break
        case 4:
            platType = .wechatTimeLine
            break
        case 5:
            platType = .facebook
            break
        case 6:
            break
        default:
            break
        }
                
        
        if (delegate != nil)
        {
            delegate?.shareSelectedPlatform(platformType: platType)
        }
        
        
        
    }
    
    @objc func handleTap(_ sender: AnyObject){
        print("handleTap")
        hideMenuView()
    }
    
    fileprivate func hideMenuView(){
        print("hideMenuView")
        if isHidding{
            return
        }
        
        isHidding = true
        //Nevermind button
        nevermindButton.center = centerMenu[6]
        UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.nevermindButton.center = self.centerLow[3]
        }) { (finished) -> Void in
            self.nevermindButton.isHidden = true
            self.isHidding = false
        }
        
        // Photo Image
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.qqZoneButton.center = self.centerHigh[1]
        }) { (finished) -> Void in
            self.isHidden = true
        }
        
        // Text | Chat | Quote Image
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.qqButton.center = self.centerHigh[0]
            self.weChatButton.center = self.centerHigh[2]
            self.faceBookButton.center = self.centerHigh[1]
        }) { (finished) -> Void in
        }
        
        // Link | Video Image
        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.weChatSessionButton.center = self.centerHigh[0]
            self.videoButton.center = self.centerHigh[2]
        }) { (finished) -> Void in
        }
    }
    
    @objc func showMenuView(){
        print("showMenuView")
        
        self.isHidden = false
        
        nevermindButton.center = centerLow[3]
        nevermindButton.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.nevermindButton.center = self.centerMenu[6]
        }) { (finished) -> Void in
        }
        
        // Photo Image
        qqZoneButton.center = centerLow[1]
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.qqZoneButton.center = self.centerMenu[1]
        }) { (finished) -> Void in
        }
        
        // Text | Chat | Quote Image
        qqButton.center = centerLow[0]
        weChatButton.center = centerLow[2]
        faceBookButton.center = centerLow[1]
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.qqButton.center = self.centerMenu[0]
            self.weChatButton.center = self.centerMenu[2]
            self.faceBookButton.center = self.centerMenu[4]
        }) { (finished) -> Void in
        }
        
        // Link | Video Image
        weChatSessionButton.center = centerLow[0]
        videoButton.center = centerLow[2]
        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.weChatSessionButton.center = self.centerMenu[3]
            self.videoButton.center = self.centerMenu[5]
        }) { (finished) -> Void in
        }
    }    
}
