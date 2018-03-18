//
//  DemoConfManager.h
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 23/11/2016.
//  Copyright © 2016 XieYajie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KNOTIFICATION_CONFERENCE @"conference"

// 改成作为根控制器的类
//@class MainViewController;
@class MainTabbarVC;
@interface DemoConfManager : NSObject

#if DEMO_CALL == 1

// 改成作为根控制器的类
//@property (strong, nonatomic) MainViewController *mainController;
@property (strong, nonatomic) MainTabbarVC *mainController;

+ (instancetype)sharedManager;

- (void)createConferenceWithType:(EMCallType)aType;

#endif

@end
