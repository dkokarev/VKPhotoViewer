//
//  PhotosViewController.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "AppViewController.h"

@class Album;

@interface PhotosViewController : AppViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (instancetype)initWithAlbum:(Album *)album;

@end
