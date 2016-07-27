//
//  ZLJianWeiConfig.h
//  LanYa
//
//  Created by 10fenkeMacTwo on 16/7/27.
//  Copyright © 2016年 ZhiLong. All rights reserved.
//

#ifndef ZLJianWeiConfig_h
#define ZLJianWeiConfig_h

/**
 *  闪控监听的通知名称
 */
#define ZLNotiCharactChange @"ZLUpdateValueForCharacteristic"


#define ZLCBServiceUUID @"A2A0"

#define ZLCBChatact1UUID @"A2A4"
#define ZLCBChatact2UUID @"A2A3"

typedef NS_ENUM(NSInteger, ZLSK) {
    ZLSKError = 0,
    
    ZLSKHeadPress ,
    ZLSKHeadRelease,
    
    ZLSKTrailPress,
    ZLSKTrailRelease,
    
    ZLSKLeftPress,
    ZLSKLeftRelease,
    
    ZLSKRightPress,
    ZLSKRightRelease,
    
    ZLSKSpeekPress,
    ZLSKSpeekRelease,
    
    ZLSKPhotoPress,
    ZLSKPhotoRelease,
    
    ZLSKCentrolPress,
    ZLSKCentrolRelease,
};

#endif /* ZLJianWeiConfig_h */
