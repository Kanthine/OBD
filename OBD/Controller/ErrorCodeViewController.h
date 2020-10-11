//
//  ErrorCodeViewController.h
//  OBD
//
//  Created by Why on 16/4/7.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorCodeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
- (IBAction)cleanErrorCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *tishiLable;
@property (weak, nonatomic) IBOutlet UISwitch *oxygenSwitch;
- (IBAction)oxygenSwitch:(UISwitch *)sender;

@end
