//
//  ZLLoginTextField.h
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/20.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLLoginTextField : UIView
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UILabel *buttomLineL;

@property (weak, nonatomic) IBOutlet UITextField *textField;

+ (instancetype)getZLLoginTextField;
@end
