//
//  SwitchThreeView.m
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "SwitchThreeView.h"
#import "StatusTwoView.h"
#import "SwitchPickerView.h"
#define ZHUANSUFAZHI @"zhuansufazhi"
#define YANCHITIME @"yanchiTime"
@interface SwitchThreeView()<SwitchPickerViewDelegate>
@property(nonatomic,strong)StatusTwoView * statusTwoView;
@property(nonatomic,strong)UIButton * turnSpeedButton;
@property(nonatomic,strong)UIButton * turnOffTimeButton;
@property(nonatomic,strong)SwitchPickerView * switchPickerView;
@property(nonatomic,strong)UIView * blackBackView;
@end
@implementation SwitchThreeView
{
    NSArray * _titleStrArray;
    BOOL _yes;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    _titleStrArray = @[WHYGetStringWithKeyFromTable(@"SelectFazhi", @""),WHYGetStringWithKeyFromTable(@"CloseTime", @"")];
    [self addSubview:self.statusTwoView];
    UILabel * lable = [self getLable:CGRectMake(0,[WHYSizeManager getRelativelyHeight:135], 200, 15) titleStr:[NSString stringWithFormat:@"%@:",_titleStrArray[0]]];
    [self addSubview:lable];
    //
    [self addSubview:[self getLable:CGRectMake(0,[WHYSizeManager getRelativelyHeight:175], 200, 15) titleStr:[NSString stringWithFormat:@"%@:",_titleStrArray[1]]]];
    
    [self addSubview:self.turnSpeedButton];
    [self addSubview:self.turnOffTimeButton];
    [self addSubview:self.switchPickerView];
    [self bringSubviewToFront:self.switchPickerView];
    [[CurrentOBDModel sharedCurrentOBDModel]orderManagerTurnSpeedChange:^(NSString *checkTurnSpeed) {
        if (checkTurnSpeed != nil) {
            [_turnSpeedButton setTitle:checkTurnSpeed forState:UIControlStateNormal];
        }else{
            [_turnSpeedButton setTitle:@"3000" forState:UIControlStateNormal];
        }
    }];
    
    [[CurrentOBDModel sharedCurrentOBDModel]orderManagerDelayTimeChangeBlock:^(NSString *delayTime) {
        if (delayTime != nil) {
            [_turnOffTimeButton setTitle:delayTime forState:UIControlStateNormal];
        }else{
             [_turnOffTimeButton setTitle:@"3s" forState:UIControlStateNormal];
        }
    }];
}

