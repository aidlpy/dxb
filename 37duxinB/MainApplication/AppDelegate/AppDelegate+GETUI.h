//
//  AppDelegate+GETUI.h
//  37duxinB
//
//  Created by Zhang Xinrong on 25/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate.h"
#import <GTSDK/GeTuiSdk.h>
#import <PushKit/PushKit.h> //VOIP支持需要导入PushKit库,实现 PKPushRegistryDelegate

// 杭州个推官网
#define kGtAppId @"iOPx9w85tr8BA1znttYBEA"
#define kGtAppKey @"7fLgT8fYya8BmDrBmg1JP6"
#define kGtAppSecret @"j2Sz02NbB16wPkL7pAkXb8"

@interface AppDelegate (GETUI)<GeTuiSdkDelegate>
-(void)getuiApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)getTuiApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
-(void)getTuiApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
@end
