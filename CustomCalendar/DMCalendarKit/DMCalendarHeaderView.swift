//
//  DMCalendarHeaderView.swift
//  CustomCalendar
//
//  Created by David on 16/8/30.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

let kDefaultCalendarHeaderViewHeight: CGFloat = 76 / 2

class DMCalendarHeaderView: UIView {
    
    var previousBtn: UIButton!
    var nextBtn: UIButton!
    var todayDateLabel: UILabel!
    
    var previousBlk: ((headerView: DMCalendarHeaderView)->Void)?
    var nextBlk: ((headerView: DMCalendarHeaderView)->Void)?
    var goBackBlk: ((headerView: DMCalendarHeaderView)->Void)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    func setupSubviews(){
        self.setupPreviousBtn()
        self.setupNextBtn()
        self.setupTodayLabel()
    }
    
    func setupPreviousBtn(){
        self.previousBtn = UIButton(frame: CGRectMake(12, 0, 44, 44))
        self.previousBtn.center = CGPointMake(self.previousBtn.center.x, self.frame.height / 2)
        self.previousBtn.setImage(UIImage(named: "btn_top_navigation_back_normal"), forState: .Normal)
        self.previousBtn.setImage(UIImage(named: "btn_top_navigation_back_pressed"), forState: .Highlighted)
        self.previousBtn.addTarget(self, action: #selector(onPreviousBtnClicked(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(previousBtn)
    }
    
    func setupNextBtn(){
        let frameX: CGFloat = self.frame.width - 12 - 44
        self.nextBtn = UIButton(frame: CGRectMake(frameX, 0, 44, 44))
        self.nextBtn.center = CGPointMake(self.nextBtn.center.x, self.frame.height / 2)
        self.nextBtn.setImage(UIImage(named: "btn_top_navigation_back_normal"), forState: .Normal)
        self.nextBtn.setImage(UIImage(named: "btn_top_navigation_back_pressed"), forState: .Highlighted)
        self.nextBtn.addTarget(self, action: #selector(onNextBtnClicked(_:)), forControlEvents: .TouchUpInside)
        self.nextBtn.transform = CGAffineTransformRotate(self.nextBtn.transform, 90 + 45)
        self.addSubview(nextBtn)
    }
    
    func setupTodayLabel(){
        let frameWidth: CGFloat = self.frame.width - (12 + 44) * 2
        self.todayDateLabel = UILabel(frame: CGRectMake(0, 0, frameWidth, self.frame.height))
        self.todayDateLabel.center = CGPointMake(self.frame.width / 2, todayDateLabel.center.y)
        self.todayDateLabel.textColor = UIColor.whiteColor()
        self.todayDateLabel.textAlignment = .Center
        self.todayDateLabel.font = UIFont.systemFontOfSize(17)
        self.todayDateLabel.userInteractionEnabled = true
        self.todayDateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGoBackToToday(_:))))
        self.addSubview(todayDateLabel)
    }
    
    func onPreviousBtnClicked(sender: AnyObject){
        self.previousBlk?(headerView: self)
    }
    
    func onNextBtnClicked(sender: AnyObject){
        self.nextBlk?(headerView: self)
    }
    
    func onGoBackToToday(gesture: UITapGestureRecognizer){
        self.goBackBlk?(headerView: self)
    }
    
}
