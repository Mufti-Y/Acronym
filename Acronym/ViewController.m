//
//  ViewController.m
//  Acronym
//
//  Created by Mufti Yafi on 2/18/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "DataHelper.h"
#import "FullForm.h"

@interface ViewController () {
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSString *acronym;
@property (nonatomic, strong) NSArray *responseArray, *fullFormArray; //contains parsed array of fullForms
@property (nonatomic, strong) FullFormManager *fullFormManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; //clears bottom rows
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    self.fullFormManager = [[FullFormManager alloc] init];
    self.fullFormManager.delegate = self;
    
}

#pragma mark - UITableView Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellItem"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellItem"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (self.fullFormArray) {
        FullForm *fullForm = [[FullForm alloc] init];
        fullForm = [self.fullFormArray objectAtIndex:indexPath.row];
        cell.textLabel.text  = fullForm.longForm;
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.fullFormArray) {
        return [self.fullFormArray count];
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
    
    [HUD showAnimated:YES];
    [self.fullFormManager loadDataWithQuery:self.acronym];
}

#pragma mark - FullFormManagerDelegate Methods

-(void)newDataDidLoad:(NSArray *)longFormArray {
    self.fullFormArray = [longFormArray copy];
    [HUD hideAnimated:YES];
    [self.tableView reloadData];
}

-(void)newDataFailedToLoad:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Unable to fetch data from the server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [HUD hideAnimated:YES];
    [alert show];
}

@end
