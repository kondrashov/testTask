//
//  UIView+Additions.h
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat rightX;
@property (nonatomic, assign) CGFloat bottomY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;

- (instancetype)initWithNibNamed:(NSString *)nibNameOrNil;
- (void)frameRoundToInt;
- (UIView *)findFirstResponder;
- (UIView *)makeContainerForView;

@end