//
//  MBPrivacyPermissionManager.h
//  MBPrivacyPermissionDemo
//
//  Created by ZhangXiaofei on 2017/11/28.
//  Copyright © 2017年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MBPrivacyPermissionType) {
    MBPrivacyPermissionTypePhoto = 0,       // 照片
    MBPrivacyPermissionTypeCamera,          // 照相机
    MBPrivacyPermissionTypeMicroPhone,      // 录音
    MBPrivacyPermissionTypeMedia,           // 媒体资料库
    MBPrivacyPermissionTypeLocation,        // 定位
    MBPrivacyPermissionTypePushNotification,// 推送
    MBPrivacyPermissionTypeContact,         // 通讯录
    MBPrivacyPermissionTypeHealth,          // 健康
    MBPrivacyPermissionTypeBluetooth,       // 蓝牙
    MBPrivacyPermissionTypeSpeech,          // 语音识别服务
    MBPrivacyPermissionTypeEvent,           // 日历
    MBPrivacyPermissionTypeReminder,        // 备忘录
};

typedef NS_ENUM(NSUInteger,MBPrivacyAuthorizationStatus) {
    MBPrivacyPermissionAuthorizationStatusAuthorized = 0,       // 授权
    MBPrivacyPermissionAuthorizationStatusDenied,               // 拒绝
    MBPrivacyPermissionAuthorizationStatusNotDetermined,        // 未确认
    MBPrivacyPermissionAuthorizationStatusRestricted,           // 受限
    MBPrivacyPermissionAuthorizationStatusUnkonwn,              // 未知
    MBPrivacyPermissionAuthorizationStatusLocationAlways,       // 一直进行定位，只适用于定位
    MBPrivacyPermissionAuthorizationStatusLocationWhenInUse,    // 当使用的时候进行定位，只适用于定位
};

@interface MBPrivacyPermissionManager : NSObject

/**
 获取系统隐私权限
 
 @param privacyType 隐私权限类型
 @param completion 返回结果
 */
+ (void)accessPrivacyPermission:(MBPrivacyPermissionType)privacyType completion:(void(^)(MBPrivacyAuthorizationStatus status))completion;

@end
