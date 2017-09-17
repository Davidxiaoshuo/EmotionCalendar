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
    static func isLeapYear(_ year: NSInteger)->Bool{
        var isLeap = false
        if 0 == (year % 400){
            isLeap = true
        }else if 0 == year % 4 && 0 != year % 100{
            isLeap = true
        }
        return isLeap
    }
    
    static func numberOfDaysInMonth(_ month: NSInteger)->NSInteger{
        return DMCalendarDateUtil.numberOfDaysInMonth(month, year: DMCalendarDateUtil.getCurrentYear())
    }
    
    static func numberOfDaysInMonth(_ month: NSInteger, year: NSInteger)->NSInteger{
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
        let year = (dt?.pointee.tm_year)! + 1900
        return NSInteger(year)
    }
    
    static func getCurrentMonth()->NSInteger{
        var ct = time(nil)
        let dt = localtime(&ct)
        let month = (dt?.pointee.tm_mon)! + 1
        return NSInteger(month)
    }
    
    static func getCurrentDay()->NSInteger{
        var ct = time(nil)
        let dt = localtime(&ct)
        let day = dt?.pointee.tm_mday
        return NSInteger(day!)
    }
    
    static func getMonthWithDate(_ date: Date)->NSInteger{
        let gregorian = Calendar.current
        let dateComponents = (gregorian as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday], from: date)
        return NSInteger(dateComponents.month!)
    }
    
    static func getDayWithDate(_ date: Date)->NSInteger{
        let gregorian = Calendar.current
        let dateComponents = (gregorian as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday], from: date)
        return NSInteger(dateComponents.day!)
    }
    
    static func dateSinceNowWithInterval(_ dayInterval: NSInteger)->Date{
        return Date(timeIntervalSinceNow: Double(dayInterval)*24*60*60)
    }
}
