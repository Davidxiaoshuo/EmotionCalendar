//
//  DMCalendarDay.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit
import Foundation

let kSecondOfADay: NSTimeInterval = 24*60*60

class DMCalendarDay: NSObject {

    var date: NSDate!
    var month: NSInteger!
    var day: NSInteger!
    var year: NSInteger!
    var weekDay: NSInteger!
    var emotionType: Emotion?
    var isCurrentMonthDay: Bool = true
    
    init(date: NSDate){
        super.init()
        self.date = date
        self.cacluateDate()
    }
    
    init(year: NSInteger, month: NSInteger, day: NSInteger) {
        super.init()
        
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        self.date = NSCalendar.currentCalendar().dateFromComponents(dateComponents)
        self.cacluateDate()
    }
    
    func cacluateDate(){
        let gregorian = NSCalendar.currentCalendar()
        let dateComponents = gregorian.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: self.date!)
        self.month = dateComponents.month
        self.day = dateComponents.day
        self.year = dateComponents.year
        self.weekDay = dateComponents.weekday
    }
    
    func isToday()->Bool{
        return (DMCalendarDateUtil.getCurrentYear() == self.year) &&
            (DMCalendarDateUtil.getCurrentMonth() == self.month) &&
            (DMCalendarDateUtil.getCurrentDay() == self.day)
    }
    
    func isEqualWithDay(calDay: DMCalendarDay)->Bool{
        return calDay.year == self.year &&
            calDay.month == self.month &&
            calDay == self.day
    }
    
    func getWeekDayName()->String{
        var name = "KnownName"
        switch self.weekDay {
        case 1:
            name = "Sunday"
        case 2:
            name = "Monday"
        case 3:
            name = "Tuesday"
        case 4:
            name = "Wednesday"
        case 5:
            name = "Thurday"
        case 6:
            name = "Friday"
        case 7:
            name = "Saturday"
        default:
            break
        }
        return name
    }
    
    func getMeaningfulWeekDay()->CalWeekDay{
    
        var wd: CalWeekDay = .UnKnown
        switch self.weekDay {
        case 1:
            wd = .Sunday
        case 2:
            wd = .Monday
        case 3:
            wd = .Tuesday
        case 4:
            wd = .Wednesday
        case 5:
            wd = .Thursday
        case 6:
            wd = .Friday
        case 7:
            wd = .Saturday
        default:
            break
        }
        return wd
    }
    
    func nexDay()->DMCalendarDay{
        let nextDayDate = self.date.dateByAddingTimeInterval(kSecondOfADay)
        let nextDay = DMCalendarDay(date: nextDayDate)
        return nextDay
    }
    
    func previousDay()->DMCalendarDay{
        let previousDayDate = self.date.dateByAddingTimeInterval(-kSecondOfADay)
        let previousDay = DMCalendarDay(date: previousDayDate)
        return previousDay
    }
    
    func compareWithCalDay(calDay: DMCalendarDay)->NSComparisonResult{
        var result = NSComparisonResult.OrderedSame
        if self.year < calDay.year{
            result = .OrderedAscending
        }else if self.year == calDay.year{
            if self.month < calDay.month{
                result = .OrderedAscending
            }else if self.month == calDay.month{
                if self.day == calDay.day{
                    result = .OrderedSame
                }else{
                    result = .OrderedDescending
                }
            }else{
                result = .OrderedDescending
            }
        }else{
            result = .OrderedDescending
        }
        return result
    }
   
}
