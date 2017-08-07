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
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"]
                 fromViewController:self
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
                 if (![[FBSDKAccessToken currentAccessToken].userID isEqualToString:_userID])
                 {
                     FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name" parameters:nil];
                     [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                     {
                         NSLog(@"result\n%@",result);
                         [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"FBresult"];
                         NSDictionary *FBresult = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBresult"];
                         NSLog(@"FBresult = %@",FBresult);
                         NSString *userID = result[@"id"];
                        
                         if (!error && [[FBSDKAccessToken currentAccessToken].userID isEqualToString:userID])
                         {
                             _userName = result[@"name"];
                             _userID = userID;
                             _userHeadUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",userID];
                             //具体参见：
                             //https://developers.facebook.com/docs/graph-api/reference/user/picture/
                             //type参数：small,normal,album,large,square
                         }
                     }];
                 
                 }
             }
         }
     }];
}
/* 点击退出Facebook */
- (void)_onLoginOutFaceBook:(UIButton *)button
{
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logOut];
}

@end
