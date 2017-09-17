//
//  CommonUtilDef.swift
//  FaceU
//
//  Created by David on 15/7/2.
//  Copyright (c) 2015年 N.Y Studio. All rights reserved.
//

import UIKit

//Color
func RGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func UIColorFromHexRGB(_ rgbValue:UInt32,alpha:CGFloat)->UIColor{
    return UIColor(red: (CGFloat)((rgbValue & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((rgbValue & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
}

func UIColorRandom()->UIColor{
    
    let randomRed:CGFloat = CGFloat(drand48())
    
    let randomGreen:CGFloat = CGFloat(drand48())
    
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
}


//Version
func IS_IOS7_OR_HEIGHER() ->Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 }
func IS_IOS8_OR_HEIGHER() ->Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }
