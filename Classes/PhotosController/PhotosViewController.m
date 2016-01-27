//
//  PhotosViewController.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "PhotosViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "PhotoViewerViewController.h"
#import "PhotoCell.h"
#import "ApiManager.h"
#import "Album.h"

static CGFloat MinCellWidth = 78.0;
static CGFloat MinCellDistance = 2.0;

static NSString * const PhotoCellIdentifier = @"PhotoCell";

@interface PhotosViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) Album *album;
@property (nonatomic, assign) CGFloat cellWidth;

- (void)refresh;

@end

@implementation PhotosViewController

- (instancetype)initWithAlbum:(Album *)album {
    self = [super init];
    if (self) {
        _album = album;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.album.title;
    [self.collectionView registerNib:[UINib nibWithNibName:PhotoCellIdentifier bundle:nil] forCellWithReuseIdentifier:PhotoCellIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    [self refresh];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self calculateCellWidthForSize:self.collectionView.frame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self calculateCellWidthForSize:size];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    [self.collectionView reloadData];
}

- (void)refresh {
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [ApiManager getPhotosFromAlbum:self.album completionHandler:^(NSArray *photos, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            return;
        }
        weakSelf.photos = photos;
    }];
}

- (void)calculateCellWidthForSize:(CGSize)size {
    double numberOfItems;
    double fraction = modf((size.width + MinCellDistance)/(MinCellWidth + MinCellDistance), &numberOfItems);
    self.cellWidth = MinCellWidth + fraction*MinCellWidth/numberOfItems;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    [cell updateWithPhoto:self.photos[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.cellWidth, self.cellWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return MinCellDistance;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return MinCellDistance;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoViewerViewController *photoViewerController = [[PhotoViewerViewController alloc] initWithPhoto:self.photos[indexPath.row]];
    [self.navigationController pushViewController:photoViewerController animated:YES];
}

@end
