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

@interface LoginViewController ()
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

@end
