//
//  ResetNickNameViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/12.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class ResetNickNameViewController: UIViewController {

    @IBOutlet weak var textFiled: UITextField!
    private let httpManager:LoginHttpManager = LoginHttpManager.init()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        self.navigationItem.title = "修改昵称"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem.init(title: "保存", style: .done, target: self, action: #selector(rightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
        
        let account:AccountInfo = AccountInfo.standard()
        textFiled.text = account.nickname
    }

    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightItemClick()
    {
        let account:AccountInfo = AccountInfo.standard()
        
        let nickName = textFiled.text!
        
        
        let dict:NSDictionary = ["user_id":account.userId,"birthday":account.birthday,"nickname":nickName,"sex":account.sex,"minename":account.realName,"headimg":account.headimg]
        
        self.httpManager.updatePersonalInfoParameterDict(dict as! [AnyHashable : Any], successBlock: {[weak self] (string:String?) in
            account.nickname = nickName
            account.store()
            self?.navigationController?.popViewController(animated: true)
        }) { (error:Error?) in
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFiled.resignFirstResponder()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFiled.resignFirstResponder()
    }
    

}
