//
//  DMDateFormatUtils.swift
//  DataMi
//
//  Created by David on 16/8/13.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

class DMDateFormatUtils: NSObject {
    
    
    /**
     获取当前的时间戳
     
     - returns: 时间戳
     */
    static func getCurrentTimestamp()->String{
        let now = NSDate()
        
        // 创建一个日期格式器
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        
        //当前时间的时间戳
        let timeInterval:NSTimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /**
     将时间戳转化为时间格式：yyyy年MM月dd日 HH:mm:ss
     
     - parameter timestamp: 时间戳
     
     - returns: yyyy年MM月dd日 HH:mm:ss
     */
    static func formatTimestampToTime(timestamp: String)->String{
        let timeInterval:NSTimeInterval = NSTimeInterval((timestamp as NSString).doubleValue)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        
        //格式话输出
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return dformatter.stringFromDate(date)
    }
    
    /**
     将时间戳转化为NSDate
     
     - parameter timestamp: 时间戳
     
     - returns: NSDate
     */
    static func formatTimestampToDate(timestamp: String)->NSDate{
        let timeInterval:NSTimeInterval = NSTimeInterval((timestamp as NSString).doubleValue)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        return date
    }
    
    /**
     将指定时间格式的字符串转化为Date
     
     - parameter stringTime: 时间字符串
     - parameter dateFormat: 时间格式
     
     - returns: <#return value description#>
     */
    static func stringToDate(stringTime:NSString,dateFormat:NSString?) -> NSDate{
        
        let outputFormatter = NSDateFormatter()
        
        var dateForma = ""
        
        if(dateFormat == nil){dateForma = "yyyy年MM月dd日 HH:mm:ss"}
        
        outputFormatter.dateFormat =  (dateFormat == nil  ?  (dateForma as NSString)  :  dateFormat!) as String
        
        return outputFormatter.dateFromString(stringTime as String)!
    }
    
    //**
//     将date格式化好时间
    
//        - parameter date:   date
//        - parameter specialFormatStr: G: 公元时代，例如AD公元
//        yy: 年的后2位
//        yyyy: 完整年
//        MM: 月，显示为1-12
//        MMM: 月，显示为英文月份简写,如 Jan
//        MMMM: 月，显示为英文月份全称，如 Janualy
//        dd: 日，2位数表示，如02
//        d: 日，1-2位显示，如 2
//        EEE: 简写星期几，如Sun
//        EEEE: 全写星期几，如Sunday
//        aa: 上下午，AM/PM
//        H: 时，24小时制，0-23
//        K：时，12小时制，0-11
//        m: 分，1-2位
//        mm: 分，2位
//        s: 秒，1-2位
//        ss: 秒，2位
//        S: 毫秒
//     - returns: 格式化好的时间
//    */
    static func formateDate(date: NSDate, widthSpecialFormatStr specialFormatStr: String)->String{
        let dformatter = NSDateFormatter()
        dformatter.dateFormat = specialFormatStr
        return dformatter.stringFromDate(date)
    }
    
    static func formateDateToAAStyle(date: NSDate)->String{
        return DMDateFormatUtils.formateDate(date, widthSpecialFormatStr: "aa KK:mm")
    }
    

}
