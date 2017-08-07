//
//  YKSDKManager.m
//  ZYCTestDemo
//
//  Created by ifreeplay on 2017/8/7.
//  Copyright © 2017年 ifreeplay. All rights reserved.
//

#import "YKSDKManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation YKSDKManager

+ (instancetype)shareManager
{
    static YKSDKManager *ykmanager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ykmanager = [[YKSDKManager alloc] init];
    });
    return ykmanager;
}

/* 初始化facebook */
- (void)initFaceBookSDKForApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

+ (void)activateApp {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [[FBSDKApplicationDelegate sharedInstance] application:application
                                                           openURL:url
                                                 sourceApplication:sourceApplication
                                                        annotation:annotation];
}

- (void)logInWithReadPermissions:(NSArray *)permissions
              fromViewController:(UIViewController *)fromViewController
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"]
                 fromViewController:fromViewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         NSLog(@"facebook login result.grantedPermissions = %@,error = %@",result.grantedPermissions,error);
         if (error)
         {
             NSLog(@"Process error");
         } else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
         } else
         {
             NSLog(@"Logged in");
             //获取用户id, 昵称，大头像
             if ([FBSDKAccessToken currentAccessToken])
             {
                 
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name" parameters:nil];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                  {
                      //                          NSLog(@"result\n%@",result);
                      [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"FBresult"];
                      NSDictionary *FBresult = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBresult"];
                      NSLog(@"FBresult = %@",FBresult);
                      NSString *userID = result[@"id"];
                      
                      if (!error && [[FBSDKAccessToken currentAccessToken].userID isEqualToString:userID])
                      {
                          NSString *userID = result[@"id"];
                          NSString *userName = result[@"name"];
                          NSLog(@"userId = %@, userName = %@",userID,userName);
                      }
                  }];
             }
         }
     }];
    
}

@end
