//
//  GalleryViewController.m
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import "GalleryViewController.h"
#import "ImageViewController.h"

static NSString * const stringURL1 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-1.jpg";
static NSString * const stringURL2 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-2.jpg";
static NSString * const stringURL3 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-3.jpg";
static NSString * const stringURL4 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-4.jpg";
static NSString * const stringURL5 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-5.jpg";
static NSString * const stringURL6 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-6.jpg";
static NSString * const stringURL7 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-7.jpg";
static NSString * const stringURL8 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-8.jpg";
static NSString * const stringURL9 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-9.jpg";
static NSString * const stringURL10 = @"https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-10.jpg";


@interface GalleryViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    NSUInteger _currentIndex;
}

@property (strong, nonatomic) NSMutableArray *imageURLsArray;

@end

@implementation GalleryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.imageURLsArray = [NSMutableArray arrayWithObjects:stringURL1, stringURL2, stringURL3, stringURL4, stringURL5, stringURL6, stringURL7, stringURL8, stringURL9, stringURL10, nil];
    
    ImageViewController *imageVC = [self viewControllerAtIndex:0];
    [self setViewControllers:@[imageVC]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:NULL];

}

#pragma mark - UIPageViewController delegate/dataSource

- (ImageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    ImageViewController *imageVC = [[ImageViewController alloc] initWithImageStringURL:self.imageURLsArray[index] pageIndex:index];
    return imageVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ImageViewController *)viewController pageIndex];
    _currentIndex = index + 1;
    
    if (index == 0)
        return nil;

    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ImageViewController *)viewController pageIndex];
    _currentIndex = index - 1;
    
    index++;
    
    if (index == self.imageURLsArray.count)
        return nil;
    
    return [self viewControllerAtIndex:index];
}


@end
