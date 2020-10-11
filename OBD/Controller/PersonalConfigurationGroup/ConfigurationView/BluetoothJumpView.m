//
//  BluetoothJumpView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/17.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "BluetoothJumpView.h"

@implementation BluetoothJumpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.0;
        self.clipsToBounds = YES;
        
        __weak __typeof__(self) weakSelf = self;

        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"跳过";
        lable.textColor = RGBA(187, 187, 187, 1);
        lable.font = [UIFont systemFontOfSize:14];
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableCellRight"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable.mas_centerY);
            make.right.mas_equalTo(-10);
        }];
        
        
        [self addSubview:self.jumpButton];
        [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        
        
    }
    
    return self;
}

- (UIButton *)jumpButton
{
    if (_jumpButton == nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpButton = button;
    }
    
    return _jumpButton;
}


@end
