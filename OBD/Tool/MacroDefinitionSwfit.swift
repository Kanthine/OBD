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
    static func RGBA(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha:CGFloat) -> UIColor{
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorWithHex(_ hex: UInt) -> UIColor{
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        return RGBA(r, g, b, 1)
    }
        
    //类方法 class
}

extension UIScreen{
    class func ScrWidth() -> CGFloat{
        return UIScreen.main.bounds.width
    }
    
    class func ScrHeight() -> CGFloat{
        return UIScreen.main.bounds.height
    }
}


///是否是刘海屏
func isIPhoneNotchScreen() -> Bool {
    if #available(iOS 11.0, *) {
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        var bottomSpace : CGFloat = 0.0
        switch UIApplication.shared.statusBarOrientation {
            case .portrait:
                bottomSpace = safeAreaInsets?.bottom ?? 0
            case .landscapeLeft:
                bottomSpace = safeAreaInsets?.right ?? 0
            case .landscapeRight:
                bottomSpace = safeAreaInsets?.left ?? 0
            case .portraitUpsideDown:
                bottomSpace = safeAreaInsets?.top ?? 0
            default:
                bottomSpace = safeAreaInsets?.bottom ?? 0
        }
        return bottomSpace > 0 ? true : false
    }
    return false
}

///获取导航栏高度
func getNavigationBarHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        var topSpace : CGFloat = 0.0
        switch UIApplication.shared.statusBarOrientation {
            case .portrait:
                topSpace = safeAreaInsets?.top ?? 0
            case .landscapeLeft:
                topSpace = safeAreaInsets?.left ?? 0
            case .landscapeRight:
                topSpace = safeAreaInsets?.right ?? 0
            case .portraitUpsideDown:
                topSpace = safeAreaInsets?.bottom ?? 0
            default:
                topSpace = safeAreaInsets?.top ?? 0
        }
        if topSpace == 0 {
            topSpace = 20.0
        }
        return topSpace + 44.0
    }
    return 64.0
}

func getTabBarHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        var bottomSpace : CGFloat = 0.0
        switch UIApplication.shared.statusBarOrientation {
            case .portrait:
                bottomSpace = safeAreaInsets?.bottom ?? 0
            case .landscapeLeft:
                bottomSpace = safeAreaInsets?.right ?? 0
            case .landscapeRight:
                bottomSpace = safeAreaInsets?.left ?? 0
            case .portraitUpsideDown:
                bottomSpace = safeAreaInsets?.top ?? 0
            default:
                bottomSpace = safeAreaInsets?.bottom ?? 0
        }
        return bottomSpace + 49.0
    }
    return 49.0
}
