//
//  LoginViewController.m
//  ZYCTestDemo
//
//  Created by ifreeplay on 2017/8/7.
//  Copyright © 2017年 ifreeplay. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "YKSDKManager.h"
#import <LineSDK/LineSDK.h>

@interface LoginViewController ()<LineSDKLoginDelegate>
{
    NSString *_userID;
    NSString *_userName;
    NSString *_userMail;
    NSString *_userHeadUrl;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createFBLoginButton];
    [self createFBLoginOutButton];
    [self createLineLoginButton];
    
    [LineSDKLogin sharedInstance].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 自定义Facebook登录按钮 */
- (void)createFBLoginButton
{
    UIButton *fbLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    fbLogin.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 44);
    fbLogin.backgroundColor = [UIColor lightGrayColor];
    [fbLogin setTitle:@"FaceBook登录" forState:UIControlStateNormal];
    [fbLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    fbLogin.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [fbLogin addTarget:self action:@selector(_onLoginFaceBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbLogin];
}
/* 自定义Facebook登出按钮 */
- (void)createFBLoginOutButton
{
    UIButton *fbLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    fbLogin.frame = CGRectMake(20, 84 + 64, self.view.frame.size.width - 40, 44);
    fbLogin.backgroundColor = [UIColor lightGrayColor];
    [fbLogin setTitle:@"退出FaceBook" forState:UIControlStateNormal];
    [fbLogin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    fbLogin.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [fbLogin addTarget:self action:@selector(_onLoginOutFaceBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbLogin];
}

/* 自定义Facebook登出按钮 */
- (void)createLineLoginButton
{
    UIButton *lineLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    lineLogin.frame = CGRectMake(20, 84 + 64 * 2, self.view.frame.size.width - 40, 44);
    lineLogin.backgroundColor = [UIColor lightGrayColor];
    [lineLogin setTitle:@"Line登录" forState:UIControlStateNormal];
    [lineLogin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    lineLogin.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [lineLogin addTarget:self action:@selector(_onLoginLine:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lineLogin];
}

/* 点击登录facebook */
- (void)_onLoginFaceBook:(UIButton *)button
{
    [[YKSDKManager shareManager] logInWithReadPermissions:@[@"public_profile"] fromViewController:self];
    
}

/* 点击退出Facebook */
- (void)_onLoginOutFaceBook:(UIButton *)button
{
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logOut];
}

/* 点击登录line */
- (void)_onLoginLine:(UIButton *)button
{
   [[LineSDKLogin sharedInstance] startLogin];
}

#pragma mark -- LineSDKLoginDelegate
- (void)didLogin:(LineSDKLogin *)login
      credential:(nullable LineSDKCredential *)credential
         profile:(nullable LineSDKProfile *)profile
           error:(nullable NSError *)error
{
    if (error) {
        // Login failed with an error. Use the error parameter to identify the problem.
        NSLog(@"Error: %@", error.localizedDescription);
    }
    else {
        
        // Login success. Extracts the access token, user profile ID, display name, status message, and profile picture.
        NSString * accessToken = credential.accessToken.accessToken;
        NSString * userID = profile.userID;
        NSString * displayName = profile.displayName;
        NSString * statusMessage = profile.statusMessage;
        NSURL * pictureURL = profile.pictureURL;
        
        NSString * pictureUrlString;
        
        // If the user does not have a profile picture set, pictureURL will be nil
        if (pictureURL) {
            pictureUrlString = profile.pictureURL.absoluteString;
        }
        NSLog(@"%@ %@ %@ %@ %@",accessToken,userID,displayName,statusMessage,pictureURL);
    }
}

@end
