//
//  ViewController.swift
//  ZLSwiftFrist
//
//  Created by 10fenkeMacTwo on 16/5/5.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let  ss = ZLFaceView()
        ss.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.height)
        self.view.addSubview(ss)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    

    
}



