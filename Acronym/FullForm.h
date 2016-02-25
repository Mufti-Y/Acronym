//
//  FullForm.h
//  Acronym
//
//  Created by Mufti Yafi on 2/25/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

/**
 @brief Holds full form for the searched acronym
 */

#import <Foundation/Foundation.h>

@interface FullForm : NSObject

@property (nonatomic, strong) NSString *longForm;
@property (nonatomic) NSInteger *frequency;

@end
