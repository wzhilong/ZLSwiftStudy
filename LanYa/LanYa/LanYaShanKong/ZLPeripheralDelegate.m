//
//  ZLPeripheralDelegate.m
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLPeripheralDelegate.h"

@implementation ZLPeripheralDelegate


- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
{
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoveryAll
{
    if (_peripheral != nil) {
        _peripheral.delegate = self;
        [_peripheral discoverServices:nil];
    }
}

+ (CBService *)serviceFromPeripheral:(CBPeripheral *)peripheral UUID:(NSString *)uuid
{
    CBUUID *UUID = [CBUUID UUIDWithString:uuid];
    if (peripheral.services != nil) {
        for (CBService *ser in peripheral.services ) {
            if ([ser.UUID isEqual:UUID]) {
                return ser;
            }
        }
    }
    return nil;
}

+ (CBCharacteristic *)characteristicFromService:(CBService *)service UUID:(NSString *)uuid
{
    CBUUID *UUID = [CBUUID UUIDWithString:uuid];
    if (service.characteristics != nil) {
        for (CBCharacteristic *ch in service.characteristics ) {
            if ([ch.UUID isEqual:UUID]) {
                return ch;
            }
        }
    }
    return nil;
}





/**************************代理的函数***************************************/
/**
 *  发现服务
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"发现服务%@",service);
        [_peripheral discoverCharacteristics:nil forService:service];
    }
}
//发现外设服务特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *ch in service.characteristics )
    {
        NSLog(@"发现服务%@的特征%@",service.UUID, ch.UUID);
        [_peripheral discoverDescriptorsForCharacteristic:ch];
    }
    
}
//发现特征描述
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    for (CBDescriptor *des in characteristic.descriptors )
    {
        NSLog(@"发现特征%@的描述%@",characteristic.UUID,des.UUID);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices
{
    
}



- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
}
/**
 *  name 改变
 *
 */
-(void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    
}
/**
 *  外设特征改变的回调 即外设特征的数值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    ZLSK sk = [self checkDataZLSK:characteristic.value];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZLNotiCharactChange object:[NSNumber numberWithInteger:sk]];
    
    
}
/**
 *  收到外设更新的描述信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}



#pragma mark  tool function
- (ZLSK)checkDataZLSK:(NSData *)data
{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (str.length < 1) {
        return 0;
    }
    UniChar ch = [str characterAtIndex:0];
    
    ZLSK sk;
    switch (ch) {
        case 5:
        {
            sk = ZLSKTrailPress;
        }
            break;
        case 5 + 32:
        {
            sk = ZLSKTrailRelease;
        }
            break;
        case 6:
        {
            sk = ZLSKHeadPress;
        }
            break;
        case 6+32:
        {
            sk = ZLSKHeadRelease;
        }
            break;
        case 7 :
        {
            sk = ZLSKLeftPress;
        }
            break;
        case 7 + 32:
        {
            sk = ZLSKLeftRelease;
        }
            break;
        case 8:
        {
            sk = ZLSKRightPress;
        }
            break;
        case 8 + 32:
        {
            sk = ZLSKRightRelease;
        }
            break;
        case 9:
        {
            sk = ZLSKCentrolPress;
        }
            break;
        case 9 + 32:
        {
            sk = ZLSKCentrolRelease;
        }
            break;
        case 2:
        {
            sk = ZLSKPhotoPress;
        }
            break;
        case 2 + 32:
        {
            sk = ZLSKPhotoRelease;
        }
            break;
            
        case 29:
        {
            sk = ZLSKSpeekPress;
        }
            break;
        case 45:
        {
            sk = ZLSKSpeekRelease;
        }
            break;
        default:
        {
            sk = ZLSKError;
        }
            
            break;
    }
    
    return sk;
}
@end
