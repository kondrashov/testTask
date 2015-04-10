//
//  WebImageView.h
//  TestTask
//
//  Created by Mobisoft on 08.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebImageView : UIImageView

- (instancetype)initWithImageStringURL:(NSString *)imgStringURL;
- (void)loadImageWithStringURL:(NSString *)stringURL completion:(void(^)(BOOL isSuccess))completion;
- (void)loadImageWithCompletion:(void(^)(BOOL isSuccess))completion;
- (void)cancelRequest;

@end