- (SwitchPickerView*)switchPickerView{
    if (!_switchPickerView) {
        _switchPickerView = [[SwitchPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, ScreenWidth, self.frame.size.height)];
        _switchPickerView.delegate = self;
    }
    return _switchPickerView;
}
- (UIButton*)turnSpeedButton{
    if (!_turnSpeedButton) {
        _turnSpeedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _turnSpeedButton.frame = CGRectMake(208, [WHYSizeManager getRelativelyHeight:135], 80, 20);
        [_turnSpeedButton setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        [_turnSpeedButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -110)];
//        _turnSpeedButton.backgroundColor = [UIColor redColor];
        _turnSpeedButton.tag = 1;
        if ([CurrentOBDModel sharedCurrentOBDModel].checkTurnSpeed != nil) {
            [_turnSpeedButton setTitle:[CurrentOBDModel sharedCurrentOBDModel].checkTurnSpeed forState:UIControlStateNormal];
        }else{
            [_turnSpeedButton setTitle:@"3000" forState:UIControlStateNormal];
        }
//        if ([[NSUserDefaults standardUserDefaults]valueForKey:ZHUANSUFAZHI]) {
//        [_turnSpeedButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:ZHUANSUFAZHI] forState:UIControlStateNormal];
//        }else{
//            [_turnSpeedButton setTitle:@"3000" forState:UIControlStateNormal];
//        }
        [_turnSpeedButton setTitleColor:[UIColor colorConvertWithHexString:@"f7bf0c"] forState:UIControlStateNormal];
        _turnSpeedButton.titleLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:15];
        [_turnSpeedButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnSpeedButton;
}
- (UIButton*)turnOffTimeButton{
    if (!_turnOffTimeButton) {
        _turnOffTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _turnOffTimeButton.backgroundColor = [UIColor redColor];
        _turnOffTimeButton.frame = CGRectMake(208, [WHYSizeManager getRelativelyHeight:175], 80, 20);
        [_turnOffTimeButton setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        [_turnOffTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -68)];
        _turnOffTimeButton.tag = 2;
        if ([CurrentOBDModel sharedCurrentOBDModel].delayTime != nil) {
            [_turnOffTimeButton setTitle:[CurrentOBDModel sharedCurrentOBDModel].delayTime forState:UIControlStateNormal];
        }else{
            [_turnOffTimeButton setTitle:@"3" forState:UIControlStateNormal];
        }
        [_turnOffTimeButton setTitleColor:[UIColor colorConvertWithHexString:@"f7bf0c"] forState:UIControlStateNormal];
        _turnOffTimeButton.titleLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:15];
        [_turnOffTimeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnOffTimeButton;
}

- (UILabel*)getLable:(CGRect)frame titleStr:(NSString*)titleStr{
     UILabel * lable = [[UILabel alloc]initWithFrame:frame];
    lable.text = titleStr;
    lable.textAlignment = NSTextAlignmentRight;
    lable.font = [UIFont systemFontOfSize:15];
    lable.textColor = [UIColor colorConvertWithHexString:@"f7bf0c"];
    return lable;
}
- (StatusTwoView*)statusTwoView{
    if (!_statusTwoView) {
        _statusTwoView = [[StatusTwoView alloc]initWithFrame:CGRectMake(0, [WHYSizeManager getRelativelyHeight:80], ScreenWidth, 40)];
        [_statusTwoView changeStatusWithSwitch:2];
    }
    return _statusTwoView;
}

- (NSArray*)getArr:(NSInteger)status{
    NSArray * array;
    if (status == 0) {
        array = @[@"1000",@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000",@"5500",@"6000"];
    }else{
        array = @[@"1s",@"2s",@"3s",@"4s",@"5s",@"6s",@"7s",@"8s",@"9s",@"10s"];
    }
    return array;
}
#pragma mark --SwitchPickerViewDelegate--
- (void)selectItem:(NSString*)item status:(BOOL)select textFiledNum:(NSInteger)textFieldNum
{
    NSLog(@"item ============ %@",item);
    
    if (select&&item.length>0)
    {
        if (textFieldNum == 0)
        {
            // 设置转速阀值
            [CurrentOBDModel sharedCurrentOBDModel].checkTurnSpeed = item;
            [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:1 isCheck:NO newOrder:item];
        }
        else
        {
            [CurrentOBDModel sharedCurrentOBDModel].delayTime = item;
            [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:13 isCheck:NO newOrder:item];
        }
    }
    [UIView animateWithDuration:0.35 animations:^{
         self.switchPickerView.frame = CGRectMake(0, self.frame.size.height, ScreenWidth, self.frame.size.height);
    }];
    _yes = YES;
    [self performSelector:@selector(delegate:) withObject:nil afterDelay:0.45];
}
- (void)delegate:(BOOL)yes{
    if ([self.delegate respondsToSelector:@selector(bringToFont:)]) {
        [self.delegate bringToFont:_yes];
    }
}
#pragma mark --选择按钮点击事件--
- (void)buttonClick:(UIButton*)btn{

    [UIView animateWithDuration:0.35 animations:^{
        self.switchPickerView.frame = CGRectMake(0, 0, ScreenWidth, self.frame.size.height);
    }];
    _yes = NO;
    self.switchPickerView.titleLable.text = _titleStrArray[btn.tag-1];
    self.switchPickerView.textFiledNum = btn.tag-1;
    self.switchPickerView.dataArray = [self getArr:btn.tag-1];
    [self.switchPickerView.pickerView reloadAllComponents];
    [self performSelector:@selector(delegate:) withObject:nil afterDelay:0];
}
@end
