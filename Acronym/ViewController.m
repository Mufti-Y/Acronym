//
//  ViewController.m
//  Acronym
//
//  Created by Mufti Yafi on 2/18/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

static NSString * const BaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

@interface ViewController () {
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSString *acronym;
@property (nonatomic, strong) NSArray *responseArray, *longFormArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //clears bottom rows
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
}

#pragma mark - UITableView Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellItem"];
        //cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (self.longFormArray) {
        cell.textLabel.text  = [[self.longFormArray objectAtIndex:indexPath.row] objectForKey:@"lf"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.responseArray) {
        self.longFormArray = [[self.responseArray firstObject] objectForKey:@"lfs"];
        return [self.longFormArray count];
    }
    
    return 0;
}

#pragma mark - UITextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.acronym = textField.text;
    [self.textField resignFirstResponder];
    [self loadData];
    
    return NO;
}


#pragma mark - Data Handling

-(void) loadData {
    //make the api call
    
    NSString *urlString = [NSString stringWithFormat:@"%@?sf=%@",BaseURLString,self.acronym];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [HUD showAnimated:YES];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Request Succeeded");
        [HUD hideAnimated:YES];
        self.responseArray = (NSArray *)responseObject;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed");
        [HUD hideAnimated:YES];
    }];
    
    [operation start];
    NSLog(@"Request URL: %@",urlString);
}

@end
