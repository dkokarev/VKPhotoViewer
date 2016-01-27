//
//  LoginViewController.m
//  VKPhotoViewer
//
//  Created by danny on 25.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "LoginViewController.h"
#import <VK-ios-sdk/VKSdk.h>

@interface LoginViewController () <VKSdkUIDelegate>

- (IBAction)signInWithVk:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Login";
    [[VKSdk instance] setUiDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)signInWithVk:(id)sender {
    [VKSdk authorize:@[@"photos"]];
}

#pragma mark - VKSdkUIDelegate

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *captchaController = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [captchaController presentIn:self];
}

@end
