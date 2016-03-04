//
//  AppDelegate.m
//  VKPhotoViewer
//
//  Created by danny on 25.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "AppDelegate.h"
#import <VK-ios-sdk/VKSdk.h>
#import "UIAlertController+Utils.h"
#import "AlbumsViewController.h"
#import "LoginViewController.h"

@interface AppDelegate () <VKSdkDelegate>

@end

static NSString * const VK_APP_ID = @"5242493";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    VKSdk *vksdk = [VKSdk initializeWithAppId:VK_APP_ID];
    [vksdk registerDelegate:self];
    [VKSdk wakeUpSession:@[@"photos"] completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            [self showControllerWithClass:[AlbumsViewController class]];
        } else {
            [self showControllerWithClass:[LoginViewController class]];
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
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

- (void)showControllerWithClass:(Class)class {
    UIViewController *controller = [[class alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navController;
}

#pragma mark - VKSdkDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.error) {
        [UIAlertController presentWithMessage:result.error.localizedDescription inController:self.window.rootViewController];
        return;
    }
    [self showControllerWithClass:[AlbumsViewController class]];
}

- (void)vkSdkUserAuthorizationFailed {
    [UIAlertController presentWithMessage:@"Authorization failed" inController:self.window.rootViewController];
}

- (void)vkSdkAccessTokenUpdated:(VKAccessToken *)newToken oldToken:(VKAccessToken *)oldToken {
    if (!newToken && oldToken) {
        [self showControllerWithClass:[LoginViewController class]];
    }
}

@end
