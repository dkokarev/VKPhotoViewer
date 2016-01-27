//
//  ApiManager.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VKRequest;
@class Album;

@interface ApiManager : NSObject

+ (VKRequest *)getAlbums:(void(^)(NSArray *albums, NSError *error))handler;
+ (VKRequest *)getPhotosFromAlbum:(Album *)album completionHandler:(void(^)(NSArray *photos, NSError *error))handler;

@end
