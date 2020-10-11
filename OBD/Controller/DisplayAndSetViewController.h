//
//  DisplayAndSetViewController.h
//  OBD
//
//  Created by Why on 16/1/18.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayAndSetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *displayLable;
@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)containButtonClick:(UIButton *)sender;
@property (nonatomic,assign) BOOL isCheck;
@property (nonatomic,copy) NSString * titleStr;
@property (nonatomic,assign) NSInteger index;
@end
