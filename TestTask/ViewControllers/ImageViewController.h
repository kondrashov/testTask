//
//  ImageViewController.h
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

- (instancetype)initWithImageStringURL:(NSString *)imgStringURL pageIndex:(NSUInteger)index;
- (void)loadImage;

@property (assign, nonatomic) NSUInteger pageIndex;

@end
