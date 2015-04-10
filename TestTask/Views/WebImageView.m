//
//  WebImageView.m
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "WebImageView.h"
#import "ProgressView.h"
#import "DataRequest.h"
#import "UIImage+Additions.h"
#import <QuartzCore/QuartzCore.h>


@interface WebImageView ()

@property (strong, nonatomic) ProgressView *progressView;
@property (strong, nonatomic) DataRequest *dataRequest;
@property (strong, nonatomic) NSString *imageStringURL;

@end

@implementation WebImageView

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithImageStringURL:(NSString *)imgStringURL
{
    self = [super init];
    if(self)
    {
        self.imageStringURL = imgStringURL;
        [self setupView];
    }
    return self;
}

- (void)dealloc
{
    [self cancelRequest];
}

#pragma mark - Overriding

- (ProgressView *)progressView
{
    if(!_progressView)
        _progressView = [ProgressView new];
    
    return _progressView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.progressView.width = self.width - 30;
    self.progressView.height = 20;
    self.progressView.center = CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f);
    [self.progressView frameRoundToInt];
}

#pragma mark - Public methods

- (void)cancelRequest
{
    [self.dataRequest cancel];
}

- (void)loadImageWithStringURL:(NSString *)stringURL completion:(void(^)(BOOL isSuccess))completion
{
    [self.progressView setProgress:0];
    self.progressView.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    
    self.dataRequest = [DataRequest loadDataWithStringURL:stringURL progress:^(CGFloat progress)
     {
         [weakSelf.progressView setProgress:progress];
         
     } completion:^(NSData *data, BOOL fromCache, NSError *error)
     {
         if(!error && data.length > 0)
         {
             dispatch_queue_t dataQueee = dispatch_queue_create("dataQueee", 0);
             dispatch_async(dataQueee, ^{
                 
                 UIImage *image = [[UIImage imageWithData:data] imageWithLimitedSize];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{

                     CATransition *transition = [CATransition animation];
                     transition.duration = 0.3f;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     transition.type = kCATransitionFade;
                     [weakSelf.layer addAnimation:transition forKey:nil];

                     weakSelf.image = image;
                      weakSelf.progressView.hidden = YES;
                      completion(YES);
                 });
             });
             
         }
         else
             completion(NO);
         
     } cacheEnabled:YES];
}

- (void)loadImageWithCompletion:(void(^)(BOOL isSuccess))completion
{
    [self loadImageWithStringURL:self.imageStringURL completion:completion];
}

#pragma mark - Private methods

- (void)setupView
{
    if(self.progressView.superview != self)
        [self addSubview:self.progressView];
    
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFit;
}

@end
