//
//  VKZoomImageView.m
//  VKPhotoViewer
//
//  Created by danny on 26.01.16.
//  Copyright © 2016 danny. All rights reserved.
//

#import "VKZoomImageView.h"
#import "VKImageView.h"

@interface VKZoomImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) VKImageView *imageView;
@property (nonatomic, strong) NSLayoutConstraint *imageTop;
@property (nonatomic, strong) NSLayoutConstraint *imageBottom;
@property (nonatomic, strong) NSLayoutConstraint *imageLeft;
@property (nonatomic, strong) NSLayoutConstraint *imageRight;

- (void)commonInit;

@end

@implementation VKZoomImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)]];
        _imageView = [[VKImageView alloc] init];
        [_imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_imageView];
        _imageTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        _imageBottom = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        _imageLeft = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        _imageRight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        [_scrollView addConstraints:@[_imageTop, _imageBottom, _imageLeft, _imageRight]];
        
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapGestureAction:)];
        singleTapGesture.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:singleTapGesture];
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureAction:)];
        doubleTapGesture.numberOfTapsRequired = 2;
        [_scrollView addGestureRecognizer:doubleTapGesture];
        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    }
}

- (void)dealloc {
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateZoom];
}

- (void)refreshConstraints {
    float imageWidth = self.imageView.image.size.width;
    float imageHeight = self.imageView.image.size.height;
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    float hPadding = (viewWidth - self.scrollView.zoomScale * imageWidth) / 2;
    if (hPadding < 0) {
        hPadding = 0;
    }
    float vPadding = (viewHeight - self.scrollView.zoomScale * imageHeight) / 2;
    if (vPadding < 0) {
        vPadding = 0;
    }
    self.imageLeft.constant = hPadding;
    self.imageRight.constant = hPadding;
    self.imageTop.constant = vPadding;
    self.imageBottom.constant = vPadding;
    [self layoutIfNeeded];
}

- (void)updateZoom {
    float minZoom = MIN(self.bounds.size.width / self.imageView.image.size.width,
                        self.bounds.size.height / self.imageView.image.size.height);
    if (minZoom > 1) {
        minZoom = 1;
    }
    self.scrollView.minimumZoomScale = minZoom;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    [self refreshConstraints];
}

- (void)oneTapGestureAction:(UITapGestureRecognizer *)gesture {
    if (self.singleTapHandler) {
        self.singleTapHandler();
    }
}

- (void)doubleTapGestureAction:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self.imageView];
    if (self.scrollView.zoomScale > self.scrollView.minimumZoomScale) {
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
        }];
    } else {
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1.0, 1.0) animated:YES];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        [self updateZoom];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshConstraints];
}

@end
