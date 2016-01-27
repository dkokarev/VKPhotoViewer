//
//  AlbumCell.h
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Album;

@interface AlbumCell : UITableViewCell

- (void)updateWithAlbum:(Album *)album;

@end
