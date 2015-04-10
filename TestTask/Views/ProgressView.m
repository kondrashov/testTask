//
//  ProgressView.m
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "ProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface ProgressView ()
{
    CGFloat _progress;
    CGFloat _fillWidth;
    CGFloat _fillStep;
}

@property (strong, nonatomic) UIView *fillView;

@end

@implementation ProgressView

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

#pragma mark - Overriding

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _fillStep = self.width / 100;
    _fillWidth = _progress * _fillStep;
    [self refreshView];
}

- (UIView *)fillView
{
    if(!_fillView)
        _fillView = [UIView new];

    return _fillView;
}

#pragma mark - Private methods

- (void)setupView
{
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.backgroundColor = [UIColor whiteColor];
    self.fillView.backgroundColor = [UIColor lightGrayColor];
    
    if(self.fillView.superview != self)
        [self addSubview:self.fillView];
}

- (void)refreshView
{
    self.fillView.frame = CGRectMake(0, 0, _fillWidth, self.height);
}

#pragma mark - Public methods

- (void)setProgress:(CGFloat)progress
{
    if(_progress != progress)
        _progress = progress;
    
    _fillWidth = _progress * _fillStep;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self refreshView];
    }];
}


@end
