//
//  MBPrivacyPermissionManager.m
//  MBPrivacyPermissionDemo
//
//  Created by ZhangXiaofei on 2017/11/28.
//  Copyright © 2017年 Mario. All rights reserved.
//

#import "MBPrivacyPermissionManager.h"
#import "MBPrivacyHeanlthStoreUtil.h"

#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

static NSInteger const MBPrivacyPermissionTypeLocationDistanceFilter = 10;  // 定位精度

@implementation MBPrivacyPermissionManager

+ (void)accessPrivacyPermission:(MBPrivacyPermissionType)privacyType completion:(void(^)(MBPrivacyAuthorizationStatus status))completion {
    switch (privacyType) {
            
        case MBPrivacyPermissionTypePhoto: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusDenied) {
                    completion(MBPrivacyPermissionAuthorizationStatusDenied);
                } else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == PHAuthorizationStatusRestricted) {
                    completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == PHAuthorizationStatusAuthorized) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeCamera: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == AVAuthorizationStatusDenied) {
                        completion(MBPrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == AVAuthorizationStatusRestricted) {
                        completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeMedia: {
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                if (status == MPMediaLibraryAuthorizationStatusDenied) {
                    completion(MBPrivacyPermissionAuthorizationStatusDenied);
                } else if (status == MPMediaLibraryAuthorizationStatusNotDetermined) {
                    completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == MPMediaLibraryAuthorizationStatusRestricted) {
                    completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeMicroPhone: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (granted) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == AVAuthorizationStatusDenied) {
                        completion(MBPrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == AVAuthorizationStatusRestricted) {
                        completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeLocation: {
            if ([CLLocationManager locationServicesEnabled]) {
                CLLocationManager *locationManager = [[CLLocationManager alloc]init];
                [locationManager requestAlwaysAuthorization];
                [locationManager requestWhenInUseAuthorization];
                locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
                locationManager.distanceFilter = MBPrivacyPermissionTypeLocationDistanceFilter;
                [locationManager startUpdatingLocation];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways) {
                completion(MBPrivacyPermissionAuthorizationStatusLocationAlways);
            } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion(MBPrivacyPermissionAuthorizationStatusLocationWhenInUse);
            } else if (status == kCLAuthorizationStatusDenied) {
                completion(MBPrivacyPermissionAuthorizationStatusDenied);
            } else if (status == kCLAuthorizationStatusNotDetermined) {
                completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
            } else if (status == kCLAuthorizationStatusRestricted) {
                completion(MBPrivacyPermissionAuthorizationStatusRestricted);
            }
        }
            break;
            
        case MBPrivacyPermissionTypeBluetooth: {
            CBCentralManager *centralManager = [[CBCentralManager alloc] init];
            CBManagerState state = [centralManager state];
            if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
                completion(MBPrivacyPermissionAuthorizationStatusDenied);
            } else {
                completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
            }
        }
            break;
            
        case MBPrivacyPermissionTypePushNotification: {
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        }];
                        completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                    } else {
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
                    }
                }];
            } else if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
#pragma clang diagnostic pop
            }
        }
            break;
            
        case MBPrivacyPermissionTypeSpeech: {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                    completion(MBPrivacyPermissionAuthorizationStatusDenied);
                } else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                    completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                    completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                } else if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeEvent: {
            EKEventStore *store = [[EKEventStore alloc]init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(MBPrivacyPermissionAuthorizationStatusDenied);
                    } else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                    } else if (status == EKAuthorizationStatusRestricted) {
                        completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeContact: {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                if (granted) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == CNAuthorizationStatusDenied) {
                        completion(MBPrivacyPermissionAuthorizationStatusDenied);
                    }else if (status == CNAuthorizationStatusRestricted){
                        completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                    }else if (status == CNAuthorizationStatusNotDetermined){
                        completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeReminder: {
            EKEventStore *eventStore = [[EKEventStore alloc]init];
            [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                } else {
                    if (status == EKAuthorizationStatusDenied) {
                        completion(MBPrivacyPermissionAuthorizationStatusDenied);
                    }else if (status == EKAuthorizationStatusNotDetermined){
                        completion(MBPrivacyPermissionAuthorizationStatusNotDetermined);
                    }else if (status == EKAuthorizationStatusRestricted){
                        completion(MBPrivacyPermissionAuthorizationStatusRestricted);
                    }
                }
            }];
        }
            break;
            
        case MBPrivacyPermissionTypeHealth:{
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
                if (![HKHealthStore isHealthDataAvailable]) {
                    NSAssert([HKHealthStore isHealthDataAvailable],@"Device not support HealthKit");
                }else{
                    
                    [[MBPrivacyHeanlthStoreUtil sharedInstance]  accessHealthPermissionWithBlock:^(MBHealthPermissionResponse permissionResponse) {
                        if (permissionResponse == MBHealthPermissionResponseSuccess) {
                            completion(MBPrivacyPermissionAuthorizationStatusAuthorized);
                        } else {
                            completion(MBPrivacyPermissionAuthorizationStatusDenied);
                        }
                    }];
                }
            } else {
                NSAssert([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0, @"iOS8 below systems are not currently supported");
            }
        }
            break;
            
        default:
            break;
    }
}

+ (NSSet *)readObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}

+ (NSSet *)writeObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}


@end
