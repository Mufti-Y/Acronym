//
//  ViewController.h
//  Acronym
//
//  Created by Mufti Yafi on 2/18/16.
//  Copyright (c) 2016 Mufti Yafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

