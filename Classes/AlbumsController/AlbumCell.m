//
//  AlbumCell.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "AlbumCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ApiManager.h"
#import "VKImageView.h"
#import "Album.h"

@interface AlbumCell ()

@property (nonatomic, weak) IBOutlet UILabel *mainLabel;
@property (nonatomic, weak) IBOutlet VKImageView *mainImageView;

@end

@implementation AlbumCell

- (void)prepareForReuse {
    self.mainLabel.text = nil;
    self.mainImageView.image = nil;
}

- (void)updateWithAlbum:(Album *)album {
    self.mainLabel.text = album.title;
    [self.mainImageView sd_setImageWithURL:album.thumbUrl];
}

@end
