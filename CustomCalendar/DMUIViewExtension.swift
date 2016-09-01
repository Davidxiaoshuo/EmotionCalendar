//
//  DMUIViewExtension.swift
//  DataMi
//
//  Created by David小硕 on 16/6/10.
//  Copyright © 2016年 DataMi. All rights reserved.
//

import UIKit

extension UIView{
    
    /**
     为View底部添加一条线
     
     - parameter color: 线的颜色
     - parameter width: 线的宽度
     */
    func drawBottomLineForView(lineColor color: UIColor, lineWidth width: CGFloat){
        let layer = CALayer()
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor
        self.layer.addSublayer(layer)
    }
    
    /**
     为View底部添加一条线
     
     - parameter color:  线的颜色
     - parameter width:  线的宽度
     - parameter margin: 左右间距
     */
    func drawBottomLineForView(lineColor color: UIColor, lineWidth width: CGFloat, margin: CGFloat){
        let layer = CALayer()
        layer.frame = CGRectMake(margin, self.frame.size.height - width, self.frame.size.width - margin * 2, width);
        layer.backgroundColor = color.CGColor
        self.layer.addSublayer(layer)
    }
    
    /**
     为View右侧添加一条线
     
     - parameter color: 线的颜色
     - parameter width: 线的宽度
     */
    func drawRightLineForView(lineColor color: UIColor, lineWidth width: CGFloat){
        let layer = CALayer()
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.height);
        layer.backgroundColor = color.CGColor
        self.layer.addSublayer(layer)
    }
    
    /**
     为View底部添加一条虚线
     
     - parameter margin: 虚线距view的左右边距
     */
    func drawBottomLineDashView(marginLeftAndRight margin: CGFloat){
        if let image = UIImage(named: "split_line") {
            let processedImage = image.stretchableImageWithLeftCapWidth(Int(image.size.width / 2), topCapHeight: 0)
            let spliteLineImageView = UIImageView(image: processedImage)
            let frameY = self.frame.size.height - image.size.height
            spliteLineImageView.frame = CGRectMake(margin, frameY, self.frame.width - margin * 2, image.size.height)
            self.addSubview(spliteLineImageView)
        }
    }
    
    /**
     为View顶部添加一条虚线
     
     - parameter margin:虚线距view的左右边距
     */
    func drawTopLineDashView(marginLeftAndRight margin: CGFloat){
        if let image = UIImage(named: "split_line") {
            let processedImage = image.stretchableImageWithLeftCapWidth(Int(image.size.width / 2), topCapHeight: 0)
            let spliteLineImageView = UIImageView(image: processedImage)
            spliteLineImageView.frame = CGRectMake(margin, 0, self.frame.width - margin * 2, image.size.height)
            self.addSubview(spliteLineImageView)
        }
    }

    //创建高斯模糊效果的背景
    func createBlurBackground (image:UIImage,blurRadius:Float) {
        guard let cgImage = image.CGImage else { return }
        //处理原始NSData数据
        let originImage = CIImage(CGImage: cgImage)
        //创建高斯模糊滤镜
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        
        guard let filter = blurFilter else { return }
        filter.setValue(originImage, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(float: blurRadius), forKey: "inputRadius")
        //生成模糊图片
        let context = CIContext(options: nil)
        let result:CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
        let blurImage = UIImage(CGImage: context.createCGImage(result, fromRect: result.extent))
        //将模糊图片加入背景
        let w = self.frame.width
        let h = self.frame.height
        let blurImageView = UIImageView(frame: CGRectMake(-w/2, -h/2, 2*w, 2*h)) //模糊背景是界面的4倍大小
        blurImageView.contentMode = UIViewContentMode.ScaleAspectFill //使图片充满ImageView
        blurImageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight] //保持原图长宽比
        blurImageView.image = blurImage
        self.insertSubview(blurImageView, belowSubview: self) //保证模糊背景在原图片View的下层
    }

    
//    func showLoader() {
//        self.showIndecatorViewWithUndertint()
//    }
//    
//    func hideLoader() {
//        self.hideIndecator()
//    }
    
//    func showIndecatorViewWithUndertint(){
//        let indecator = DMIndecatorView.sharedInstance
//        indecator.itemAppearanceType = AppearanceType.RoundIndecator
//        indecator.indecatorItemBackground = UIColorFromHexRGB(0xffffff, alpha: 1)
//        indecator.backgroundColor = UIColorFromHexRGB(0x000000, alpha: 0.7)
//        self.addSubview(indecator)
//        indecator.layoutSelfToCenter()
//        indecator.showIndecatorWithAnimation(true)
//    }
//    
//    func showIndecatorViewWithDeepColor(){
//        let indecator = DMIndecatorView.sharedInstance
//        indecator.itemAppearanceType = AppearanceType.RoundIndecator
//        indecator.indecatorItemBackground = UIColorFromHexRGB(0x232323, alpha: 1)
//        self.addSubview(indecator)
//        indecator.layoutSelfToCenter()
//        indecator.showIndecatorWithAnimation(true)
//    }
//    
//    func hideIndecator(){
//        DMIndecatorView.sharedInstance.hidden()
//    }
    

}
