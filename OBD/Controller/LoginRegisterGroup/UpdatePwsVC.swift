//
//  UpdatePwsVC.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class UpdatePwsVC: LoginBaseViewController,UINavigationControllerDelegate
{
    private var inputContentView:UIView?
    private var verCodeString:String?
    private let httpManager:LoginHttpManager = LoginHttpManager.init()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        
        let thirdLable:UILabel = UILabel.init()
        thirdLable.text = "忘记密码"
        thirdLable.backgroundColor = UIColor.clear
        thirdLable.font = UIFont.systemFont(ofSize: 13)
        thirdLable.textColor = UIColor.RGBA(234, 105 , 86, 1 )
        self.view.addSubview(thirdLable)
        thirdLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
                make.height.equalTo()(18)
        }
        
        let inputView = UIView()
        self.setInputViewSubView(superView: inputView)
        self.view.addSubview(inputView)
        inputView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(thirdLable.mas_bottom)?.with().offset()(15)
                make.centerY.equalTo()(self.view)
                make.left.mas_equalTo()(40)
                make.right.mas_equalTo()(-40)
        }
        
        self.inputContentView = inputView

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
    {
        if viewController.isKind(of: AccountSetViewController.classForCoder())
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }


    func setInputViewSubView(superView:UIView)
    {
        superView.backgroundColor = UIColor.RGBA(76, 76 , 76, 1 )
        superView.layer.cornerRadius = 20
        superView.clipsToBounds = true
        
        let viewHeight = (UIScreen.main.bounds.size.width - 100) / 262 * 44
        
        let accountView = InputView.init(placterText: "邮箱/手机号", isVerBtn: false)!
        accountView.layer.cornerRadius = viewHeight / 2.0
        accountView.tag = 1
        superView.addSubview(accountView)
        accountView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.mas_equalTo()(10)
                make.left.mas_equalTo()(10)
                make.right.mas_equalTo()(-10)
                make.height.mas_equalTo()(accountView.mas_width)?.multipliedBy()(44/262.0)
        }
        
        
        let verCodeView = InputView.init(placterText: "验证码", isVerBtn: true)!
        verCodeView.layer.cornerRadius = accountView.layer.cornerRadius
        verCodeView.verCodeButton.addTarget(self, action: #selector(getVerificationCodeButtonClick), for: .touchUpInside)
        verCodeView.tag = 2
        superView.addSubview(verCodeView)
        verCodeView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.equalTo()(accountView.mas_bottom)?.with().offset()(5)
                make.left.mas_equalTo()(10)
                make.right.mas_equalTo()(-10)
                make.height.equalTo()(accountView.mas_height)
                make.width.equalTo()(accountView.mas_width)
        }
        
        let passwordView = InputView.init(placterText: "密码", isVerBtn: false)!
        passwordView.layer.cornerRadius = accountView.layer.cornerRadius
        passwordView.textFiled.isSecureTextEntry = true
        passwordView.tag = 3
        superView.addSubview(passwordView)
        passwordView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.equalTo()(verCodeView.mas_bottom)?.with().offset()(5)
                make.left.mas_equalTo()(10)
                make.right.mas_equalTo()(-10)
                make.height.equalTo()(accountView.mas_height)
                make.width.equalTo()(accountView.mas_width)
        }
        
        
        
        let updateButton = UIButton.init(type: .custom)
        updateButton.setTitle("确认修改", for: .normal)
        updateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        updateButton.setTitleColor(UIColor.RGBA(153, 153, 153, 1), for: .normal)
        updateButton.layer.borderWidth = 1.5
        updateButton.addTarget(self, action: #selector(confirmUpdatePasswordButtonClick), for: .touchUpInside)
        updateButton.layer.borderColor = UIColor.RGBA(239, 101, 82, 1).cgColor
        updateButton.layer.cornerRadius = accountView.layer.cornerRadius
        updateButton.clipsToBounds = true
        superView.addSubview(updateButton)
        updateButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.equalTo()(passwordView.mas_bottom)?.with().offset()(5)
                make.left.mas_equalTo()(10)
                make.right.mas_equalTo()(-10)
                make.height.equalTo()(accountView.mas_height)
                make.width.equalTo()(accountView.mas_width)
                make.bottom.mas_equalTo()(-10)
        }
    }
    
    
    
    override func keyBoardChange(notification:Notification)
    {
        let duration  = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let keyboardY : CGFloat = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.origin.y)
        
        
        let y = keyboardY - (self.inputContentView?.frame.maxY)!
        
        
        if y < 0
        {
            UIView.animate(withDuration: duration!, animations:
                {
                    self.view.frame = CGRect.init(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
        }
        else
        {
            if self.view.frame.origin.y < 0
            {
                UIView.animate(withDuration: duration!, animations:
                    {
                        self.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: nil)
            }
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.inputContentView?.endEditing(true)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.inputContentView?.endEditing(true)
    }
    
    @objc private func getVerificationCodeButtonClick()
    {
        self.inputContentView?.endEditing(true)
        
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        
        let verCodeView = self.inputContentView?.viewWithTag(2) as! InputView

        if (accountView.textFiled.text != nil) && (accountView.textFiled.text?.count)! > 0
        {
            print("获取验证码")
            
            if ValidateClass.isMobileOrEmail(accountView.textFiled.text)
            {
                let parDict:NSDictionary = ["mobile_phone":accountView.textFiled.text,"user_id":""]
                
                verCodeView.startSendVerCode()
                
                self.httpManager.getVerificationCode(withParameterDict: parDict as! [AnyHashable : Any], successBlock: { [weak self] (string:String?) in
                    self?.verCodeString = string
                }) { (error:Error?) in
                    verCodeView.cancelSendVerCode()
                }
            }
            else
            {
                ErrorTipView.errorTip("不合法的手机号或邮箱，请检查是否正确", superView: self.view)
            }
        }
        else
        {
            print("请输入手机号")
            
            ErrorTipView.errorTip("请输入手机或邮箱", superView: self.view)
        }
    }

    
    @objc private func confirmUpdatePasswordButtonClick()
    {
        self.inputContentView?.endEditing(true)
        if infoIsCorrect() == false
        {
            return
        }
        
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let verCodeView = self.inputContentView?.viewWithTag(2) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(3) as! InputView
        
        
        let parDict:NSDictionary = ["user_name":accountView.textFiled.text,"salt":verCodeView.textFiled.text,"password":passwordView.textFiled.text,"froms":"iOS"]

        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)

        self.httpManager.resetPassword(withParameters: parDict as! [AnyHashable : Any], successBlock: { [weak self] (string:String?) in
            hud.hide(animated: true)

            self?.navigationController?.popViewController(animated: true)
            
        }) { (error:Error?) in
            hud.hide(animated: true)
        }
     }
    
    
    private func infoIsCorrect() -> Bool
    {
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let verCodeView = self.inputContentView?.viewWithTag(2) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(3) as! InputView
        
        
        if (accountView.textFiled.text == nil) || accountView.textFiled.text?.count == 0
        {
            ErrorTipView.errorTip("请输入手机或邮箱", superView: self.view)
            
            return false
        }
        
        
        if ValidateClass.isMobileOrEmail(accountView.textFiled.text) == false
        {
            ErrorTipView.errorTip("不合法的手机号或邮箱，请检查是否正确", superView: self.view)
            return false
        }

        if (verCodeView.textFiled.text == nil) || verCodeView.textFiled.text?.count == 0
        {
            ErrorTipView.errorTip("请输入验证码", superView: self.view)
            return false
        }
        
        if verCodeView.textFiled.text != self.verCodeString
        {
            ErrorTipView.errorTip("验证码错误", superView: self.view)
            
            return false
        }
        
        
        if (passwordView.textFiled.text == nil) || passwordView.textFiled.text?.count == 0
        {
            ErrorTipView.errorTip("请输入密码", superView: self.view)
            
            return false
        }
        
        
        return true
    }
    
    
}
