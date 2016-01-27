//
//  NSError+Extensions.h
//  NoisyMap
//
//  Created by Danny Kokarev on 11.12.15.
//  Copyright © 2015 Mobitexoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AppErrorUnexpectedAlbumsResponseFormat = 1,
    AppErrorUnexpectedPhotosResponseFormat
} AppErrorCode;

@interface NSError (Extensions)

+ (id)errorWithAppErrorCode:(AppErrorCode)code;
- (AppErrorCode)appErrorCode;

@end
