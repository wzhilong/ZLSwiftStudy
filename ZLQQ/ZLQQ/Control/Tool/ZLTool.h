//
//  ZLTool.h
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/21.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
@interface ZLTool : NSObject


+ (MJRefreshGifHeader *)RefreashHeaderTarget:(id)target select:(SEL)action;

+ (MJRefreshFooter *)RefreashFooterTargate:(id)target selction:(SEL)action;

@end
