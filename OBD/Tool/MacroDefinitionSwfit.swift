//
//  MacroDefinitionSwfit.swift
//  OBD
//
//  Created by 苏沫离 on 2017/4/27.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

import Foundation

//RGB方法
extension UIColor{
    static func RGBA(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha:CGFloat) -> UIColor
    {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorWithHex(_ hex: UInt) -> UIColor
    {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        return RGBA(r, g, b, 1)
    }
        
    //类方法 class
}

extension UIScreen{
    class func ScrWidth() -> CGFloat
    {
        return UIScreen.main.bounds.width
    }
    
    class func ScrHeight() -> CGFloat
    {
        return UIScreen.main.bounds.height
    }
    
}
