//
//  StatusTwoView.h
//  OBD
//
//  Created by Why on 16/4/5.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusTwoView : UIView
@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel * tishiLable;

- (void)changeStatusWithSwitch:(NSInteger)status;
@end
