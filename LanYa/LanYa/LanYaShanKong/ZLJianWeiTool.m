//
//  ZLJianWeiTool.m
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#import "ZLJianWeiTool.h"

@implementation ZLJianWeiTool

+ (void)writeChatcteristcPeripheral:(CBPeripheral *)peri
{
    dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_SERIAL), ^{
       
        CBService *service;
        CBCharacteristic *ch1;
        CBCharacteristic *ch2;
        BOOL flag = true;
        while (flag) {
            if (service == nil) {
                service = [ZLPeripheralDelegate serviceFromPeripheral:peri UUID:ZLCBServiceUUID];
            }
            
            if ( service != nil)
            {
                if (ch1 == nil) {
                    ch1 = [ZLPeripheralDelegate characteristicFromService:service UUID:ZLCBChatact1UUID];
                }
                if (ch2 == nil) {
                    ch2 = [ZLPeripheralDelegate characteristicFromService:service UUID:ZLCBChatact2UUID];
                }
                
                if (ch2 && ch1) {
                    break;
                }
                
            }
            sleep(1);
            NSLog(@"休眠1秒");
            
        }
        
        [peri setNotifyValue:true forCharacteristic:ch1];
        
        Byte byte1[] = {0x01,0x00};
        NSData *data1 = [NSData dataWithBytes:byte1 length:2];
        [peri writeValue:data1 forCharacteristic:ch1 type:CBCharacteristicWriteWithResponse];
        
        
        Byte byte2[] = {-1};
        NSData *data2 = [NSData dataWithBytes:byte2 length:1];
        [peri writeValue:data2 forCharacteristic:ch2 type:CBCharacteristicWriteWithoutResponse];
        
        
    });
}
@end
