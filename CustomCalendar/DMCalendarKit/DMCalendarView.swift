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
        self.layer.borderColor = UIColorFromHexRGB(0xeeeeee, alpha: 1).cgColor
        self.backgroundColor = UIColor.white
        
        self.setupCalendarHeaderView()
        self.setupCalendarWeekDayView()
        self.setupCalendarContentView()
    }
    
    func setupCalendarHeaderView(){
        self.calendarHeaderView = DMCalendarHeaderView(frame: CGRect(x: 0,
                                                                     y: 0,
                                                                     width: self.frame.width,
                                                                     height: kDefaultCalendarHeaderViewHeight))
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
            self?.changeMonthHandle(DMCalendarMonth(date: Date()))
        }
        
        self.addSubview(calendarHeaderView)
    }
    
    func setupCalendarWeekDayView(){
        self.calendarWeekDayView = DMCalendarWeekDayView(frame: CGRect(x: 0,
                                                                       y: kDefaultCalendarHeaderViewHeight,
                                                                       width: self.frame.width,
                                                                       height: kDefaultWeekDayViewHeight),
                                                         marginLeftRight: 0)
        self.backgroundColor = UIColorFromHexRGB(0xf6f9f9, alpha: 1)
        self.addSubview(calendarWeekDayView)
    }
    
    func setupCalendarContentView(){
        self.calendarContentView = DMCalendarContentView(frame: CGRect(x: 0,
                                                                       y: kDefaultCalendarHeaderViewHeight+kDefaultWeekDayViewHeight,
                                                                       width: self.frame.width,
                                                                       height: self.frame.height - kDefaultCalendarHeaderViewHeight-kDefaultWeekDayViewHeight),
                                                         marginLeftRight: 0)
        self.addSubview(calendarContentView)
    }
    
    func initializeDate(){
        self.currenShowCalendarMonth = DMCalendarMonth(date: Date())
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
    
    func changeMonthHandle(_ currentCalendarMonth: DMCalendarMonth){
        self.currenShowCalendarMonth = currentCalendarMonth
        let firstDayOfMonth = self.currenShowCalendarMonth.firstDay()
        let lastDayOfMonth = self.currenShowCalendarMonth.lastDay()
        let firstDayOfWeekDay = firstDayOfMonth.weekDay!
        let lastDayOfWeekDay = lastDayOfMonth.weekDay!
        
        let previousMonth = self.currenShowCalendarMonth.previousMonth()
        let nextMonth = self.currenShowCalendarMonth.nextMonth()
        
        let lastFewDays = previousMonth.getLastFewDays(firstDayOfWeekDay - 1)
        let headerFewDays = nextMonth.getHeaderFewDays(7 - lastDayOfWeekDay)
        
        
        let emotioinData = self.originTestData()
        self.dealDataWithEmotionType(emotioinData.timestamps, emotioinTypes: emotioinData.emotioinTypes)
        
        var showDays: [DMCalendarDay] = []
        showDays.append(contentsOf: lastFewDays)
        showDays.append(contentsOf: self.currenShowCalendarMonth.daysOfMonth)
        showDays.append(contentsOf: headerFewDays)
        self.calendarContentView.cellEntitis = showDays
    }
    
    func dealDataWithEmotionType(_ timestamps:[String], emotioinTypes:[Emotion]){
        var tempCalendarDay: [DMCalendarDay] = []
        for timestamp in timestamps{
            let date = DMDateFormatUtils.formatTimestampToDate(timestamp)
            tempCalendarDay.append(DMCalendarDay(date: date))
        }
        
        for(index, value) in tempCalendarDay.enumerated(){
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
        let todayMonth = DMCalendarMonth(date: Date())
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
        let resultStr: String = currentMonth.rawValue + " \(todayMonth.today.day ?? 1)"
        return resultStr
    }
    
    func changeMonthWithAnimation(_ next: Bool){
        var animtionOption: UIViewAnimationTransition!
        if next{
            animtionOption = .curlUp
        }else{
            animtionOption = .curlDown
        }
        UIView .animate(withDuration: 0.3, animations: { 
            UIView.setAnimationTransition(animtionOption, for: self.calendarContentView, cache: true)
            }, completion: { (finished) in
                
        }) 
    }
    
    
    func originTestData()->(timestamps:[String], emotioinTypes:[Emotion]){
        var timestamps: [String] = []
        timestamps.append("1472700799")
        timestamps.append("1472832000")
        
        var emotionTypes:[Emotion] = []
        emotionTypes.append(.happy)
        emotionTypes.append(.cry)
        
        return (timestamps, emotionTypes)
    }
    
    
    

}
