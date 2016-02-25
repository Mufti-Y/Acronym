//
//  FullFormManager.m
//  Acronym
//
//  Created by Mufti Yafi on 2/25/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

#import "FullFormManager.h"
#import "DataHelper.h"
#import "FullForm.h"

static NSString * const BaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@interface FullFormManager()

@property (nonatomic, strong) DataHelper *dataHelper;
@property (nonatomic, strong) FullForm *fullForm;
@property (nonatomic, strong) NSMutableArray *fullFormArray;
@property (nonatomic, strong) NSArray *responseArray;

@end

@implementation FullFormManager

-(instancetype)init{
    self = [super init];
    if (self) {
        //initialize
        self.fullForm = [[FullForm alloc] init];
        self.fullFormArray = [[NSMutableArray alloc] init];
        self.dataHelper = [[DataHelper alloc] init];
        self.responseArray = [[NSArray alloc] init];
    }
    return self;
}

-(void)loadDataWithQuery:(NSString *)queryString{
    if (queryString && ![queryString isEqualToString:@""]) {
        NSString *urlString = [NSString stringWithFormat:@"%@?sf=%@",BaseURLString,queryString];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.dataHelper asyncLoadFromURL:url withSuccessBlock:^(id responseObject) {

            if ((self.responseArray)) {
                for (int i=0; [self.responseArray count]; i++) {
                    //parse array into full form class
                    self.fullForm.longForm = [[[[self.responseArray firstObject] objectForKey:@"lfs"] objectAtIndex:i] objectForKey:@"lf"];
                    //add for frequency and other additional properties
                    [self.fullFormArray addObject:self.fullForm];
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(newDataDidLoad:)]) {
                [self.delegate newDataDidLoad:self.fullFormArray];
            }
            
        } andFailureBlock:^(NSError *error) {
            //
        }];
    }
}

@end
