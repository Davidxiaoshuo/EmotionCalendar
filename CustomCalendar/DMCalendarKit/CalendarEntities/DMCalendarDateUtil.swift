//
//  DMCalendarDateUtil.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

class DMCalendarDateUtil: NSObject {
    
    /**
     判断是否是闰年
     
     - parameter year: input year number
     
     - returns: result
     */
    static func isLeapYear(year: NSInteger)->Bool{
        var isLeap = false
        if 0 == (year % 400){
            isLeap = true
        }else if 0 == year % 4 && 0 != year % 100{
            isLeap = true
        }
        return isLeap
    }
    
    static func numberOfDaysInMonth(month: NSInteger)->NSInteger{
        return DMCalendarDateUtil.numberOfDaysInMonth(month, year: DMCalendarDateUtil.getCurrentYear())
    }
    
    static func numberOfDaysInMonth(month: NSInteger, year: NSInteger)->NSInteger{
        let tempMonth = month - 1
        let daysOfMonth:[Int] = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var days = daysOfMonth[tempMonth]
        if tempMonth == 1{
            if DMCalendarDateUtil.isLeapYear(year){
                days = 29
            }else{
                days = 28
            }
        }
        return days
    }
    
    static func getCurrentYear()->NSInteger{
        var ct = time(nil)
        let dt = localtime(&ct)
        let year = dt.memory.tm_year + 1900
        return NSInteger(year)
    }
    
    static func getCurrentMonth()->NSInteger{
        var ct = time(nil)
        let dt = localtime(&ct)
        let month = dt.memory.tm_mon + 1
        return NSInteger(month)
    }
    
    static func getCurrentDay()->NSInteger{
        var ct = time(nil)
        let dt = localtime(&ct)
        let day = dt.memory.tm_mday
        return NSInteger(day)
    }
    
    static func getMonthWithDate(date: NSDate)->NSInteger{
        let gregorian = NSCalendar.currentCalendar()
        let dateComponents = gregorian.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: date)
        return NSInteger(dateComponents.month)
    }
    
    static func getDayWithDate(date: NSDate)->NSInteger{
        let gregorian = NSCalendar.currentCalendar()
        let dateComponents = gregorian.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: date)
        return NSInteger(dateComponents.day)
    }
    
    static func dateSinceNowWithInterval(dayInterval: NSInteger)->NSDate{
        return NSDate(timeIntervalSinceNow: Double(dayInterval)*24*60*60)
    }
}
