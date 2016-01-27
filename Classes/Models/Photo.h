//
//  Photo.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface PhotoSize : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@interface Photo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *sizes;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong, readonly) PhotoSize *thumbSize;
@property (nonatomic, strong, readonly) PhotoSize *fullSize;

@end
