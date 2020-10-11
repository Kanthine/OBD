//
//  MessageListViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    private lazy var tableView:UITableView =
    {
        
        let table:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.delegate = self as UITableViewDelegate
        table.dataSource = self
        table.backgroundColor = UIColor.RGBA(51, 51, 51, 1)
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        // 单元格注册
        
        table.register(UINib.init(nibName: "MessageTableCell", bundle: nil), forCellReuseIdentifier: "MessageTableCell")
        
        return table
    }()
    
    private var dataArray:NSArray?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "消息中心"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        self.view.backgroundColor = UIColor.RGBA(51, 51, 51, 1)
        
        let imageView = UIImageView.init(image: UIImage.init(named: "owner_NoMessage"))
        self.view.addSubview(imageView)
        imageView.mas_makeConstraints {[weak self] (make:MASConstraintMaker!) in
            make.center.equalTo()(self?.view)
            make.width.mas_equalTo()(100)
            make.height.mas_equalTo()(100)
        }
        
        let tipLable = UILabel.init()
        tipLable.text = "你目前还没有任何消息哦~"
        tipLable.textColor = UIColor.RGBA(187, 187, 187, 1)
        tipLable.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(tipLable)
        tipLable.mas_makeConstraints {[weak self] (make:MASConstraintMaker!) in
            make.top.equalTo()(imageView.mas_bottom)?.with().offset()(10)
            make.centerX.equalTo()(self?.view.mas_centerX)
        }
        
        
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.edges.equalTo()(self.view)
        }
        self.tableView.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.dataArray != nil)
        {
            return (self.dataArray?.count)!
        }
        else
        {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
//        return tableView.fd_heightForCell(withIdentifier: "MessageTableCell", cacheBy: indexPath, configuration: { (cell:MessageTableCell) in
//            
//        } as! (Any?) -> Void)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MessageTableCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableCell", for: indexPath) as! MessageTableCell
        
        
        return cell
        
    }


}
