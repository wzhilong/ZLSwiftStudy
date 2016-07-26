//
//  ZLLoginTextField.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/20.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLLoginTextField.h"

@implementation ZLLoginTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)getZLLoginTextField
{
    ZLLoginTextField *zl = (ZLLoginTextField *)([[[NSBundle mainBundle] loadNibNamed:@"ZLMainView" owner:nil options:nil] objectAtIndex:0]);
    return zl;
}
- (void)config
{
    
}

@end
