//
//  WrongCodeViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/11.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class WrongCodeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dataArray:NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        self.view.backgroundColor = UIColor.RGBA(51, 51, 51, 1)
        
        self.navigationItem.title = "故障码"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        //查询氧传感设置情况
        OBDOrderManager.shared().setOrderWithOrderIndex(14, isCheck: true, newOrder: "")
        

        
        
        self.setSelfView(superView: self.view)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setSelfView(superView:UIView)
    {
        let topView:UIView = UIView.init()
        self.setTopView(topView: topView)
        superView.addSubview(topView)
        topView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(0)
            make.left.mas_equalTo()(0)
            make.right.mas_equalTo()(0)
            make.height.mas_equalTo()(50)
        }
        
        let bottomView:UIView = UIView.init()
        setBottomView(bottomView: bottomView)
        superView.addSubview(bottomView)
        bottomView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.mas_equalTo()(0)
            make.left.mas_equalTo()(0)
            make.right.mas_equalTo()(0)
        }

        
        let errorImageView:UIImageView = UIImageView.init(image: UIImage.init(named: "owner_ErrorCodeBack"))
        superView.addSubview(errorImageView)
        errorImageView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.equalTo()(superView)
            make.width.mas_equalTo()(180)
            make.height.equalTo()(errorImageView.mas_width)?.multipliedBy()(216.0/437.0)
        }
        
        let lable:UILabel = UILabel.init()
        lable.text = "暂无故障，请继续保持~"
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = UIColor.RGBA(153, 153, 153, 1)
        superView.addSubview(lable)
        lable.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(errorImageView.mas_bottom)?.with().offset()(20)
            make.centerX.equalTo()(topView)
        }

        
        let tableView:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.rowHeight = 56
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.backgroundColor = UIColor.RGBA(51, 51, 51, 1)
        tableView.register(UINib.init(nibName: "WrongCodeTableCell", bundle: nil), forCellReuseIdentifier: "WrongCodeTableCell")
        superView.addSubview(tableView)
        tableView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(topView.mas_bottom)?.with().offset()(0)
            make.left.mas_equalTo()(0)
            make.bottom.equalTo()(bottomView.mas_top)?.with().offset()(0)
            make.right.mas_equalTo()(0)
        }

        CurrentOBDModel.shared().orderMangerErrorcodeChange { [weak self](errorcode:String?) in
            
            if ((self?.dataArray) != nil)
            {
                self?.dataArray!.removeAllObjects()
            }
            
            if (errorcode != nil) && errorcode != "NULL"
            {
                let errorArray = errorcode?.components(separatedBy: "|")
                self?.dataArray = NSMutableArray.init(array: errorArray!)
                
                print("错误码 --------- \(String(describing: errorArray))")
                
                tableView.reloadData()
            }
            
            if (self?.dataArray?.count)! > 0
            {
                tableView.isHidden = false
                bottomView.isHidden = false
            }
            else
            {
                tableView.isHidden = true
                bottomView.isHidden = true
            }
            
        }
    }
    
    private func setTopView(topView:UIView)
    {
        topView.backgroundColor = UIColor.RGBA(34, 34, 34, 1)
        
        let lable:UILabel = UILabel.init()
            lable.text = "氧传感故障自动消除"
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = UIColor.white
        topView.addSubview(lable)
        lable.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(10)
            make.centerY.equalTo()(topView)
        }
        
        
        let switchView = UISwitch.init()
        switchView.addTarget(self, action: #selector(switchViewValueChangeClick(sender:)), for: .valueChanged)
        topView.addSubview(switchView)
        switchView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(-10)
            make.centerY.equalTo()(topView)
            make.width.mas_equalTo()(50)
            make.height.mas_equalTo()(25)
        }


        CurrentOBDModel.shared().orderManagerOxygenErrorChange { (oxygenError:String?) in
            
            print("oxygenError ========= \(oxygenError)")
            
            if oxygenError != nil
            {
                if oxygenError == "ON"
                {
                    switchView.isOn = true
                }
                else if oxygenError == "OFF" ||  oxygenError == "ERROR"
                {
                    switchView.isOn = false
                }
            }
        }
    }
    
    
    private func setBottomView(bottomView:UIView)
    {
        bottomView.backgroundColor = UIColor.clear
        
        let button = UIButton.init(type: .custom)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("一键清除", for: .normal)
        button.addTarget(self, action: #selector(cleanAllWrongCodeButtonClick), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.RGBA(234, 105, 86, 1)
        bottomView.addSubview(button)
        
        button.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(3)
            make.left.mas_equalTo()(13)
            make.bottom.mas_equalTo()(-10)
            make.right.mas_equalTo()(-13)
            make.height.mas_equalTo()(40)
        }
        
    }
    
    
    @objc private func switchViewValueChangeClick(sender:UISwitch)
    {
        var string = "OFF"

        if sender.isOn
        {
            string = "ON"
        }
        
        OBDOrderManager.shared().setOrderWithOrderIndex(15, isCheck: false, newOrder: string)
    }
    
    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dataArray != nil)
        {
            return dataArray!.count
        }
        else
        {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrongCodeTableCell", for: indexPath) as! WrongCodeTableCell
        
        let string = dataArray![indexPath.row] as! String
        
        cell.errorCodeLable.text = string
        
        if UIPasteboard.general.string == string
        {
            cell.setSelected(true, animated: true)
        }
        else
        {
            cell.setSelected(false, animated: true)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let string = dataArray![indexPath.row] as! String

        UIPasteboard.general.string = string
        
        let cell = tableView.cellForRow(at: indexPath)
        if UIPasteboard.general.string == string
        {
            cell?.setSelected(true, animated: true)
        }
        else
        {
            cell?.setSelected(false, animated: true)
        }
    }
    
    
    @objc private func cleanAllWrongCodeButtonClick()
    {
        //一键清除
        
        if (dataArray != nil)
        {
            if dataArray!.count > 0
            {
                //清除故障码
                OBDOrderManager.shared().setOrderWithOrderIndex(11, isCheck: false, newOrder: "")
                
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = .text
                hud.label.text = "正在清除故障码"
                hud.margin = 10.0
                hud.removeFromSuperViewOnHide = true
                hud.hide(animated: true, afterDelay: 1.2)
                
                
                self.perform(#selector(cleanAllWrongCodeSuccessClick), with: self, afterDelay: 1.2)
            }
        }
    }
    
    
    @objc private func cleanAllWrongCodeSuccessClick()
    {
        //查询故障码
        OBDOrderManager.shared().setOrderWithOrderIndex(10, isCheck: true, newOrder: "")
    }
    
    
}
