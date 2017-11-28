//
//  MBPrivacyHeanlthStoreUtil.h
//  MBPrivacyPermissionDemo
//
//  Created by ZhangXiaofei on 2017/11/28.
//  Copyright © 2017年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>


// DEBUG

#ifdef DEBUG
#define DEFLog(FORMAT, ...) fprintf(stderr, "%s [Line %zd]\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define DEFLog(FORMAT, ...) nil
#endif


typedef NS_ENUM(NSUInteger,MBHealthPermissionResponse) {
    MBHealthPermissionResponseSuccess = 0,
    MBHealthPermissionResponseError
};

typedef void (^HealthStorePermissionResponseBlock)(MBHealthPermissionResponse permissionResponse);

@interface MBPrivacyHeanlthStoreUtil : NSObject

@property (nonatomic,copy) HealthStorePermissionResponseBlock permissionResponseBlock;
@property (nonatomic,strong) HKHealthStore *store;

+ (instancetype)sharedInstance;

// 获取权限
- (void)accessHealthPermissionWithBlock:(HealthStorePermissionResponseBlock)block;

// 步数
- (void)readStepCountFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)readStepCountFromHealthStoreWithStartTime:(NSString *)startTime endTime:(NSString *)endTime completion:(void(^)(double value,NSError *error))completion;
- (void)writeStepCountToHealthStoreWithUnit:(double)setpCount completion:(void(^)(BOOL response))completion;
- (void)writeStepCountToHealthStoreWithUnit:(double)setpCount startTime:(NSString *)startTime endTime:(NSString *)endTime completion:(void(^)(BOOL response))completion;

// 身高
- (void)readHeightFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeHeightToHealthStoreWithUnit:(double)Height completion:(void(^)(BOOL response))completion;

// 体重
- (void)readBodyMassFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;    /// kg
- (void)writeBodyMassToHealthStoreWithUnit:(double)bodyMass completion:(void(^)(BOOL response))completion;

// 身体质量指数
- (void)readBodyMassIndexFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeBodyMassIndexToHealthStoreWithUnit:(double)bodyMassIndex completion:(void(^)(BOOL response))completion;

// 步行+跑步距离
- (void)readDistanceWalkingRunningFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeDistanceWalkingRunningToHealthStoreWithUnit:(double)distanceWalkingRunning completion:(void(^)(BOOL response))completion;

// 以爬楼层
- (void)readFlightsClimbedFromHealthStoreWithCompletion:(void(^)(NSInteger value,NSError *error))completion;
- (void)writeFlightsClimbedToHealthStoreWithUnit:(NSInteger)flightsClimbed completion:(void(^)(BOOL response))completion;

// 呼吸速率
- (void)readRespiratoryRateFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeRespiratoryRateToHealthStoreWithUnit:(double)respiratoryRate completion:(void(^)(BOOL response))completion;

// 膳食能量消耗
- (void)readDietaryEnergyConsumedFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeDietaryEnergyConsumedToHealthStoreWithUnit:(double)dietaryEnergyConsumed completion:(void(^)(BOOL response))completion;

// 血氧饱和度
- (void)readOxygenSaturationFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

// 体温
- (void)readBodyTemperatureFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeBodyTemperatureToHealthStoreWithUnit:(double)bodyTemperature completion:(void(^)(BOOL response))completion;

// 血糖
- (void)readBloodGlucoseFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;    /// mg/dl
- (void)writeBloodGlucoseToHealthStoreWithUnit:(double)bloodGlucose completion:(void(^)(BOOL response))completion;

// 血压
- (void)readBloodPressureSystolicFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeBloodPressureSystolicToHealthStoreWithUnit:(double)bloodPressureSystolic completion:(void(^)(BOOL response))completion;
- (void)readBloodPressureDiastolicFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
- (void)writeBloodPressureDiastolicToHealthStoreWithUnit:(double)bloodPressureDiastolic completion:(void(^)(BOOL response))completion;

// 站立小时
- (void)readStandHourFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

// 性别
- (void)readBiologicalSexFromHealthStoreWithCompletion:(void(^)(NSString *sex,NSError *error))completion;

// 出生日期
- (void)readDateOfBirthFromHealthStoreWithCompletion:(void(^)(NSDate *date,NSError *error))completion;

// 血型
- (void)readBloodTypeFromHealthStoreWithCompletion:(void(^)(NSString *bloodType,NSError *error))completion;

// 日光反应型皮肤类型
- (void)readFitzpatrickSkinFromHealthStoreWithCompletion:(void(^)(NSString *skinType,NSError *error))completion;

// 睡眠分析
- (void)readSleepAnalysisFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

// 月经
- (void)readMenstrualFlowFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

// 点滴出血
- (void)readIntermenstrualBleedingFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

// 性行为
- (void)readSexualActivityFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

@end
