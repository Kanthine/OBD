//
//  AboutViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        self.navigationItem.title = "关于"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton)
    {
        if sender.tag == 1
        {
            //吐槽一下
            let evaluateVC = EvaluateViewController.init(nibName: "EvaluateViewController", bundle: nil)
            self.navigationController?.pushViewController(evaluateVC, animated: true)
        }
        else
        {
            //评分一下
            UIApplication.shared.openURL(NSURL.init(string: "https://itunes.apple.com/cn/app/iexhaust/id1227595183?mt=8")! as URL)
        }
        
        
    }
    


}
