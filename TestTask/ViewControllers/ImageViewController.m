//
//  ImageViewController.m
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "ImageViewController.h"
#import "WebImageView.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *zoomScrollView;
@property (strong, nonatomic) WebImageView *webImageView;
@property (strong, nonatomic) NSString *imageStringURL;

@end

@implementation ImageViewController

#pragma mark - Lifecycle

- (instancetype)initWithImageStringURL:(NSString *)imgStringURL pageIndex:(NSUInteger)index
{
    self = [super init];
    if(self)
    {
        self.imageStringURL = imgStringURL;
        self.pageIndex = index;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupView];
    [self loadImage];
}

#pragma mark - Public methods

- (void)loadImage
{
    [self.webImageView loadImageWithCompletion:^(BOOL isSuccess) {
    }];
}

#pragma mark - Private methods

- (void)setupView
{
    self.zoomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.zoomScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleHeight;
    self.zoomScrollView.delegate = self;
    self.zoomScrollView.bouncesZoom = NO;
    self.zoomScrollView.bounces = NO;
    [self.zoomScrollView setShowsVerticalScrollIndicator:NO];
    [self.zoomScrollView setShowsHorizontalScrollIndicator:NO];
    self.zoomScrollView.minimumZoomScale = 1.0f;
    self.zoomScrollView.maximumZoomScale = 10.0f;

    [self.view addSubview:self.zoomScrollView];
    
    self.webImageView = [[WebImageView alloc] initWithImageStringURL:self.imageStringURL];
    self.webImageView.frame = self.zoomScrollView.bounds;
    self.webImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webImageView.backgroundColor = [UIColor whiteColor];

    [self.zoomScrollView addSubview:self.webImageView];
}

#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.webImageView;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
