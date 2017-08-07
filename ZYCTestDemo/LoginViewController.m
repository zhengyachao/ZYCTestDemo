//
//  LoginViewController.m
//  ZYCTestDemo
//
//  Created by ifreeplay on 2017/8/7.
//  Copyright © 2017年 ifreeplay. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录测试";
    [self createFBLoginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

/* 点击登录facebook */
- (void)_onLoginFaceBook:(UIButton *)button
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
