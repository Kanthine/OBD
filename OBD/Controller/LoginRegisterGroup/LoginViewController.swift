//
//  LoginViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class LoginViewController: LoginBaseViewController,UINavigationControllerDelegate
{
    private var inputContentView:UIView?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navBar.isHidden = true
        
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
        thirdLable.text = "关联社交账号快速登录"
        thirdLable.backgroundColor = UIColor.clear
        thirdLable.font = UIFont.systemFont(ofSize: 14)
        thirdLable.textColor = UIColor.RGBA(169 , 169, 169, 1)
        self.view.addSubview(thirdLable)
        thirdLable.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(titleLable.mas_bottom)?.with().offset()(15)
                make.centerX.equalTo()(self.view.mas_centerX)
                make.height.equalTo()(18)
        }
        
        let thirdView = LoginThirdPartyView()
        thirdView.setLoginSubView()
        self.view.addSubview(thirdView)
        thirdView.mas_makeConstraints
            {
                (make:MASConstraintMaker!) in
                make.top.equalTo()(thirdLable.mas_bottom)?.with().offset()(15)
                make.left.equalTo()(60)
                make.right.equalTo()(-60)
        }
        thirdView.qqButton?.addTarget(self, action: #selector(qqLoginButtonClick(sender:)), for: .touchUpInside)
        thirdView.weChatButton?.addTarget(self, action: #selector(weChatLoginButtonClick(sender:)), for: .touchUpInside)
        thirdView.fbButton?.addTarget(self, action: #selector(fbLoginButtonClick(sender:)), for: .touchUpInside)

        
        let loginLable:UILabel = UILabel.init()
        loginLable.text = "登录"
        loginLable.backgroundColor = UIColor.clear
        loginLable.font = UIFont.systemFont(ofSize: 15)
        loginLable.textColor = UIColor.RGBA(169, 169, 169,1)
        self.view.addSubview(loginLable)
        loginLable.mas_makeConstraints
        {
                (make:MASConstraintMaker!) in
                make.centerX.equalTo()(self.view.mas_centerX)
        }
        
        
        
        let inputView = LoginInputView()
        inputView.setSubView()
        inputView.forgetButton?.addTarget(self, action: #selector(updatePwdButtonClick), for: .touchUpInside)
        inputView.loginButton?.addTarget(self, action: #selector(loginAccountButtonClick), for: .touchUpInside)
        self.view.addSubview(inputView)
        inputView.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            make.top.equalTo()(loginLable.mas_bottom)?.with().offset()(10)
            make.left.equalTo()(50)
            make.right.equalTo()(-50)
        }
        self.inputContentView = inputView
        
        
        
        let registerButton = UIButton.init(type: .custom)
        registerButton.setTitle("创建一个账号", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        registerButton.contentHorizontalAlignment = .right
        registerButton.setTitleColor(UIColor.RGBA(153, 153, 153, 1), for: .normal)
        self.view.addSubview(registerButton)
        registerButton.mas_makeConstraints
        {
            (make:MASConstraintMaker!) in
            
            make.top.equalTo()(inputView.mas_bottom)?.with().offset()(0)
            make.left.equalTo()(50)
            make.right.equalTo()(-50)
            make.height.equalTo()(50)
            make.bottom.equalTo()(-getTabBarHeight())
        }
    }
    
    @objc func loginAccountButtonClick(){
        self.view.endEditing(true)

        if infoIsCorrect() == false{
            return
        }
        
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(2) as! InputView
        
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "登录"
        
        AccountInfo.standard()?.phone = accountView.textFiled.text
        AccountInfo.standard()?.password = passwordView.textFiled.text
        AccountInfo.standard()?.uToken = passwordView.textFiled.text
        hud.hide(animated: true)
 
        if (AccountInfo.standard()?.store())!{
            print("登录成功")
            self.loginSuccess()
        }
    }
    
    
    private func infoIsCorrect() -> Bool{
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(2) as! InputView
        
        if (accountView.textFiled.text == nil) || accountView.textFiled.text?.count == 0{
            ErrorTipView.errorTip("请输入手机或邮箱", superView: self.view)
            return false
        }
        
        if ValidateClass.isMobileOrEmail(accountView.textFiled.text) == false{
            ErrorTipView.errorTip("不合法的手机号或邮箱，请检查是否正确", superView: self.view)
            return false
        }
                
        if (passwordView.textFiled.text == nil) || passwordView.textFiled.text?.count == 0{
            ErrorTipView.errorTip("请输入密码", superView: self.view)
            return false
        }
        return true
    }

    
    
    @objc func updatePwdButtonClick()
    {
        self.view.endEditing(true)

        let registerVC = UpdatePwsVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }

    
    @objc func registerButtonClick()
    {
        self.view.endEditing(true)

        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    override func keyBoardChange(notification:Notification)
    {
        
        let accountView = self.inputContentView?.viewWithTag(1) as! InputView
        let passwordView = self.inputContentView?.viewWithTag(2) as! InputView
        
        
        if accountView.textFiled.isFirstResponder == false && passwordView.textFiled.isFirstResponder == false
        {
            return
        }
        
        
        
        let duration  = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let keyboardY : CGFloat = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.origin.y)

        var y = keyboardY - self.view.frame.size.height
        if y < -10
        {
            y = y + 100
        }
        
        
        UIView.animate(withDuration: duration!, animations: {
            self.view.frame = CGRect.init(x: 0, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)

    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @objc private func qqLoginButtonClick(sender:UIButton) {
        self.view.endEditing(true)
        
        UMSocialManager.default().getUserInfo(with: .QQ, currentViewController: self) { [weak self]  (result,error:Error?) in
            
            if let data = result as? UMSocialUserInfoResponse {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"1","nickname":data.name,"headimg":data.iconurl]
                
                print("QQ登录结果 ========= \(String(describing: parDict))")
                
                self?.thirdPartyLoginWithPlayform(parametersDict: parDict, sender: sender)
            }
        }
    }
    
    @objc private func weChatLoginButtonClick(sender:UIButton){
        self.view.endEditing(true)
        
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self) {[weak self] (result, error:Error?) in
            
            if let data = result as? UMSocialUserInfoResponse {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"2","nickname":data.name,"headimg":data.iconurl]
                                
                print("weChat登录结果 ========= \(String(describing: parDict))")

                self?.thirdPartyLoginWithPlayform(parametersDict: parDict, sender: sender)
            }
        }
    }
    
    @objc private func fbLoginButtonClick(sender:UIButton){
        self.view.endEditing(true)
        
        print("facebook")

        UMSocialManager.default().getUserInfo(with: .facebook, currentViewController: self) {[weak self] (result,error:Error?) in

            if let data = result as? UMSocialUserInfoResponse {
                let parDict:NSDictionary = ["aite_id":data.uid,"login_type":"3","nickname":data.name,"headimg":data.iconurl]
                
                print("facebook登录结果 ========= \(String(describing: parDict))")
                
                self?.thirdPartyLoginWithPlayform(parametersDict: parDict, sender: sender)
            }
        }
    }
    
    private func thirdPartyLoginWithPlayform(parametersDict:NSDictionary ,sender:UIButton) {
        let imageView = sender.superview?.viewWithTag(91) as! UIImageView
        imageView.isHighlighted = true
        rotationCircleAnimation(superView: imageView)
        
        imageView.isHighlighted = false
        imageView.layer.removeAllAnimations()
        if (AccountInfo.standard()?.store())! {
            print("登录成功")
            self.loginSuccess()
        }
    }
    
    private func loginSuccess(){
        let productTypeVC = ProductTypeSetVC()
        let nav = UINavigationController.init(rootViewController: productTypeVC)
        nav.isNavigationBarHidden = true
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
        UIView.transition(from: self.view, to: productTypeVC.view, duration: 0.5, options: .transitionFlipFromLeft)
        { (finished) in
            window.rootViewController = nav
        }
    }
    
    private func localNoAppTip(platform:String){
        let alertController = UIAlertController.init(title: "温馨提示", message: "由于本地没有安装\(platform)，所以您无法获得\(platform)的授权", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "我知道了", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func rotationCircleAnimation(superView:UIView)
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

}
