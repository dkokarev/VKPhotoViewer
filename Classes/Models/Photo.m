//
//  Photo.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "Photo.h"

static NSString * const PhotoSizeSourceKey = @"src";
static NSString * const PhotoSizeWidthKey = @"width";
static NSString * const PhotoSizeHeightKey = @"height";

@implementation PhotoSize

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"url":PhotoSizeSourceKey,
             @"width":PhotoSizeWidthKey,
             @"height":PhotoSizeHeightKey,
             };
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end

static NSString * const PhotoIdKey = @"id";
static NSString * const PhotoTextKey = @"text";
static NSString * const PhotoWidthKey = @"width";
static NSString * const PhotoHeightKey = @"height";
static NSString * const PhotoSizesKey = @"sizes";

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"width" ascending:YES];
        _sizes = [_sizes sortedArrayUsingDescriptors:@[sortDescriptor]];
        _thumbSize = _sizes.firstObject;
        _fullSize = _sizes.lastObject;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"photoId":PhotoIdKey,
             @"text":PhotoTextKey,
             @"width":PhotoWidthKey,
             @"height":PhotoHeightKey,
             @"sizes":PhotoSizesKey
             };
}

+ (NSValueTransformer *)sizesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:PhotoSize.class];
}

@end
