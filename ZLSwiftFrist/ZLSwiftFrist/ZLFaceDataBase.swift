//
//  ZLFaceDataBase.swift
//  ZLSwiftFrist
//
//  Created by 10fenkeMacTwo on 16/5/5.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

import UIKit

 protocol ZLFaceDataDelegate {
    var smail:CGFloat{get set}
    var color:UIColor{get set}
    func smilePath(smail:CGFloat) -> (UIBezierPath,UIBezierPath)
}
class ZLFaceDataBase :ZLFaceDataDelegate{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var smail: CGFloat {
        set{
        }
        get{
            return self.smail
        }
    }
    var color: UIColor {
        set{
        }
        get{
            return self.color
        }
    }
    
    func smilePath(smail: CGFloat) -> (UIBezierPath, UIBezierPath) {
        let   note  = UIBezierPath()
        let mont = UIBezierPath()
        note.addArcWithCenter(CGPoint.init(x: 100, y: 100), radius: smail * 100, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: false)
        mont.addArcWithCenter(CGPoint.init(x: 100, y: 100), radius: smail*100, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: false)
        return (note,mont)
    }

}
