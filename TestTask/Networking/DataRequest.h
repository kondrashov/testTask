//
//  NetworkManager.h
//  TestTask
//
//  Created by Mobisoft on 04.04.15.
//  Copyright (c) 2015 ArtemK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ProgressBlock)(CGFloat progress);
typedef void (^CompletionBlock)(NSData *data, BOOL fromCache, NSError *error);

@interface DataRequest : NSObject

+ (instancetype)request;

+ (DataRequest *)loadDataWithStringURL:(NSString *)stringURL
                              progress:(ProgressBlock)progress
                            completion:(CompletionBlock)completion
                          cacheEnabled:(BOOL)cacheEnabled;

- (void)loadDataWithStringURL:(NSString *)stringURL
                     progress:(ProgressBlock)progress
                   completion:(CompletionBlock)completion
                 cacheEnabled:(BOOL)cacheEnabled;

- (void)cancel;

@end
