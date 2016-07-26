//
//  ZLHuanXinModel.h
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/20.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLHXConfig.h"

#import "EaseUI.h"


@interface ZLHuanXinModel : NSObject <EMClientDelegate>

//换新的配置对象
@property (strong,nonatomic) ZLHXConfig *hxConfig;
/**
 *  自动登录会执行的回调block
 */
@property (strong,nonatomic) void (^huanXinAutoLoginBlock)(EMError *);
/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
@property (strong,nonatomic) void (^connectionStateChanged)(EMConnectionState );
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
@property (strong,nonatomic) void (^loginFromOtherDevice)(void);
/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
@property (strong,nonatomic) void (^removedFromServer)(void);


#pragma mark Function  方法
/*************************************************/
/**
 *  一个程序的单一环信实例对象  单例
 *
 *  @return 返回单利对象
 */
+ (instancetype)getInstance;

/**
 *  注册账号
 *
 *  @param userName       用户名
 *  @param psw            用户密码
 *  @param synFinishBlock 同步执行的 注册完成后的回调
 */
- (void)registerHXWithUserName:(NSString *)userName psw:(NSString *)psw synFinishBlock:(void(^)(EMError *))synFinishBlock;

/**
 *  登录到环信 如果已经是登录的 则直接返回已经登录
 *
 *  @param userName       用户名
 *  @param psw            密码
 *  @param finishSynBlock 返回的回调函数
 */
- (void)loginUserName:(NSString *)userName psw:(NSString *)psw FinishSynBlock:(void(^)(EMError *error))finishSynBlock;

/**
 *  退出登录
 *
 *  @param loginOutBlock 同步执行的 退出登录后的操作
 */
- (void)loginOutFinishSynBlick:(void(^)(EMError *))loginOutBlock;


//
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;


@end
