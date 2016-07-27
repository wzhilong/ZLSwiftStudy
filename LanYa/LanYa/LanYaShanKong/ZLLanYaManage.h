//
//  ZLLanYaManage.h
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "ZLPeripheralDelegate.h"

/**
 *  负责蓝牙部分的处理 1 会自动检测蓝牙是否可用 
 *   发送蓝牙状态变化的通知 可用 不可用
 *   2 可以惊醒外设扫描
 *   3 对外设的特征记性写入数据
 */
@interface ZLLanYaManage : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate>


@property (strong,nonatomic) CBCentralManager *cbManage;
//扫描外设
+ (void)scanPeripheralDiscoveryBlock:(void (^)(CBCentralManager *,CBPeripheral *,NSDictionary<NSString *,id> * ,NSNumber *))disocre;
/**
 *  链接外设
 *
 *  @param peripheral            外设
 *  @param successBlock          成功返回的执行block
 *  @param failConnectPeripheral 失败时执行的block 
 */
+ (void)connectPeripheral:(CBPeripheral *)peripheral successBlock:(void(^)(CBPeripheral *))successBlock errorBlock:(void(^)(CBPeripheral *,NSError *))failConnectPeripheral;
/**
 *  设置peripheral的代理
 *
 *  @param peripheral 
 */
//+ (void)setPeripheralDelegate:(CBPeripheral *)peripheral;

@end
