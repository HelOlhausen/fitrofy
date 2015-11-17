//
//  FiltrofyRemoteDataLoader.h
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FiltrofyRemoteDataLoader : NSObject

typedef void (^FiltrofyRemoteDataLoaderHandler)(NSURLSessionDataTask *__strong, id __strong, NSError * __strong);

@property (nonatomic, strong) NSURLSessionDataTask * task;
@property (nonatomic, strong) NSString * URLString;
@property (nonatomic, strong) FiltrofyRemoteDataLoaderHandler handler;

-(void)start;
-(void)cancel;

@end
