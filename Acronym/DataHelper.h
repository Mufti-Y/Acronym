//
//  DataHelper.h
//  Acronym
//
//  Created by Mufti Yafi on 2/25/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject

/**
 Makes Async Call
 */

-(void)asyncLoadFromURL:(NSURL *)url withSuccessBlock:(void (^)(id responseObject))success andFailureBlock:(void (^)(NSError *error))failure;


@end
