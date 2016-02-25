//
//  DataHelper.m
//  Acronym
//
//  Created by Mufti Yafi on 2/25/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

/**
 @brief This calss helps with making asyn calls.
 */

#import "DataHelper.h"
#import "AFNetworking.h"
#import "FullForm.h"

@implementation DataHelper

-(void)asyncLoadFromURL:(NSURL *)url withSuccessBlock:(void (^)(id responseObject))success andFailureBlock:(void (^)(NSError *error))failure{

        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Request Succeeded");
            success(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Request Failed");
            failure(error);
        }];
    
        [operation start];
        NSLog(@"Request URL: %@",[url description]);

}

@end
