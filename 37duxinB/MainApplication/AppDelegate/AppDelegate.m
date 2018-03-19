//
//  AppDelegate.m
//  37duxinB
//
//  Created by 37duxin on 24/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+GETUI.h"
#import "AppDelegate+HelpDesk.h"
#import "AppDelegate+General.h"
#import "AppDelegate+GETUI.h"
#import "MainTabbarVC.h"
#import "LoginViewController.h"
#import "DemoCallManager.h"
#import "BackgroundViewController.h"
#import <Bugtags/Bugtags.h>
#import "LaunchIntroductionView.h"

#define BUGTAGS @"9cd4041b70c9b5830dce1d58a716f66a"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingUserSteps = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:BUGTAGS invocationEvent:BTGInvocationEventNone options:options];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    self.window.backgroundColor = [UIColor whiteColor];
    [self generalApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    NSString *string = FetchToken;
    if(string == nil)
    {
        [self drawView];
    }
    else
    {
       
        [self tabbarView];
    }
    [self.window makeKeyAndVisible];
    
    [self setLaunchPage];
    
    return YES;
}

-(void)setLaunchPage{
    
#if 1
    [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png")]];
#elif 0
    [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#elif 0
    LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    launch.currentColor = [UIColor redColor];
    launch.nomalColor = [UIColor greenColor];
#else
    //只有在存在该storyboard时才调用该方法，否则会引起crash
    [LaunchIntroductionView sharedWithStoryboard:@"Main" images:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#endif
    
    
}


-(void)tabbarView
{
    MainTabbarVC *vc = [[MainTabbarVC alloc] init];
    [[DemoCallManager sharedManager] setMainController:vc];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setHidden:YES];
    self.window.rootViewController = nav;
    
    
}

-(void)drawView{
    
    LoginViewController *vc = [LoginViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setHidden:YES];
    self.window.rootViewController = nav;

}

#pragma mark -IOS9.0之后统一的openURL接口
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [self generalApplication:app openURL:url options:options];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
