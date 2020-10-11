//
//  SwitchPickerView.m
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "SwitchPickerView.h"
@interface SwitchPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIButton * cancelButton;
@property(nonatomic,strong)UIButton * certainButton;
@property(nonatomic,strong)UIView * backView;
@end
@implementation SwitchPickerView
{
    NSString * _selectStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {

        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    [self addSubview:self.backView];
    [self addSubview:self.pickerView];
}
- (UIPickerView*)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 46, ScreenWidth, self.frame.size.height-46)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 46)];
        _backView.backgroundColor = RGBA(244, 244, 244, 1);
        [_backView addSubview:self.cancelButton];
        [_backView addSubview:self.certainButton];
        [_backView addSubview:self.titleLable];
    }
    return _backView;
}
- (UILabel*)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(45, 15, ScreenWidth-90, 16)];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = [UIFont systemFontOfSize:14];
    }
    return _titleLable;
}
- (UIButton*)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(0, 0, 80, 45);
        [_cancelButton setTitle:WHYGetStringWithKeyFromTable(@"SWITCHCANCEL", @"") forState:UIControlStateNormal];
       // [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.tag = 1;
         [_cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIButton*)certainButton{
    if (!_certainButton) {
        _certainButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _certainButton.frame = CGRectMake(ScreenWidth-80, 0,80, 45);
        [_certainButton setTitle:WHYGetStringWithKeyFromTable(@"SWITCHCERTAIN", @"") forState:UIControlStateNormal];
        //[_certainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _certainButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _certainButton.tag = 2;
        [_certainButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certainButton;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectStr = self.dataArray[row];
}
- (void)buttonClick:(UIButton*)btn{
    if (btn.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(selectItem:status:textFiledNum:)]) {
            [self.delegate selectItem:@"" status:NO textFiledNum:self.textFiledNum];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(selectItem:status:textFiledNum:)]) {
            [self.delegate selectItem:_selectStr status:YES textFiledNum:self.textFiledNum];
        }
    }
    _selectStr = @"";
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 30;
}
- (CGSize)rowSizeForComponent:(NSInteger)component{
    return CGSizeMake(ScreenWidth, 30);
}
@end
