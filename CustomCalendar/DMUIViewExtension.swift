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
        layer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width);
        layer.backgroundColor = color.cgColor
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
        layer.frame = CGRect(x: margin, y: self.frame.size.height - width, width: self.frame.size.width - margin * 2, height: width);
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    /**
     为View右侧添加一条线
     
     - parameter color: 线的颜色
     - parameter width: 线的宽度
     */
    func drawRightLineForView(lineColor color: UIColor, lineWidth width: CGFloat){
        let layer = CALayer()
        layer.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.height);
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
    }
    
    /**
     为View底部添加一条虚线
     
     - parameter margin: 虚线距view的左右边距
     */
    func drawBottomLineDashView(marginLeftAndRight margin: CGFloat){
        if let image = UIImage(named: "split_line") {
            let processedImage = image.stretchableImage(withLeftCapWidth: Int(image.size.width / 2), topCapHeight: 0)
            let spliteLineImageView = UIImageView(image: processedImage)
            let frameY = self.frame.size.height - image.size.height
            spliteLineImageView.frame = CGRect(x: margin, y: frameY, width: self.frame.width - margin * 2, height: image.size.height)
            self.addSubview(spliteLineImageView)
        }
    }
    
    /**
     为View顶部添加一条虚线
     
     - parameter margin:虚线距view的左右边距
     */
    func drawTopLineDashView(marginLeftAndRight margin: CGFloat){
        if let image = UIImage(named: "split_line") {
            let processedImage = image.stretchableImage(withLeftCapWidth: Int(image.size.width / 2), topCapHeight: 0)
            let spliteLineImageView = UIImageView(image: processedImage)
            spliteLineImageView.frame = CGRect(x: margin, y: 0, width: self.frame.width - margin * 2, height: image.size.height)
            self.addSubview(spliteLineImageView)
        }
    }

    //创建高斯模糊效果的背景
    func createBlurBackground (_ image:UIImage,blurRadius:Float) {
        guard let cgImage = image.cgImage else { return }
        //处理原始NSData数据
        let originImage = CIImage(cgImage: cgImage)
        //创建高斯模糊滤镜
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        
        guard let filter = blurFilter else { return }
        filter.setValue(originImage, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value: blurRadius as Float), forKey: "inputRadius")
        //生成模糊图片
        let context = CIContext(options: nil)
        let result:CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let blurImage = UIImage(cgImage: context.createCGImage(result, from: result.extent)!)
        //将模糊图片加入背景
        let w = self.frame.width
        let h = self.frame.height
        let blurImageView = UIImageView(frame: CGRect(x: -w/2, y: -h/2, width: 2*w, height: 2*h)) //模糊背景是界面的4倍大小
        blurImageView.contentMode = UIViewContentMode.scaleAspectFill //使图片充满ImageView
        blurImageView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight] //保持原图长宽比
        blurImageView.image = blurImage
        self.insertSubview(blurImageView, belowSubview: self) //保证模糊背景在原图片View的下层
    }

}
