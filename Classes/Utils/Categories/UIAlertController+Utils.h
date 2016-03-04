//
//  UIAlertController+Utils.h
//  VKFeed
//
//  Created by danny on 12.02.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Utils)

+ (instancetype)presentWithMessage:(NSString *)message inController:(UIViewController *)controller;

@end
