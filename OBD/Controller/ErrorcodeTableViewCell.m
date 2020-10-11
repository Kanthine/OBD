//
//  ErrorcodeTableViewCell.m
//  OBD
//
//  Created by Why on 16/4/7.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "ErrorcodeTableViewCell.h"

@implementation ErrorcodeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    self.backBorderView.layer.cornerRadius = 6.0;
    self.backBorderView.clipsToBounds = YES;
    self.backBorderView.layer.borderWidth = 1.0f;
    self.backBorderView.layer.borderColor = [UIColor colorConvertWithHexString:@"a0a0a0"].CGColor;
//    self.errorbutton.layer.borderWidth = 1.0f;
//    self.errorbutton.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
