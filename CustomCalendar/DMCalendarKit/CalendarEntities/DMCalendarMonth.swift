//
//  DMCalendarMonth.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

let kLastMonthOfYear = 12
let kFirstMonthOfYear = 1

class DMCalendarMonth: NSObject {
    
    var month: NSInteger!
    var year: NSInteger!
    var numberOfDays: NSInteger!
    var today: DMCalendarDay!
    var daysOfMonth: [DMCalendarDay] = []
    
    init(date: Date){
        super.init()
        self.today = DMCalendarDay(date: date)
        self.calculateMonth()
    }
    
    init(month: NSInteger){
        super.init()
        self.today = DMCalendarDay(year: DMCalendarDateUtil.getCurrentYear(), month: month, day: 1)
        self.calculateMonth()
    }
    
    init(month: NSInteger, year: NSInteger){
        super.init()
        self.today = DMCalendarDay(year: year, month: month, day: 1)
        self.calculateMonth()
    }
    
    init(month: NSInteger, year: NSInteger, day: NSInteger){
        super.init()
        self.today = DMCalendarDay(year: year, month: month, day: day)
        self.calculateMonth()
    }
    
    fileprivate func calculateMonth(){
        self.numberOfDays = DMCalendarDateUtil.numberOfDaysInMonth(self.today.month, year: self.today.year)
        self.year = self.today.year
        self.month = self.today.month
        for i in 1...self.numberOfDays{
            let calDay = DMCalendarDay(year: year, month: month, day: i)
            daysOfMonth.append(calDay)
        }
    }
    
    func calDayAtDay(_ day: NSInteger)->DMCalendarDay?{
        let index: NSInteger = day - 1
        if index < 0 || index > 31{
            return nil
        }
        return self.daysOfMonth[index]
    }
    
    func firstDay()->DMCalendarDay{
        return self.daysOfMonth[0]
    }
    
    func lastDay()->DMCalendarDay{
        return self.daysOfMonth[self.numberOfDays - 1]
    }
    
    func nextMonth()->DMCalendarMonth{
        var year = self.year
        var month = self.month + 1
        let day = 1
        if month > kLastMonthOfYear{
            year = year! + 1
            month = 1
        }
        return DMCalendarMonth(month: month, year: year!, day: day)
    }
    
    func previousMonth()->DMCalendarMonth{
        var year = self.year
        var month = self.month - 1
        let day = 1
        if month < kFirstMonthOfYear{
            year = year! - 1
            month = 12
        }
        return DMCalendarMonth(month: month, year: year!, day: day)
    }
    
    func getLastFewDays(_ num: Int)->[DMCalendarDay]{
        var tempDays:[DMCalendarDay] = []
        if num <= 0 || num >= 31{
            return tempDays
        }
        for i in (1...num).reversed(){
            let day = self.daysOfMonth[self.numberOfDays - i]
            day.isCurrentMonthDay = false
            tempDays.append(day)
        }
        return tempDays
    }
    
    func getHeaderFewDays(_ num: Int)->[DMCalendarDay]{
        var tempDays:[DMCalendarDay] = []
        for i in 0..<num{
            let day = self.daysOfMonth[i]
            day.isCurrentMonthDay = false
            tempDays.append(day)
        }
        return tempDays
    }
    
    /**
     判断这个月是否包含这个日期
     
     - parameter calDay: 被包含的日期
     
     - returns: 日期在当月中的第几天
     */
    func isContainDay(_ calDay: DMCalendarDay)->Int{
        var tempIndex: Int = -1
        for (index, day) in self.daysOfMonth.enumerated(){
            if day.compareWithCalDay(calDay) == ComparisonResult.orderedSame{
                tempIndex = index
            }
        }
        return tempIndex
    }
    
    
    
}
