pod "MBPrivacyPermission"

####简单使用介绍：
1. MBPrivacyPermissionManager 用来获取隐私权限，具体方法参照注释描述
2. MBPrivacyHeanlthStoreUtil  用来获取健康功能下相关数据的读写
     
    
**注意点：**
1.由于iOS10的权限原因,需要在工程的info.plist(右击选择Open as - Source Code)中添加

```
<!-- 相册 -->   
<key>NSPhotoLibraryUsageDescription</key>   
<string>App需要您的同意,才能访问相册</string>   
<!-- 相机 -->   
<key>NSCameraUsageDescription</key>   
<string>App需要您的同意,才能访问相机</string>   
<!-- 麦克风 -->   
<key>NSMicrophoneUsageDescription</key>   
<string>App需要您的同意,才能访问麦克风</string>   
<!-- 位置 -->   
<key>NSLocationUsageDescription</key>   
<string>App需要您的同意,才能访问位置</string>   
<!-- 在使用期间访问位置 -->   
<key>NSLocationWhenInUseUsageDescription</key>   
<string>App需要您的同意,才能在使用期间访问位置</string>   
<!-- 始终访问位置 -->   
<key>NSLocationAlwaysUsageDescription</key>   
<string>App需要您的同意,才能始终访问位置</string>   
<!-- 日历 -->   
<key>NSCalendarsUsageDescription</key>   
<string>App需要您的同意,才能访问日历</string>   
<!-- 提醒事项 -->   
<key>NSRemindersUsageDescription</key>   
<string>App需要您的同意,才能访问提醒事项</string>   
<!-- 运动与健身 -->   
<key>NSMotionUsageDescription</key>  
 <string>App需要您的同意,才能访问运动与健身</string>   
<!-- 健康更新 -->   
<key>NSHealthUpdateUsageDescription</key>   
<string>App需要您的同意,才能访问健康更新 </string>   
<!-- 健康分享 -->   
<key>NSHealthShareUsageDescription</key>   
<string>App需要您的同意,才能访问健康分享</string>   
<!-- 蓝牙 -->   
<key>NSBluetoothPeripheralUsageDescription</key>   
<string>App需要您的同意,才能访问蓝牙</string>   
<!-- 媒体资料库 -->   
<key>NSAppleMusicUsageDescription</key>   
<string>App需要您的同意,才能访问媒体资料库</string>  
<!-- 语音识别 -->   
<key>NSSpeechRecognitionUsageDescription</key>   
<string>App需要您的同意,才能使用语音识别</string> 

```
2.`健康`支持读写操作权限如下:

|    名称    |  HealthKit Identifier Type  |   Read   |   Write   |
|--------------|-----------------------------|----------|-----------|
|	步数	  | HKQuantityTypeIdentifierStepCount | ✓ | ✓ |
|	身高	  | HKQuantityTypeIdentifierHeight | ✓ | ✓ |
|	体重	  | HKQuantityTypeIdentifierBodyMass | ✓ | ✓ ||
|	身高体重指数	  | HKQuantityTypeIdentifierBodyMassIndex | ✓ | ✓ |
|	步行+跑步距离	| HKQuantityTypeIdentifierDistanceWalkingRunning | ✓ | ✓ |
|	已爬楼层  | HKQuantityTypeIdentifierFlightsClimbed | ✓ | ✓ |
|	呼吸速率	| HKQuantityTypeIdentifierRespiratoryRate | ✓ | ✓  |
|	膳食能量  | HKQuantityTypeIdentifierDietaryEnergyConsumed | ✓ | ✓ |
|	血氧饱和度	  | HKQuantityTypeIdentifierOxygenSaturation | ✓ |  |
|	体温	  |	 HKQuantityTypeIdentifierBodyTemperature | ✓ | ✓ |
|	血糖	  | HKQuantityTypeIdentifierBloodGlucose | ✓ | ✓ |
|	收缩压  | HKQuantityTypeIdentifierBloodPressureSystolic | ✓ | ✓ |
|	舒张压  | HKQuantityTypeIdentifierBloodPressureDiastolic | ✓ | ✓ |
|	站立小时	 | HKCategoryTypeIdentifierAppleStandHour | ✓ |  |
|	性别	  | HKCharacteristicTypeIdentifierBiologicalSex | ✓ |  |
|	出生日期	  |	 HKCharacteristicTypeIdentifierDateOfBirth | ✓ |  |
|	血型	  |	 HKCharacteristicTypeIdentifierBloodType | ✓ |  |
|	日光反应型皮肤类型 | HKCharacteristicTypeIdentifierFitzpatrickSkinType | ✓ |  |
|	睡眠分析	  |	HKCategoryTypeIdentifierSleepAnalysis | ✓ |  |
|	月经	  | HKCategoryTypeIdentifierMenstrualFlow | ✓ |  |	
|	点滴出血  | HKCategoryTypeIdentifierIntermenstrualBleeding | ✓ |  |	
|	性行为  | HKCategoryTypeIdentifierSexualActivity | ✓ |  |


