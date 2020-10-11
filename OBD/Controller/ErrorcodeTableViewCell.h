//
//  ErrorcodeTableViewCell.h
//  OBD
//
//  Created by Why on 16/4/7.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorcodeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backBorderView;
@property (weak, nonatomic) IBOutlet UILabel *errcodeLable;
@property (weak, nonatomic) IBOutlet UILabel *errorcodeDetailLable;


@property (weak, nonatomic) IBOutlet UIButton *errorbutton;

@end
