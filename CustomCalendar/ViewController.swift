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
        self.calendarView = DMCalendarView(frame: CGRectMake(9, 200, self.view.frame.width - 18, 560 / 2 + 35))
        self.view.addSubview(calendarView)
    }
    
}

