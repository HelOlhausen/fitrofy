//
//  FiltrofyRemoteDataLoader.m
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import "FiltrofyRemoteDataLoader.h"

@implementation FiltrofyRemoteDataLoader

-(instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSString *)URLString
{
    //MUST OVERRIDE
    return nil;
}

-(void)start {
    // TODO: import AFNetworking
    
    NSMutableURLRequest* request = [self.requestSerializer requestWithMethod: @"GET"
                                                                               URLString: [[NSURL URLWithString:requestURL relativeToURL:self.baseURL] absoluteString]
                                                                              parameters: self.commonRequestParameters
                                                                                   error: nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                                 completionHandler:^(NSURLResponse * __unused response,
                                                                     id responseObject, NSError *error) {
                                                     if (error) {
                                                         if (failure) {
                                                             failure(task, responseObject, error);
                                                         }
                                                     } else {
                                                         if (success) {
                                                             success(task, responseObject);
                                                         }
                                                     }
                                                 }];
    
    [task resume];
    
    self.task = task;
}

-(void)cancel {
    [self.task cancel];
}

@end
