//
//  UIView+Additions.m
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGFloat) height
{
    return self.frame.size.height;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (CGFloat) x
{
    return self.frame.origin.x;
}

- (CGFloat) y
{
    return self.frame.origin.y;
}

- (CGFloat) centerY
{
    return self.center.y;
}

- (CGFloat) centerX
{
    return self.center.x;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)x
{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}

- (void)setCenterY:(CGFloat)y
{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}

- (void) setHeight:(CGFloat) newHeight
{
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (void) setWidth:(CGFloat) newWidth
{
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (void) setX:(CGFloat) newX
{
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (void) setY:(CGFloat) newY
{
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)rightX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setRightX:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottomY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottomY:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)frameRoundToInt
{
    self.frame = CGRectMake((int)(self.frame.origin.x + 0.5),
                            (int)(self.frame.origin.y + 0.5),
                            (int)(self.frame.size.width + 0.5),
                            (int)(self.frame.size.height +0.5));
}

- (instancetype)initWithNibNamed:(NSString *)nibNameOrNil
{
    if (!nibNameOrNil) {
        nibNameOrNil = NSStringFromClass([self class]);
    }
    NSArray *viewsInNib = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                                        owner:self
                                                      options:nil];
    for (id view in viewsInNib) {
        if ([view isKindOfClass:[self class]]) {
            self = view;
            break;
        }
    }
    return self;
}

- (UIView *)findFirstResponder
{
    if ([self isFirstResponder])
        return self;
    
    for (UIView * subView in self.subviews)
    {
        UIView * fr = [subView findFirstResponder];
        if (fr != nil)
            return fr;
    }
    return nil;
}

- (UIView *)makeContainerForView
{
    UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    return containerView;
}

@end
