//
//  DMCalendarContentView.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

let kDefaultColumnNum: Int = 7
let kDefaultCellNum: Int = 35

class DMCalendarContentView: UIScrollView {
    
    var marginLeftAndRight: CGFloat = 0
    
    var cellEntitis: [DMCalendarDay] = []{
        didSet{
            for cell in self.dateCells{
                cell.removeFromSuperview()
            }
            self.dateCells.removeAll()
            self.setupDateCells(cellEntitis)
        }
    }
    
    var cellNum: Int = kDefaultCellNum
    
    private var dateCells: [UIButton] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, marginLeftRight: CGFloat) {
        super.init(frame: frame)
        self.marginLeftAndRight = marginLeftRight
        self.setupSubviews()
    }
    
    func setupSubviews(){
        self.backgroundColor = UIColor.whiteColor()
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = false
        self.alwaysBounceVertical = false
        self.setupDateCells()
    }
    
    func setupDateCells(cellEntities: [DMCalendarDay]? = nil){
        let cellItemWidth: CGFloat = (self.frame.width - marginLeftAndRight * 2) / CGFloat(kDefaultColumnNum)
        if cellEntities == nil || cellEntities?.count <= 0{
            cellNum = kDefaultCellNum
        }else{
            cellNum = cellEntities!.count
        }
        var rowNum: Int = 0
        var currentFrameX: CGFloat = marginLeftAndRight
        var currentFrameY: CGFloat = 0
        for i in 1...(cellNum){
            let cellBtn = UIButton(frame: CGRectMake(currentFrameX, currentFrameY, cellItemWidth, cellItemWidth))
            cellBtn.backgroundColor = UIColor.clearColor()
            cellBtn.tag = i - 1

            if let entities = cellEntities where entities.count > 0{
                let cellDay = entities[i-1]
                cellBtn.setTitle("\(cellDay.day)", forState: .Normal)
                if cellDay.isCurrentMonthDay{
                    cellBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    cellBtn.addTarget(self, action: #selector(onCellItemClicked(_:)), forControlEvents: .TouchUpInside)
                }else{
                    cellBtn.setTitleColor(UIColorFromHexRGB(0x8995a2, alpha: 1), forState: .Normal)
                }
                cellBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
                
                if let emotionStyle = cellDay.emotionType{
                    cellBtn.setTitle(nil, forState: .Normal)
                    self.setImageWithEmotion(emotionStyle, withCellBtn: cellBtn)
                }
            }
            
            self.addSubview(cellBtn)
            self.dateCells.append(cellBtn)
            
            if i % kDefaultColumnNum == 0{
                currentFrameX = marginLeftAndRight
                rowNum = i / kDefaultColumnNum
                currentFrameY = CGFloat(rowNum) * cellItemWidth
            }else{
                currentFrameX += cellItemWidth
            }
        }
        self.contentSize = CGSizeMake(self.frame.width, cellItemWidth * CGFloat(rowNum))
    }

    func onCellItemClicked(sender: UIButton){
        print("clicked Button is \(sender.tag)")
    }
    
    
    func setImageWithEmotion(emotionType: Emotion, withCellBtn cellBtn: UIButton){
        switch emotionType {
        case .Cry:
            cellBtn.setImage(UIImage(named: "btn_select_face_cry_pressed"), forState: .Normal)
        case .Sad:
            cellBtn.setImage(UIImage(named: "btn_select_face_upset_pressed"), forState: .Normal)
        case .Happy:
            cellBtn.setImage(UIImage(named: "btn_select_face_happy_pressed"), forState: .Normal)
        case .Calm:
            cellBtn.setImage(UIImage(named: "btn_select_face_bored_pressed"), forState: .Normal)
        case .Angry:
            cellBtn.setImage(UIImage(named: "btn_select_face_anger_pressed"), forState: .Normal)
        }
    }
    
}
