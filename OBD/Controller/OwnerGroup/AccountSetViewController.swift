//
//  AccountSetViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

//账号设置
class AccountSetViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    private let httpManager:LoginHttpManager = LoginHttpManager.init()

    private lazy var tableView:UITableView =
    {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.ScrWidth(), height: 100))
            footerView.backgroundColor = UIColor.clear
        
        let loginOutButton:UIButton = UIButton.init(type:.custom)
        loginOutButton.frame = CGRect.init(x: 0, y: 20, width: UIScreen.ScrWidth(), height: 44)
        loginOutButton.addTarget(self, action: #selector(loginOutButtonClick), for: .touchUpInside)
        loginOutButton.backgroundColor = UIColor.RGBA(75, 75, 75, 1)
        loginOutButton.setTitle("退出登录", for: .normal)
        loginOutButton.setTitleColor(UIColor.RGBA(234, 105, 86, 1), for: .normal)
        loginOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        footerView.addSubview(loginOutButton)
        
        let table:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        table.isScrollEnabled = false
        table.delegate = self as UITableViewDelegate
        table.dataSource = self
        table.backgroundColor = UIColor.clear
        table.tableFooterView = footerView
        table.separatorColor = UIColor.RGBA(102, 102, 102, 1)
        // 单元格注册
        table.register(AccountSetTableCell.classForCoder(), forCellReuseIdentifier: "AccountSetTableCell")
        return table
    }()
    
    private var dataArray:[NSArray]! = [["头像"],["昵称","当前账户","修改登录密码"]]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "账号设置"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.view.backgroundColor = UIColor.RGBA(51, 51, 51, 1)
        
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.edges.equalTo()(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let array:NSArray = self.dataArray[section]
        return array.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 70
        }
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AccountSetTableCell = tableView.dequeueReusableCell(withIdentifier: "AccountSetTableCell", for: indexPath) as! AccountSetTableCell
        

        let array:NSArray = self.dataArray[indexPath.section]
        cell.textLabel?.text = array[indexPath.row] as? String
        
        
        if  AuthorizationManager.isLoginState()
        {
            
            let account:AccountInfo = AccountInfo.standard()
            
            
            switch indexPath.section {
            case 0://头像
                cell.detailLabel.isHidden = true
                cell.headerImageView.isHidden = false
                cell.accessoryType = .disclosureIndicator
                
                cell.headerImageView.sd_setImage(with: NSURL.init(string: account.headimg)! as URL, placeholderImage: UIImage.init(named: "appLogo"))
                
                break
            case 1:
                cell.detailLabel.isHidden = false
                cell.headerImageView.isHidden = true
                switch indexPath.row {
                case 0://昵称
                    cell.detailLabel.text = account.nickname
                    cell.accessoryType = .disclosureIndicator
                    break
                case 1://当前账户
                    cell.detailLabel.text = account.userName
                    cell.accessoryType = .none
                    break
                case 2://修改登录密码
                    cell.accessoryType = .disclosureIndicator
                    break
                default:
                    break
                }
                break
            default:
                break
            }
        }
        
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        switch indexPath.section
        {
        case 0:
            //头像
            updateHeaderPortrait()
            break
        case 1:
            
            switch indexPath.row
            {
            case 0:
                //昵称
                let nickNameVC = ResetNickNameViewController.init(nibName: "ResetNickNameViewController", bundle: nil)
                self.navigationController?.pushViewController(nickNameVC, animated: true)
                break
            case 1:
                //当前账户
                
                
                break
            case 2:
                //修改登录密码
                let updateVC = UpdatePwsVC()
                self.navigationController?.pushViewController(updateVC, animated: true)
                
                break
            default:
                break
            }

            break
            
        default:
            break
        }
        
        
        
    }
    
    
    
    
    //修改用户头像
    private func updateHeaderPortrait()
    {
        let sheetController = UIAlertController.init(title: "设置头像", message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction.init(title: "拍照", style: .default) {[weak self] (action:UIAlertAction) in
            self?.callOnImagePicker(isCamera: true)
        }
        let libraryAction = UIAlertAction.init(title: "相册", style: .default) {[weak self] (action:UIAlertAction) in
            self?.callOnImagePicker(isCamera: false)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)

        sheetController.addAction(photoAction)
        sheetController.addAction(libraryAction)
        sheetController.addAction(cancelAction)
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    //拍摄照相
    private func callOnImagePicker(isCamera:Bool)
    {
        
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if isCamera
        {
            imagePicker.sourceType = .camera
        }
        else
        {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        
        print("相册信息 ========== \(info)")
        
        let pickedImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as! UIImage

        
        QNManager.updateLoad(pickedImage, progressBlock: { (progress:Float) in
            
            
            
        }) {[weak self] (urlString:String!, isSucceed:Bool) in
            if isSucceed
            {
                self?.updateLocalHeader(urlString: urlString)
            }
        }
    }
    
    private func updateLocalHeader(urlString:String)
    {
        let account:AccountInfo = AccountInfo.standard()
        
        let dict:NSDictionary = ["user_id":account.userId,"birthday":account.birthday,"nickname":account.nickname,"sex":account.sex,"minename":account.realName,"headimg":urlString]
        
        self.httpManager.updatePersonalInfoParameterDict(dict as! [AnyHashable : Any], successBlock: {[weak self] (string:String?) in
            
            account.headimg = urlString
            account.store()
            self?.tableView.reloadData()
            
        }) { (error:Error?) in
            
        }
    }
    
    
    //退出登录
    @objc private func loginOutButtonClick()
    {
        
        let alertController = UIAlertController.init(title: "温馨提示", message: "您确定要离开嘛？", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消 ", style: .cancel, handler: nil)
        let loginOutAction = UIAlertAction.init(title: "退出", style: .default) {[weak self] (action:UIAlertAction) in
            let account = AccountInfo.standard()
            account?.logoutAccount()
            
            self?.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(loginOutAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
