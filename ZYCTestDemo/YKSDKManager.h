//
//  YKSDKManager.h
//  ZYCTestDemo
//
//  Created by ifreeplay on 2017/8/7.
//  Copyright © 2017年 ifreeplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YKSDKManager : NSObject

+ (instancetype)shareManager;

/* 初始化Facebook */
- (void)initFaceBookSDKForApplication:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/* 记录APP激活数据统计 */
+ (void)activateApp;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;
/* */
- (void)logInWithReadPermissions:(NSArray *)permissions
              fromViewController:(UIViewController *)fromViewController;
@end
