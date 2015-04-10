//
//  UIImage+Additions.m
//  TestTask
//
//  Created by Mobisoft on 10.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage*)safeResizableImageWithCapInsets:(UIEdgeInsets)edgeInsets
                               resizingMode:(UIImageResizingMode)resizingMode
{
    if ([UIImage resolveInstanceMethod:@selector(resizableImageWithCapInsets:)])
        return [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    else
        return [self stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];
    
    return nil;
}

- (UIImage *)imageWithLimitedSize
{
    static CGSize sMaxSize = {1024, 1024};
    
    CGSize newSize = CGSizeMake(MIN(sMaxSize.width, self.size.width), MIN(sMaxSize.height, self.size.height));
    UIImage *result = [self scaledImageForSize:newSize];
    
    return result;
}

- (UIImage *)scaledImageForSize:(CGSize)maxSize
{
    // pick the target dimensions, as though applying
    // UIViewContentModeScaleAspectFit; seed some values first
    
    CGSize sizeOfImage = [self size];
    
    if (CGSizeEqualToSize(maxSize, sizeOfImage))
        return self;
    
    CGSize targetSize; // to store the output size
    
    // logic here: we're going to scale so as to apply some multiplier
    // to both the width and height of the input image. That multiplier
    // is either going to make the source width fill the output width or
    // it's going to make the source height fill the output height. Of the
    // two possibilities, we want the smaller one, since the larger will
    // make the other axis too large
    if(maxSize.width / sizeOfImage.width < maxSize.height / sizeOfImage.height)
    {
        // we'll letter box then; scaling width to fill width, since
        // that's the smaller scale of the two possibilities
        targetSize.width = maxSize.width;
        
        // height is the original height adjusted proportionally
        // to match the proportional adjustment in width
        targetSize.height =
        (maxSize.width / sizeOfImage.width) * sizeOfImage.height;
    }
    else
    {
        // basically the same as the above, except that we pillar box
        targetSize.height = maxSize.height;
        targetSize.width =
        (maxSize.height / sizeOfImage.height) * sizeOfImage.width;
    }
    
    // images can be integral sizes only, so round up
    // the target size and width, then construct a target
    // rect that centres the output image within that size;
    // this all ensures sub-pixel accuracy
    CGRect targetRect;
    
    // store the original target size and round up the original
    targetRect.size = targetSize;
    targetSize.width = ceilf(targetSize.width);
    targetSize.height = ceilf(targetSize.height);
    
    // work out how to centre the source image within the integral-sized
    // output image
    targetRect.origin.x = (targetSize.width - targetRect.size.width) * 0.5f;
    targetRect.origin.y = (targetSize.height - targetRect.size.height) * 0.5f;
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 1);
    [self drawInRect:targetRect];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

@end
