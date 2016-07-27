//
//  ZLPeripheralDelegate.h
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "ZLJianWeiConfig.h"


@interface ZLPeripheralDelegate : NSObject <CBPeripheralDelegate>


- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;
@property (weak,nonatomic) CBPeripheral *peripheral;

- (void)discoveryAll;

+ (CBService *)serviceFromPeripheral:(CBPeripheral *)peripheral UUID:(NSString  *)uuid;

+ (CBCharacteristic *)characteristicFromService:(CBService *)service UUID:(NSString *)uuid
;

@end
