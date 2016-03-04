//
//  ApiManager.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "ApiManager.h"
#import <VK-ios-sdk/VKSdk.h>
#import <Mantle/Mantle.h>
#import "NSError+Extensions.h"
#import "Album.h"
#import "Photo.h"

@implementation ApiManager

+ (VKRequest *)getAlbums:(void(^)(NSArray *albums, NSError *error))handler {
    if (!handler) {
        return nil;
    }
    VKRequest *request = [VKRequest requestWithMethod:@"photos.getAlbums" parameters:@{VK_API_OWNER_ID:[[VKSdk accessToken] userId], @"need_covers":@1}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = response.json[@"items"];
        NSMutableArray *albums = [NSMutableArray array];
        for (NSDictionary *dictionary in items) {
            NSError *error;
            Album *album = [MTLJSONAdapter modelOfClass:Album.class fromJSONDictionary:dictionary error:&error];
            if (!error) {
                [albums addObject:album];
            }
        }
        handler([albums copy], nil);
    } errorBlock:^(NSError *error) {
        handler(nil, error);
    }];
    return request;
}

+ (VKRequest *)getPhotosFromAlbum:(Album *)album completionHandler:(void(^)(NSArray *photos, NSError *error))handler {
    if (!handler || !album) {
        return nil;
    }
    VKRequest *request = [VKRequest requestWithMethod:@"photos.get" parameters:@{@"owner_id":album.ownerId,
                                                                                 @"album_id":album.albumId,
                                                                                 @"photo_sizes":@1}];
    [request executeWithResultBlock:^(VKResponse *response) {
        NSArray *items = response.json[@"items"];
        NSMutableArray *photos = [NSMutableArray array];
        for (NSDictionary *dictionary in items) {
            NSError *error;
            Photo *photo = [MTLJSONAdapter modelOfClass:Photo.class fromJSONDictionary:dictionary error:&error];
            if (!error) {
                [photos addObject:photo];
            }
        }
        handler([photos copy], nil);
    } errorBlock:^(NSError *error) {
        handler(nil, error);
    }];
    return request;
}

@end
