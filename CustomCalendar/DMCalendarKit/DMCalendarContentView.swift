//
//  DMCalendarContentView.swift
//  CustomCalendar
//
//  Created by David on 16/8/31.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


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
    
    fileprivate var dateCells: [UIButton] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, marginLeftRight: CGFloat) {
        super.init(frame: frame)
        self.marginLeftAndRight = marginLeftRight
        self.setupSubviews()
    }
    
    func setupSubviews(){
        self.backgroundColor = UIColor.white
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = false
        self.alwaysBounceVertical = false
        self.setupDateCells()
    }
    
    func setupDateCells(_ cellEntities: [DMCalendarDay]? = nil){
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
            let cellBtn = UIButton(frame: CGRect(x: currentFrameX,
                                                 y: currentFrameY,
                                                 width: cellItemWidth,
                                                 height: cellItemWidth))
            cellBtn.backgroundColor = UIColor.clear
            cellBtn.tag = i - 1

            if let entities = cellEntities, entities.count > 0{
                let cellDay = entities[i-1]
                if let day = cellDay.day{
                    cellBtn.setTitle("\(day)", for: UIControlState())
                }
                if cellDay.isCurrentMonthDay{
                    cellBtn.setTitleColor(UIColor.black, for: UIControlState())
                    cellBtn.addTarget(self, action: #selector(onCellItemClicked(_:)), for: .touchUpInside)
                }else{
                    cellBtn.setTitleColor(UIColorFromHexRGB(0x8995a2, alpha: 1), for: UIControlState())
                }
                cellBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
                
                if let emotionStyle = cellDay.emotionType{
                    cellBtn.setTitle(nil, for: UIControlState())
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
        self.contentSize = CGSize(width: self.frame.width, height: cellItemWidth * CGFloat(rowNum))
    }

    func onCellItemClicked(_ sender: UIButton){
        print("clicked Button is \(sender.tag)")
    }
    
    
    func setImageWithEmotion(_ emotionType: Emotion, withCellBtn cellBtn: UIButton){
        switch emotionType {
        case .cry:
            cellBtn.setImage(UIImage(named: "btn_select_face_cry_pressed"), for: UIControlState())
        case .sad:
            cellBtn.setImage(UIImage(named: "btn_select_face_upset_pressed"), for: UIControlState())
        case .happy:
            cellBtn.setImage(UIImage(named: "btn_select_face_happy_pressed"), for: UIControlState())
        case .calm:
            cellBtn.setImage(UIImage(named: "btn_select_face_bored_pressed"), for: UIControlState())
        case .angry:
            cellBtn.setImage(UIImage(named: "btn_select_face_anger_pressed"), for: UIControlState())
        }
    }
    
}
