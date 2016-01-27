//
//  VKZoomImageView.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VKImageView;

@interface VKZoomImageView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) VKImageView *imageView;
@property (nonatomic, copy) void(^singleTapHandler)();

@end
