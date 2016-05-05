//
//  ZLFaceView.swift
//  ZLSwiftFrist
//
//  Created by 10fenkeMacTwo on 16/5/5.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

import UIKit

class ZLFaceView: UIView  {


    var  faceCenter :CGPoint
    {
        return convertPoint(center, fromView: superview)
    }
    var  faceRadio :CGFloat{
        return min(bounds.size.width, bounds.size.height)/2 * 0.9
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        let pan = UIPanGestureRecognizer.init(target: self, action: Selector.init(panGest()))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func panGest() -> Void {
        
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter,radius: faceRadio,startAngle:0,endAngle: CGFloat(2*M_PI),clockwise: true )
        let color :UIColor = UIColor.blueColor()
        
        facePath.lineWidth = 1
        color.set()
        facePath.stroke()
        
        let  delegate  = ZLFaceDataBase()
        delegate.smail = 10;
        delegate.color = UIColor.cyanColor()
        let (b1,b2 ) = delegate.smilePath(2)
        b1.stroke()
        b2.stroke()
        
    }
    
    
    
    
}
