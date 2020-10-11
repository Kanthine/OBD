//
//  EvaluateViewController.swift
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import UIKit

class EvaluateViewController: UIViewController,UITextViewDelegate
{
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLable: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        self.navigationItem.title = "吐槽一下"
        let leftItem = LeftBackItem.init(target: self, selector: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func leftItemClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.endEditing(true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.endEditing(true)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 0
        {
            self.placeholderLable.isHidden = false
        }
        else
        {
            self.placeholderLable.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0
        {
            self.placeholderLable.isHidden = false
        }
        else
        {
            self.placeholderLable.isHidden = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView.resignFirstResponder()
            
            return false
        }
        
        
        return true
    }
}
