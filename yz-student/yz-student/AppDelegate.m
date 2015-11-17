//
//  AppDelegate.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/1.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "StuTabBarViewController.h"

#import "AppDelegate.h"
#import "StuNewFeatureViewController.h"
#import "StuStartPageViewController.h"

#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
//#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//
//////人人SDK头文件
//#import <RennSDK/RennSDK.h>
////
//////GooglePlus SDK头文件
////#import <GooglePlus/GooglePlus.h>
//////GooglePlus SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

#import "MobClick.h"

#define UMKey @"560f51c467e58e3a1800568b"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMKey reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    [MobClick updateOnlineConfig];  //在线参数配置
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self umengTrack];
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //用来设置在homeTableView中设置的self.edgesForExtendedLayout = UIRectEdgeNone;导致tabBar和导航栏变为灰色
    self.window.backgroundColor = [UIColor whiteColor]; 
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        
        NewFeatureViewController *NewFeatureVc = [[NewFeatureViewController alloc]init];
        self.window.rootViewController = NewFeatureVc;
    }else
    {
        StartPageViewController *startVc = [[StartPageViewController alloc]init];
        self.window.rootViewController = startVc;
//        TabBarViewController *tabVc = [[TabBarViewController alloc]init];
//        self.window.rootViewController = tabVc;
    }
    
    [self.window makeKeyAndVisible];
//*****************************************UMAnalyse********************************
    //[UMSocialData setAppKey:@"560f51c467e58e3a1800568b"];
    
//**************************************************shareApp********************************
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    //ShareSDK registerApp:@"addfa53c370e"
    //QQ41DB5616
    
    [ShareSDK registerApp:@"addfa53c370e"
          activePlatforms:@[
//                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeTencentWeibo),
//                            @(SSDKPlatformTypeMail),
//                            @(SSDKPlatformTypeSMS),
//                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeDouBan),
//                            @(SSDKPlatformTypeRenren),
//                            @(SSDKPlatformTypeKaixin),
                            ]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
//                         case SSDKPlatformTypeSinaWeibo:
//                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                             break;
//                         case SSDKPlatformTypeRenren:
//                             [ShareSDKConnector connectRenren:[RennClient class]];
//                             break;
//                         case SSDKPlatformTypeSMS:
//                             [ShareSDK connectSMS];
//                             break;
//                             //连接邮件
//                             [ShareSDK connectMail];
//                             
//                             //连接打印
//                             [ShareSDK connectAirPrint];
//                             
//                             //连接拷贝
//                             [ShareSDK connectCopy];
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
//                  case SSDKPlatformTypeSinaWeibo:
//                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                              redirectUri:@"http://www.sharesdk.cn"
//                                                 authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeTencentWeibo:
//                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
//                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
//                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
//                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;

                  case SSDKPlatformTypeWechat:
//                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      [appInfo SSDKSetupWeChatByAppId:@"wxe90443adf5707c05"
                       appSecret:@"66771c773f3e625cc4b5335276dbc40f"];
                      
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"1104893462"
                                           appKey:@"RoEyUmLEHmqWGrlv"
                                         authType:SSDKAuthTypeBoth];
                      break;
//                  case SSDKPlatformTypeDouBan:
//                      [appInfo SSDKSetupDouBanByApiKey:@"02e2cbe5ca06de5908a863b15e149b0b"
//                                                secret:@"9f1e7b4f71304f2f"
//                                           redirectUri:@"http://www.sharesdk.cn"];
//                      break;
//                  case SSDKPlatformTypeRenren:
//                      [appInfo SSDKSetupRenRenByAppId:@"226427"
//                                               appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                            secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                             authType:SSDKAuthTypeBoth];
//                      break;
//                  case SSDKPlatformTypeKaixin:
//                      [appInfo SSDKSetupKaiXinByApiKey:@"358443394194887cee81ff5890870c7c"
//                                             secretKey:@"da32179d859c016169f66d90b6db2a23"
//                                           redirectUri:@"http://www.sharesdk.cn/"];
//                      break;

                  default:
                      break;
              }
          }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "------------.yz_student" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"yz_student" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"yz_student.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
