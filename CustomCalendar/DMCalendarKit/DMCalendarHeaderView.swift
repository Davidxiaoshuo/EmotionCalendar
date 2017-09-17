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
    
    var previousBlk: ((_ headerView: DMCalendarHeaderView)->Void)?
    var nextBlk: ((_ headerView: DMCalendarHeaderView)->Void)?
    var goBackBlk: ((_ headerView: DMCalendarHeaderView)->Void)?

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
        self.previousBtn = UIButton(frame: CGRect(x: 12, y: 0, width: 44, height: 44))
        self.previousBtn.center = CGPoint(x: self.previousBtn.center.x, y: self.frame.height / 2)
        self.previousBtn.setImage(UIImage(named: "btn_top_navigation_back_normal"), for: UIControlState())
        self.previousBtn.setImage(UIImage(named: "btn_top_navigation_back_pressed"), for: .highlighted)
        self.previousBtn.addTarget(self, action: #selector(onPreviousBtnClicked(_:)), for: .touchUpInside)
        self.addSubview(previousBtn)
    }
    
    func setupNextBtn(){
        let frameX: CGFloat = self.frame.width - 12 - 44
        self.nextBtn = UIButton(frame: CGRect(x: frameX, y: 0, width: 44, height: 44))
        self.nextBtn.center = CGPoint(x: self.nextBtn.center.x, y: self.frame.height / 2)
        self.nextBtn.setImage(UIImage(named: "btn_top_navigation_back_normal"), for: UIControlState())
        self.nextBtn.setImage(UIImage(named: "btn_top_navigation_back_pressed"), for: .highlighted)
        self.nextBtn.addTarget(self, action: #selector(onNextBtnClicked(_:)), for: .touchUpInside)
        self.nextBtn.transform = self.nextBtn.transform.rotated(by: 90 + 45)
        self.addSubview(nextBtn)
    }
    
    func setupTodayLabel(){
        let frameWidth: CGFloat = self.frame.width - (12 + 44) * 2
        self.todayDateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frameWidth, height: self.frame.height))
        self.todayDateLabel.center = CGPoint(x: self.frame.width / 2, y: todayDateLabel.center.y)
        self.todayDateLabel.textColor = UIColor.white
        self.todayDateLabel.textAlignment = .center
        self.todayDateLabel.font = UIFont.systemFont(ofSize: 17)
        self.todayDateLabel.isUserInteractionEnabled = true
        self.todayDateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGoBackToToday(_:))))
        self.addSubview(todayDateLabel)
    }
    
    func onPreviousBtnClicked(_ sender: AnyObject){
        self.previousBlk?(self)
    }
    
    func onNextBtnClicked(_ sender: AnyObject){
        self.nextBlk?(self)
    }
    
    func onGoBackToToday(_ gesture: UITapGestureRecognizer){
        self.goBackBlk?(self)
    }
    
}
