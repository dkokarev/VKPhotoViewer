//
//  Album.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "Album.h"

static NSString * const AlbumIdKey = @"id";
static NSString * const AlbumOwnerId = @"owner_id";
static NSString * const AlbumTitleKey = @"title";
static NSString * const AlbumDescriptionKey = @"description";
static NSString * const AlbumThumbSourceKey = @"thumb_src";

@implementation Album

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"albumId":AlbumIdKey,
             @"ownerId":AlbumOwnerId,
             @"title":AlbumTitleKey,
             @"albumDescription":AlbumDescriptionKey,
             @"thumbUrl":AlbumThumbSourceKey,
             };
}

+ (NSValueTransformer *)thumbUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
