//
//  ZLTool.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/21.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLTool.h"

@implementation ZLTool

+ (MJRefreshGifHeader *)RefreashHeaderTarget:(id)target select:(SEL)action
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader  headerWithRefreshingTarget:target refreshingAction:action];
    UIImage *image1 = [UIImage imageNamed:@"img_loading_01"];
    UIImage *image2 = [UIImage imageNamed:@"img_loading_02"];
    UIImage *image3 = [UIImage imageNamed:@"img_loading_03"];
    NSArray *images_1 = @[image1];
    NSArray *images_2 = @[image2];
    NSArray *images = @[image1,image2,image3];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    // 设置普通状态的动画图片
    [header setImages:images_1 forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:images_2 forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:images forState:MJRefreshStateRefreshing];
    // 马上进入刷新状态
    [header beginRefreshing];
    return header;
}

+ (MJRefreshFooter *)RefreashFooterTargate:(id)target selction:(SEL)action
{
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    return footer;
}


@end
