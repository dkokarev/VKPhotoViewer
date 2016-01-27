//
//  PhotoViewerViewController.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "AppViewController.h"

@class Photo;

@interface PhotoViewerViewController : AppViewController

- (instancetype)initWithPhoto:(Photo *)photo;

@end
