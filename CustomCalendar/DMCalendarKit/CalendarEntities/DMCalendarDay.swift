//
//  DMCalendarDay.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit
import Foundation

let kSecondOfADay: TimeInterval = 24*60*60

class DMCalendarDay: NSObject {

    var date: Date!
    var month: NSInteger!
    var day: NSInteger!
    var year: NSInteger!
    var weekDay: NSInteger!
    var emotionType: Emotion?
    var isCurrentMonthDay: Bool = true
    
    init(date: Date){
        super.init()
        self.date = date
        self.cacluateDate()
    }
    
    init(year: NSInteger, month: NSInteger, day: NSInteger) {
        super.init()
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        self.date = Calendar.current.date(from: dateComponents)
        self.cacluateDate()
    }
    
    func cacluateDate(){
        let gregorian = Calendar.current
        let dateComponents = (gregorian as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday], from: self.date!)
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
    
    func isEqualWithDay(_ calDay: DMCalendarDay)->Bool{
        return calDay.year == self.year &&
            calDay.month == self.month &&
            calDay.day == self.day
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
    
        var wd: CalWeekDay = .unKnown
        switch self.weekDay {
        case 1:
            wd = .sunday
        case 2:
            wd = .monday
        case 3:
            wd = .tuesday
        case 4:
            wd = .wednesday
        case 5:
            wd = .thursday
        case 6:
            wd = .friday
        case 7:
            wd = .saturday
        default:
            break
        }
        return wd
    }
    
    func nexDay()->DMCalendarDay{
        let nextDayDate = self.date.addingTimeInterval(kSecondOfADay)
        let nextDay = DMCalendarDay(date: nextDayDate)
        return nextDay
    }
    
    func previousDay()->DMCalendarDay{
        let previousDayDate = self.date.addingTimeInterval(-kSecondOfADay)
        let previousDay = DMCalendarDay(date: previousDayDate)
        return previousDay
    }
    
    func compareWithCalDay(_ calDay: DMCalendarDay)->ComparisonResult{
        var result = ComparisonResult.orderedSame
        if self.year < calDay.year{
            result = .orderedAscending
        }else if self.year == calDay.year{
            if self.month < calDay.month{
                result = .orderedAscending
            }else if self.month == calDay.month{
                if self.day == calDay.day{
                    result = .orderedSame
                }else{
                    result = .orderedDescending
                }
            }else{
                result = .orderedDescending
            }
        }else{
            result = .orderedDescending
        }
        return result
    }
   
}
