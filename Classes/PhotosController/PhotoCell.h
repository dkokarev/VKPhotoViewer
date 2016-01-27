//
//  PhotoCell.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface PhotoCell : UICollectionViewCell

- (void)updateWithPhoto:(Photo *)photo;

@end
