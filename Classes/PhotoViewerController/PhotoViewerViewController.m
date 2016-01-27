//
//  PhotoViewerViewController.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "VKZoomImageView.h"
#import "VKImageView.h"
#import "Photo.h"

@interface PhotoViewerViewController ()

@property (nonatomic, weak) IBOutlet VKZoomImageView *zoomImageView;
@property (nonatomic, strong) Photo *photo;

@end

@implementation PhotoViewerViewController

- (instancetype)initWithPhoto:(Photo *)photo {
    self = [super init];
    if (self) {
        _photo = photo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Photo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.zoomImageView.imageView sd_setImageWithURL:self.photo.fullSize.url];
    __weak typeof(self) weakSelf = self;
    [self.zoomImageView setSingleTapHandler:^{
        [[UIApplication sharedApplication] setStatusBarHidden:!weakSelf.navigationController.navigationBarHidden withAnimation:weakSelf.navigationController.navigationBarHidden?UIStatusBarAnimationFade:UIStatusBarAnimationNone];
        [weakSelf.navigationController setNavigationBarHidden:!weakSelf.navigationController.navigationBarHidden animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
