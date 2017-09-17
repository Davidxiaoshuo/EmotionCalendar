//
//  ViewController.swift
//  CustomCalendar
//
//  Created by David on 16/8/30.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calendarView: DMCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func setupSubviews(){
        self.setupCalendarView()
    }
    
    func setupCalendarView(){
        self.calendarView = DMCalendarView(frame: CGRect(x: 9, y: 200, width: self.view.frame.width - 18, height: 560 / 2 + 35))
        self.view.addSubview(calendarView)
    }
    
}

