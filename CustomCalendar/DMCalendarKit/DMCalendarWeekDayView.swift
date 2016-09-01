//
//  DMCalendarWeekDayView.swift
//  CustomCalendar
//
//  Created by David on 16/8/30.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

enum WeekDay: String {
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

let kDefaultWeekDayViewHeight: CGFloat = 70 / 2

class DMCalendarWeekDayView: UIView {
    
    /// 用于展示的label
    let weekDay: [WeekDay] = [WeekDay.Sun, WeekDay.Mon, WeekDay.Tue, WeekDay.Wed,
                              WeekDay.Tue, WeekDay.Fri, WeekDay.Sat]
    
    var marginLeftAndRight: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, marginLeftRight: CGFloat) {
        super.init(frame: frame)
        self.marginLeftAndRight = marginLeftRight
        self.setupWeekDays()
    }
    
    func setupWeekDays(){
        let itemWidth = (self.frame.width - (self.marginLeftAndRight) * 2) / CGFloat(self.weekDay.count)
        var currentFrameX: CGFloat = marginLeftAndRight
        for (_, value) in self.weekDay.enumerate(){
            let weekDayItemLabel = UILabel(frame: CGRectMake(currentFrameX, 0, itemWidth, self.frame.height))
            weekDayItemLabel.textAlignment = .Center
            weekDayItemLabel.text = value.rawValue
            weekDayItemLabel.textColor = UIColorFromHexRGB(0x4b6bbb, alpha: 1)
            weekDayItemLabel.font = UIFont.systemFontOfSize(11)
            self.addSubview(weekDayItemLabel)
            currentFrameX += itemWidth
        }
    }
    

}
