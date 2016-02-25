//
//  FullFormManager.h
//  Acronym
//
//  Created by Mufti Yafi on 2/25/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

/**
 @brief Handles API calls and parses full forms values for acronym searches
 */

#import <Foundation/Foundation.h>

@protocol FullFormManagerDelegate <NSObject>
@optional

/**
 This delegate methods provides an array of longForms for the search query
 */

-(void)newDataDidLoad:(NSArray *)longFormArray;

@end

@interface FullFormManager : NSObject

@property (nonatomic, weak) id <FullFormManagerDelegate> delegate;

/**
 Makes API call the query provided
 */

-(void)loadDataWithQuery:(NSString *)queryString;

@end
