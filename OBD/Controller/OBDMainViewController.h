//
//  OBDMainViewController.h
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OBDMainViewController : BaseViewController
+ (OBDMainViewController*)sharedOBDMainViewController;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * obdMessageArray;

- (void)reloadData;
@property (nonatomic,strong)OBDModel * nowModel;
@property(nonatomic,strong)UILabel * textLable;



@end
