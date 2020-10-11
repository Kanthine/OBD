//
//  ControlPatternViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class ControlPatternViewController: UIViewController,ControlPatternItemViewDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        self.navigationItem.title = "自动模式设置"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.view.backgroundColor = UIColor.RGBA(31, 31, 31, 1)
        
        
        let mainView = UIView.init()
        setMainView(mainView: mainView)
        self.view.addSubview(mainView)
        
        
        let bottomView = FWDBottomBarView.init()
        bottomView.tag = 832
        bottomView.setFWDBottomBarView(navBarShow: true)
        bottomView.barButton.addTarget(self, action: #selector(leftItemClick), for: .touchUpInside)
        self.view.addSubview(bottomView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setMainView(mainView:UIView)
    {
        let itemHieght:CGFloat = 110.0
        let itemWidth:CGFloat = UIScreen.ScrWidth() - 160
        let bottomHeight = UIScreen.ScrWidth() * 150.0 / 750.0

        
        mainView.tag = 10
        mainView.frame = CGRect.init(x: (UIScreen.ScrWidth() - itemWidth) / 2.0, y: (UIScreen.ScrHeight() - itemHieght * 3 - 10 * 2 - 64 - bottomHeight) / 2.0, width: itemWidth, height: itemHieght * 3 + 10 * 2)
        mainView.backgroundColor = UIColor.clear

        
        
        let topView = ControlPatternItemView.init(frame: CGRect.init(x: 0, y: 0, width: itemWidth, height: itemHieght), patternType: .comfortable)
        topView?.delegate = self
        topView?.tag = 101
        mainView.addSubview(topView!)
        
        let centerView = ControlPatternItemView.init(frame: CGRect.init(x: 0, y: (topView?.frame.maxY)! + 10, width: itemWidth, height: itemHieght), patternType: .general)
        centerView?.delegate = self
        centerView?.tag = 102
        mainView.addSubview(centerView!)
        
        let bottomView = ControlPatternItemView.init(frame: CGRect.init(x: 0, y: (centerView?.frame.maxY)! + 10, width: itemWidth, height: itemHieght), patternType: .sport)
        bottomView?.delegate = self
        bottomView?.tag = 103
        mainView.addSubview(bottomView!)
    }
    
    
    func configurationModelDataClick(_ configurationModel: BoxControlAutoModelConfiguration!)
    {
        let shadowButton = UIButton.init(type: .custom)
        shadowButton.tag = 12
        shadowButton.backgroundColor = UIColor.clear
        shadowButton.addTarget(self, action: #selector(removeRightView), for: .touchUpInside)
        shadowButton.frame = CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: UIScreen.ScrHeight())
        self.view.addSubview(shadowButton)


        let rightView:ControlPatternRightView = ControlPatternRightView.init(configurationModel: configurationModel)
        rightView.tag = 11
        self.view.addSubview(rightView)
        
        
        let bottomBarView = self.view.viewWithTag(832)
        self.view.bringSubviewToFront(bottomBarView!)

        
        let mainView:UIView = self.view.viewWithTag(10)!
        
        UIView.animate(withDuration: 0.5) { 
            
            shadowButton.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            rightView.frame = CGRect.init(x: UIScreen.ScrWidth() - rightView.frame.width, y: rightView.frame.origin.y, width: rightView.frame.width, height: rightView.frame.height)
            
            mainView.frame = CGRect.init(x: 0, y: mainView.frame.origin.y, width: mainView.frame.width, height: mainView.frame.height)

        }
        
    }
    
    func setDefaultPatternClick(_ itemView: ControlPatternItemView!) {
        
        let mainView:UIView = self.view.viewWithTag(10)!

        let topView:ControlPatternItemView = mainView.viewWithTag(101) as! ControlPatternItemView
        
        let centerView:ControlPatternItemView = mainView.viewWithTag(102) as! ControlPatternItemView
        
        let bottomView:ControlPatternItemView = mainView.viewWithTag(103) as! ControlPatternItemView

        
        itemView.configurationModel.isDefault = true

        switch itemView.tag {
        case 101:
            centerView.configurationModel.isDefault = false
            bottomView.configurationModel.isDefault = false
            break
        case 102:
            topView.configurationModel.isDefault = false
            bottomView.configurationModel.isDefault = false
            break
        case 103:
            topView.configurationModel.isDefault = false
            centerView.configurationModel.isDefault = false
            break
        default:
            break
        }
        
    }
    
    @objc private func removeRightView()
    {
        let shadowButton:UIButton = self.view.viewWithTag(12)! as! UIButton
        let rightView:ControlPatternRightView = self.view.viewWithTag(11) as! ControlPatternRightView
        let mainView:UIView = self.view.viewWithTag(10)!


        UIView.animate(withDuration: 0.5, animations: { 
            
            shadowButton.backgroundColor = UIColor.clear
            
            rightView.frame = CGRect.init(x: UIScreen.ScrWidth(), y: (rightView.frame.origin.y), width: (rightView.frame.width), height: (rightView.frame.height))
            
            mainView.frame = CGRect.init(x: (UIScreen.ScrWidth() - mainView.frame.width) / 2.0, y: mainView.frame.origin.y, width: mainView.frame.width, height: mainView.frame.height)
            
        }) { (isFinish:Bool) in
            
            shadowButton.removeFromSuperview()
            rightView.removeFromSuperview()
        }
    }
}
