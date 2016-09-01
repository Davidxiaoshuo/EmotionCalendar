//
//  DMCalendarView.swift
//  CustomCalendar
//
//  Created by David on 16/8/30.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

class DMCalendarView: UIView {
    
    var calendarHeaderView: DMCalendarHeaderView!
    var calendarWeekDayView: DMCalendarWeekDayView!
    var calendarContentView: DMCalendarContentView!
    
    var currenShowCalendarMonth: DMCalendarMonth!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.initializeDate()
    }
    
    func setupSubviews(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColorFromHexRGB(0xeeeeee, alpha: 1).CGColor
        self.backgroundColor = UIColor.whiteColor()
        
        self.setupCalendarHeaderView()
        self.setupCalendarWeekDayView()
        self.setupCalendarContentView()
    }
    
    func setupCalendarHeaderView(){
        self.calendarHeaderView = DMCalendarHeaderView(frame: CGRectMake(0, 0, self.frame.width, kDefaultCalendarHeaderViewHeight))
        self.calendarHeaderView.backgroundColor = UIColorFromHexRGB(0x8da2d2, alpha: 1)
        self.calendarHeaderView.todayDateLabel.text = "August 31"
        self.calendarHeaderView.drawBottomLineForView(lineColor: UIColorFromHexRGB(0x4d6dbb, alpha: 1), lineWidth: 1)
        self.calendarHeaderView.nextBlk = { [weak self](headerView) in
            self?.changeMonthWithAnimation(true)
            self?.nextMonthHandle()
        }
        
        self.calendarHeaderView.previousBlk = { [weak self](headerView) in
            self?.changeMonthWithAnimation(false)
            self?.previousMonthHandle()
        }
        
        self.calendarHeaderView.goBackBlk = { [weak self](headerView) in
            self?.changeMonthHandle(DMCalendarMonth(date: NSDate()))
        }
        
        self.addSubview(calendarHeaderView)
    }
    
    func setupCalendarWeekDayView(){
        self.calendarWeekDayView = DMCalendarWeekDayView(frame: CGRectMake(0, kDefaultCalendarHeaderViewHeight, self.frame.width, kDefaultWeekDayViewHeight), marginLeftRight: 0)
        self.backgroundColor = UIColorFromHexRGB(0xf6f9f9, alpha: 1)
        self.addSubview(calendarWeekDayView)
    }
    
    func setupCalendarContentView(){
        self.calendarContentView = DMCalendarContentView(frame: CGRectMake(0, kDefaultCalendarHeaderViewHeight+kDefaultWeekDayViewHeight, self.frame.width, self.frame.height - kDefaultCalendarHeaderViewHeight-kDefaultWeekDayViewHeight), marginLeftRight: 0)
        self.addSubview(calendarContentView)
    }
    
    func initializeDate(){
        self.currenShowCalendarMonth = DMCalendarMonth(date: NSDate())
        self.changeMonthHandle(currenShowCalendarMonth)
        
        //calendar header data
        self.calendarHeaderView.todayDateLabel.text = self.getCurrentDate()
    }
    
    func nextMonthHandle(){
        self.changeMonthHandle(self.currenShowCalendarMonth.nextMonth())
    
    }
    
    func previousMonthHandle(){
        self.changeMonthHandle(self.currenShowCalendarMonth.previousMonth())
    }
    
    func changeMonthHandle(currentCalendarMonth: DMCalendarMonth){
        self.currenShowCalendarMonth = currentCalendarMonth
        let firstDayOfMonth = self.currenShowCalendarMonth.firstDay()
        let lastDayOfMonth = self.currenShowCalendarMonth.lastDay()
        let firstDayOfWeekDay = firstDayOfMonth.weekDay
        let lastDayOfWeekDay = lastDayOfMonth.weekDay
        
        let previousMonth = self.currenShowCalendarMonth.previousMonth()
        let nextMonth = self.currenShowCalendarMonth.nextMonth()
        
        let lastFewDays = previousMonth.getLastFewDays(firstDayOfWeekDay - 1)
        let headerFewDays = nextMonth.getHeaderFewDays(7 - lastDayOfWeekDay)
        
        
        let emotioinData = self.originTestData()
        self.dealDataWithEmotionType(emotioinData.timestamps, emotioinTypes: emotioinData.emotioinTypes)
        
        var showDays: [DMCalendarDay] = []
        showDays.appendContentsOf(lastFewDays)
        showDays.appendContentsOf(self.currenShowCalendarMonth.daysOfMonth)
        showDays.appendContentsOf(headerFewDays)
        self.calendarContentView.cellEntitis = showDays
    }
    
    
    
    
    func dealDataWithEmotionType(timestamps:[String], emotioinTypes:[Emotion]){
        var tempCalendarDay: [DMCalendarDay] = []
        for timestamp in timestamps{
            let date = DMDateFormatUtils.formatTimestampToDate(timestamp)
            tempCalendarDay.append(DMCalendarDay(date: date))
        }
        
        for(index, value) in tempCalendarDay.enumerate(){
            let tempIndex = self.currenShowCalendarMonth.isContainDay(value)
            if tempIndex != -1{
                self.currenShowCalendarMonth.daysOfMonth[tempIndex].emotionType = emotioinTypes[index]
            }
        }
    }
    
    /**
     获取当前时间的日期
     
     - returns: August 16
     */
    func getCurrentDate()->String{
        let todayMonth = DMCalendarMonth(date: NSDate())
        var currentMonth = Month.January
        switch todayMonth.month {
        case 1:
            currentMonth = .January
        case 2:
            currentMonth = .February
        case 3:
            currentMonth = .March
        case 4:
            currentMonth = .April
        case 5:
            currentMonth = .May
        case 6:
            currentMonth = .June
        case 7:
            currentMonth = .July
        case 8:
            currentMonth = .August
        case 9:
            currentMonth = .September
        case 10:
            currentMonth = .October
        case 11:
            currentMonth = .November
        case 12:
            currentMonth = .December
        default:
            break
        }
        let resultStr: String = currentMonth.rawValue + " \(todayMonth.today.day)"
        return resultStr
    }
    
    func changeMonthWithAnimation(next: Bool){
        var animtionOption: UIViewAnimationTransition!
        if next{
            animtionOption = .CurlUp
        }else{
            animtionOption = .CurlDown
        }
        UIView .animateWithDuration(0.3, animations: { 
            UIView.setAnimationTransition(animtionOption, forView: self.calendarContentView, cache: true)
            }) { (finished) in
                
        }
    }
    
    
    func originTestData()->(timestamps:[String], emotioinTypes:[Emotion]){
        var timestamps: [String] = []
        timestamps.append("1472700799")
        timestamps.append("1472832000")
        
        var emotionTypes:[Emotion] = []
        emotionTypes.append(.Happy)
        emotionTypes.append(.Cry)
        
        return (timestamps, emotionTypes)
    }
    
    
    

}
