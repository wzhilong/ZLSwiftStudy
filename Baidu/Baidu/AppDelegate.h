//
//  AppDelegate.h
//  Baidu
//
//  Created by 10fenkeMacTwo on 16/7/13.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduTraceSDK/BaiduTraceSDK-Swift.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BMKMapManager *mapManager;
@end

