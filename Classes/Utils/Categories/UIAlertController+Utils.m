//
//  UIAlertController+Utils.m
//  VKFeed
//
//  Created by danny on 12.02.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "UIAlertController+Utils.h"

@implementation UIAlertController (Utils)

+ (instancetype)presentWithMessage:(NSString *)message inController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    void (^presentBlock)() = ^{
        [controller presentViewController:alert animated:YES completion:nil];
    };
    if ([NSThread isMainThread]) {
        presentBlock();
    } else {
        dispatch_async(dispatch_get_main_queue(), presentBlock);
    }
    return alert;
}

@end
