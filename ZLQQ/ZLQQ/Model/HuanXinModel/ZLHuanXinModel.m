//
//  ZLHuanXinModel.m
//  ZLQQ
//
//  Created by 10fenkeMacTwo on 16/7/20.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLHuanXinModel.h"

@implementation ZLHuanXinModel

//系统唯一的一个处理环形登录和退出的单利
+ (instancetype)getInstance
{
    static ZLHuanXinModel *hxM;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!hxM) {
            hxM = [[ZLHuanXinModel alloc]init];
            [hxM configHuanXin];
        }
    });
    return hxM;
}

/**
 *  程序启动运行时配置环信相关数据
 */
- (void)configHuanXin
{
    //环信启动相关
    EMOptions *options = [EMOptions optionsWithAppkey:HXAPPKEY];
    options.apnsCertName = HXApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    //配置自动登录会掉的代理对象
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    
        
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

/**
 *  注册账号
 *
 *  @param userName       用户名
 *  @param psw            用户密码
 *  @param synFinishBlock 同步执行的 注册完成后的回调
 */
- (void)registerHXWithUserName:(NSString *)userName psw:(NSString *)psw synFinishBlock:(void (^)(EMError *))synFinishBlock
{
    EMError *error = [[EMClient sharedClient] registerWithUsername:userName password:psw];
    if (synFinishBlock) {
        synFinishBlock(error);
    }
}
/**
 *  登录到环信 如果已经是登录的 则直接返回已经登录
 *
 *  @param userName       用户名
 *  @param psw            密码
 *  @param finishSynBlock 返回的回调函数 同步执行的
 */
- (void)loginUserName:(NSString *)userName psw:(NSString *)psw FinishSynBlock:(void(^)(EMError *error))finishSynBlock
{
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    _hxConfig.isAutoLogin = isAutoLogin;
    
    if (isAutoLogin ) {
        if (finishSynBlock) {
            finishSynBlock(nil);
        }
    }
    else
    {
        EMError *error = [[EMClient sharedClient] loginWithUsername:userName password:psw];
        if (finishSynBlock) {
            finishSynBlock(error);
        }
        
    }
}
/**
 *  退出登录
 *
 *  @param loginOutBlock 退出登录后执行的回调函数 同步
 */
- (void)loginOutFinishSynBlick:(void (^)(EMError *))loginOutBlock
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (loginOutBlock) {
        loginOutBlock(error);
    }
}

#pragma mark HuanXin delegate Function 环信系统代理回调函数
/*********************环信系统代理回调函数**************************************/
/*!
 *  自动登录返回结果
 *
 *  @param aError 错误信息
 */
- (void)didAutoLoginWithError:(EMError *)aError
{
    
}

/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState
{
    if (_connectionStateChanged) {
        _connectionStateChanged(aConnectionState);
    }
}

/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice
{
    if (_loginFromOtherDevice) {
        _loginFromOtherDevice();
    }
}
/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer
{
    if (_removedFromServer) {
        _removedFromServer();
    }
}





@end
