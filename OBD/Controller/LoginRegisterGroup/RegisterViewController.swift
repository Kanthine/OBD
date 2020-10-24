//
//  RegisterViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class RegisterViewController: LoginBaseViewController
{
    private let httpManager:LoginHttpManager = LoginHttpManager.init()

    private var inputContentView:UIView?
    private var verCodeString:String?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        let titleLable:UILabel = UILabel.init()
        titleLable.text = "为声浪而生"
        titleLable.backgroundColor = UIColor.clear
        titleLable.font = UIFont.systemFont(ofSize: 15)
        titleLable.textColor = UIColor.RGBA(234, 105 , 86, 1 )
        self.view.addSubview(titleLable)
        titleLable.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                
                make.top.equalTo()(self.titleView.mas_bottom)?.with().offset()(30)
                make.centerX.equalTo()(self.view.mas_centerX)
                make.height.equalTo()(20)
        }

        
        let thirdLable:UILabel = UILabel.init()
        thirdLable.text = "创建一个账号"
        thirdLable.backgroundColor = UIColor.clear
        thirdLable.font = UIFont.systemFont(ofSize: 13)
        thirdLable.textColor = UIColor.RGBA(234, 105 , 86, 1 )
        self.view.addSubview(thirdLable)
        thirdLable.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(titleLable.mas_bottom)?.with().offset()(15)
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
            make.left.mas_equalTo()(40)
            make.right.mas_equalTo()(-40)
        }
        self.inputContentView = inputView
        
        
        let thirdView = UIView()
        self.setThirdViewSubView(superView: thirdView)
        self.view.addSubview(thirdView)
        thirdView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(40)
            make.right.mas_equalTo()(-40)
            make.bottom.equalTo()(-getTabBarHeight())
            make.height.equalTo()(50)
        }
        
        
        let orLable:UILabel = UILabel.init()
        orLable.text = "Or"
        orLable.backgroundColor = UIColor.clear
        orLable.font = UIFont.systemFont(ofSize: 18)
        orLable.textColor = UIColor.RGBA(169, 169, 169,1)
        self.view.addSubview(orLable)
        orLable.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.bottom.equalTo()(thirdView.mas_top)?.with().offset()(-10)
            make.centerX.equalTo()(self.view.mas_centerX)
            make.height.equalTo()(20)
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        verCodeView.verCodeButton.addTarget(self, action: #selector(getVerificationCodeButtonClick(sender:)), for: .touchUpInside)
        verCodeView.layer.cornerRadius = viewHeight / 2.0
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

        let passwordView = InputView.init(placterText: "确认密码", isVerBtn: false)!
        passwordView.textFiled.isSecureTextEntry = true
        passwordView.layer.cornerRadius = viewHeight / 2.0
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
        
        
        
        let registerButton = UIButton.init(type: .custom)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.setTitleColor(UIColor.RGBA(153, 153, 153, 1), for: .normal)
        registerButton.layer.borderWidth = 1.5
        registerButton.layer.borderColor = UIColor.RGBA(239, 101, 82, 1).cgColor
        registerButton.layer.cornerRadius = viewHeight / 2.0
        registerButton.clipsToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        superView.addSubview(registerButton)
        registerButton.mas_makeConstraints
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
    
    
    
    func setThirdViewSubView(superView:UIView)
    {
        superView.backgroundColor = UIColor.RGBA(76, 76 , 76, 1 )
        superView.layer.cornerRadius = 25
        superView.clipsToBounds = true
        
        let orLable:UILabel = UILabel.init()
        orLable.text = "快速登录"
        orLable.backgroundColor = UIColor.clear
        orLable.font = UIFont.systemFont(ofSize: 14)
        orLable.textColor = UIColor.RGBA(155, 155, 155,1)
        superView.addSubview(orLable)
        orLable.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.centerY.equalTo()(superView)
            make.left.mas_equalTo()(20)
        }
        
        
        let fbButton = UIButton.init(type: .custom)
        fbButton.addTarget(self, action: #selector(fbLoginButtonClick), for: .touchUpInside)
        fbButton.setImage(UIImage.init(named: "LoginRegister_FaceBook"), for: .normal)
        superView.addSubview(fbButton)
        fbButton.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.mas_equalTo()(6)
                make.right.mas_equalTo()(-6)
                make.bottom.mas_equalTo()(-6)
                make.width.mas_equalTo()(fbButton.mas_height)?.multipliedBy()(1.0)
        }
        
        let weChatButton = UIButton.init(type: .custom)
        weChatButton.addTarget(self, action: #selector(weChatLoginButtonClick), for: .touchUpInside)
        weChatButton.setImage(UIImage.init(named: "LoginRegister_WeChat"), for: .normal)
        superView.addSubview(weChatButton)
        weChatButton.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                make.top.mas_equalTo()(6)
                make.right.equalTo()(fbButton.mas_left)?.with().offset()(-6)
                make.bottom.mas_equalTo()(-6)
                make.width.mas_equalTo()(weChatButton.mas_height)?.multipliedBy()(1.0)
        }
        
        let qqButton = UIButton.init(type: .custom)
        qqButton.addTarget(self, action: #selector(qqLoginButtonClick), for: .touchUpInside)
        qqButton.setImage(UIImage.init(named: "LoginRegister_QQ"), for: .normal)
        superView.addSubview(qqButton)
        qqButton.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(6)
            make.right.equalTo()(weChatButton.mas_left)?.with().offset()(-6)
            make.bottom.mas_equalTo()(-6)
            make.width.mas_equalTo()(qqButton.mas_height)?.multipliedBy()(1.0)
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

    @objc private func getVerificationCodeButtonClick(sender:UIButton)
    {
        self.inputContentView?.endEditing(true)

        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        
        let verCodeView = self.inputContentView?.viewWithTag(2) as! InputView

        if (accountView.textFiled.text != nil) && (accountView.textFiled.text?.count)! > 0 {
            print("获取验证码")

            if ValidateClass.isMobileOrEmail(accountView.textFiled.text){
                verCodeView.startSendVerCode()
                self.verCodeString = "123456"
            }else{
                ErrorTipView.errorTip("不合法的手机号或邮箱，请检查是否正确", superView: self.view)
            }
            
        }else{
            print("请输入手机号")

            ErrorTipView.errorTip("请输入手机或邮箱", superView: self.view)
        }
    }

    @objc func registerButtonClick()
    {
        //注册
        print("注册")
        self.inputContentView?.endEditing(true)

        
        if infoIsCorrect() == false{
            return
        }
        
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let verCodeView = self.inputContentView?.viewWithTag(2) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(3) as! InputView
        
        
        AccountInfo.standard()?.phone = accountView.textFiled.text
        AccountInfo.standard()?.password = passwordView.textFiled.text
        AccountInfo.standard()?.uToken = passwordView.textFiled.text
        AccountInfo.standard()?.store()
        self.loginSuccessNextStep()
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
    
    private func loginSuccessNextStep(){
        let productTypeVC = ProductTypeSetVC()
        let nav = UINavigationController.init(rootViewController: productTypeVC)
        nav.isNavigationBarHidden = true
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
        UIView.transition(from: self.view, to: productTypeVC.view, duration: 0.5, options: .transitionFlipFromLeft)
        { (finished) in
            window.rootViewController = nav
        }
    }
    
    
    
    
    @objc func qqLoginButtonClick(){
        self.view.endEditing(true)

        AccountInfo.standard()?.nickname = "QQ登录"
        
        
        UMSocialManager.default().getUserInfo(with: .QQ, currentViewController: self) { [weak self]  (result,error:Error?) in
            
            if let data = result as? UMSocialUserInfoResponse
            {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"1","nickname":data.name,"headimg":data.iconurl]
                
                
                print("QQ登录结果 ========= \(String(describing: parDict))")
                
                self?.thirdPartyLoginWithPlayform(parametersDict: parDict)
            }
            
            
        }
        
    }
    
    @objc func weChatLoginButtonClick()
    {
        self.view.endEditing(true)
        
        AccountInfo.standard()?.nickname = "微信登录"
        
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self) {[weak self] (result, error:Error?) in
            
            
            if let data = result as? UMSocialUserInfoResponse
            {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"2","nickname":data.name,"headimg":data.iconurl]
                
                
                
                print("weChat登录结果 ========= \(String(describing: parDict))")
                
                self?.thirdPartyLoginWithPlayform(parametersDict: parDict)
            }
            
            
            
        }
    }
    @objc func fbLoginButtonClick()
    {
        self.view.endEditing(true)
        
        AccountInfo.standard()?.nickname = "facebook 登录"

        
        UMSocialManager.default().getUserInfo(with: .facebook, currentViewController: self) {[weak self] (result,error:Error?) in
            
            if let data = result as? UMSocialUserInfoResponse
            {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"3","nickname":data.name,"headimg":data.iconurl]
                
                
                print("facebook登录结果 ========= \(String(describing: parDict))")
                
                self?.thirdPartyLoginWithPlayform(parametersDict: parDict)
            }
            
        }
        
    }
    
    
    
    private func thirdPartyLoginWithPlayform(parametersDict:NSDictionary)
    {
        self.httpManager.thirdPartyLogin(withParameterDict: parametersDict as! [AnyHashable : Any], successBlock: { (account:AccountInfo?) in
            
            if (account?.store())!
            {
                print("登录成功")
                self.loginSuccessNextStep()
            }
            
        }) { (error:Error?) in
            ErrorTipView.errorTip(error?.localizedDescription, superView: self.view)
        }
        
    }
    
    private func localNoAppTip(platform:String){
        let alertController = UIAlertController.init(title: "温馨提示", message: "由于本地没有安装\(platform)，所以您无法获得\(platform)的授权", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "我知道了", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
