//
//  Album.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Album : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *albumId;
@property (nonatomic, strong) NSNumber *ownerId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *albumDescription;
@property (nonatomic, strong) NSURL *thumbUrl;

@end
