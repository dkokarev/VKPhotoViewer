//
//  PhotoCell.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "PhotoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "VKImageView.h"
#import "Photo.h"

@interface PhotoCell ()

@property (nonatomic, weak) IBOutlet VKImageView *mainImageView;

@end

@implementation PhotoCell

- (void)prepareForReuse {
    self.mainImageView.image = nil;
}

- (void)updateWithPhoto:(Photo *)photo {
    [self.mainImageView sd_setImageWithURL:photo.thumbSize.url];
}

@end
