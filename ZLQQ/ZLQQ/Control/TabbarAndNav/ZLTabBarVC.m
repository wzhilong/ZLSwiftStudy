//
//  ZLTabBarVC.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/21.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLTabBarVC.h"

@implementation ZLTabBarVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title normolImg:(NSString *)normolImg selectedImg:(NSString *)selectedImg
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:normolImg];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImg];

}



@end
