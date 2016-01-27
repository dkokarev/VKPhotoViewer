//
//  AlbumsViewController.m
//  VKPhotoViewer
//
//  Created by danny on 25.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "AlbumsViewController.h"
#import <VK-ios-sdk/VKSdk.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "PhotosViewController.h"
#import "NSError+Extensions.h"
#import "ApiManager.h"
#import "AlbumCell.h"
#import "Album.h"

static NSString *AlbumCellIdentifier = @"AlbumCell";

@interface AlbumsViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *albums;

@end

@implementation AlbumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Albums";
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:AlbumCellIdentifier bundle:nil] forCellReuseIdentifier:AlbumCellIdentifier];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setAlbums:(NSArray *)albums {
    _albums = albums;
    [self.tableView reloadData];
}

- (void)refresh {
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [ApiManager getAlbums:^(NSArray *albums, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            return;
        }
        weakSelf.albums = albums;
    }];
}

- (void)signOut:(id)sender {
    [VKSdk forceLogout];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCell *cell = (AlbumCell *)[tableView dequeueReusableCellWithIdentifier:AlbumCellIdentifier];
    [cell updateWithAlbum:self.albums[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotosViewController *photosController = [[PhotosViewController alloc] initWithAlbum:self.albums[indexPath.row]];
    [self.navigationController pushViewController:photosController animated:YES];
}

@end
