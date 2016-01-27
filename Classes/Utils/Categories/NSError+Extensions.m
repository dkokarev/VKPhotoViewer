//
//  NSError+Extensions.m
//  NoisyMap
//
//  Created by Danny Kokarev on 11.12.15.
//  Copyright © 2015 Mobitexoft. All rights reserved.
//

#import <objc/runtime.h>
#import "NSError+Extensions.h"

NSString * const AppErrorDomain = @"com.danny.vkphotoviewer.errordomain";

@implementation NSError (Extensions)

+ (id)errorWithAppErrorCode:(AppErrorCode)code {
    return [[NSError alloc] initWithDomain:AppErrorDomain code:code userInfo:nil];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(localizedDescription);
        SEL swizzledSelector = @selector(errorLocalizedDescription);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (NSString *)errorLocalizedDescription {
    if ([self.domain isEqualToString:AppErrorDomain]) {
        switch (self.code) {
            case AppErrorUnexpectedAlbumsResponseFormat:
                return @"Unexpected albums response format";
                break;
            case AppErrorUnexpectedPhotosResponseFormat:
                return @"Unexpected photos response format";
                break;
        }
    }
    return [self errorLocalizedDescription];
}

- (AppErrorCode)appErrorCode {
    if ([AppErrorDomain isEqualToString:self.domain]) {
        return (AppErrorCode)self.code;
    }
    return -1;
}

@end
