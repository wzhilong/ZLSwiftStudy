//
//  ZLLanYaManage.m
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLLanYaManage.h"


@interface ZLLanYaManage ()


@property (strong,nonatomic) void (^scanPeripheralFinishBlock)(CBCentralManager *,CBPeripheral *,NSDictionary<NSString *,id> * ,NSNumber *);

@property (strong,nonatomic) void (^successBlock)(CBPeripheral *);

@property (strong,nonatomic) void (^failConnectPeripheral)(CBPeripheral *,NSError *);

@end


@implementation ZLLanYaManage


+ (void)scanPeripheralDiscoveryBlock:(void (^)(CBCentralManager *, CBPeripheral *, NSDictionary<NSString *,id> *, NSNumber *))discovery
{
    ZLLanYaManage *zl = [ZLLanYaManage getInstance];
    zl.scanPeripheralFinishBlock = discovery;
    if (zl.cbManage == nil) {
        zl.cbManage = [[CBCentralManager alloc] initWithDelegate:zl queue:dispatch_queue_create("蓝牙线程", DISPATCH_QUEUE_SERIAL)];
    }
    
}


+ (void)connectPeripheral:(CBPeripheral *)peripheral successBlock:(void (^)(CBPeripheral *))successBlock errorBlock:(void (^)(CBPeripheral *, NSError *))failConnectPeripheral
{
    ZLLanYaManage *zl = [ZLLanYaManage getInstance];
    zl.successBlock = successBlock;
    zl.failConnectPeripheral = failConnectPeripheral;
    [zl.cbManage connectPeripheral:peripheral options:nil];
    
    
}

+ (instancetype)getInstance
{
    static ZLLanYaManage *zlLanYa;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!zlLanYa) {
            zlLanYa = [[ZLLanYaManage alloc]init];
        }
    });
    return zlLanYa;
}

/**************类方法****************/
//会立即调用的类
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        //蓝牙关闭未开启
        case CBCentralManagerStatePoweredOff:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLCBCentralManagerStatePoweredOff" object:nil];
        }
            break;
        //蓝牙开启
        case CBCentralManagerStatePoweredOn:
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLCBCentralManagerStatePoweredON" object:nil];
            //进行扫描  会回调曹波Manage的didDiscoverPeripheral函数
            [_cbManage scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
}
/**
 *  发现外设
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (_scanPeripheralFinishBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _scanPeripheralFinishBlock(central,peripheral,advertisementData,RSSI);
        });
    }
}
/**
 *  链接外设成功
 *
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    if (_successBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _successBlock(peripheral);
        });
    }
}
/**
 *  链接外设失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (_failConnectPeripheral) {
        dispatch_async(dispatch_get_main_queue(), ^{
           _failConnectPeripheral(peripheral,error); 
        });
        
    }
}




@end
