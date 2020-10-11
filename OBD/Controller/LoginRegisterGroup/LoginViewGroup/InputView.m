//
//  InputView.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "InputView.h"
#import <Masonry.h>

@interface InputView()

{
    NSInteger _interval;
}


@property (nonatomic ,strong) NSTimer *timer;

@end


@implementation InputView

- (instancetype)initWithPlacterText:(NSString *)laceholder IsVerBtn:(BOOL)isVerBtn
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = RGBA(64, 64, 64, 1);
        self.clipsToBounds = YES;
        
        
        if (isVerBtn == NO)
        {
            
            _interval = 60;
            
            [self addSubview:self.textFiled];
            [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(0);
                 make.left.mas_equalTo(10);
                 make.bottom.mas_equalTo(0);
                 make.right.mas_equalTo(0);
             }];
        }
        else
        {
            [self addSubview:self.textFiled];
            [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(0);
                 make.left.mas_equalTo(10);
                 make.bottom.mas_equalTo(0);
             }];
            
            
            [self addSubview:self.verCodeButton];
            [self.verCodeButton mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(2);
                 make.bottom.mas_equalTo(-2);
                 make.right.mas_equalTo(-2);
                 make.width.equalTo(self.verCodeButton.mas_height).multipliedBy(1.0);
                 make.left.equalTo(self.textFiled.mas_right).with.offset(10);
             }];
        }
        

        
        
        
        
        self.textFiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:laceholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBA(239, 101, 82, 1)}];

    }
    
    return self;
}

- (UITextField *)textFiled
{
    if (_textFiled == nil)
    {
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.borderStyle = UITextBorderStyleNone;
        textFiled.textColor = RGBA(239, 101, 82, 1);
        textFiled.font = [UIFont systemFontOfSize:15];
        
        _textFiled = textFiled;
    }
    
    
    return _textFiled;
}

- (UIButton *)verCodeButton
{
    if (_verCodeButton == nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"获取" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        [button setBackgroundImage:[UIImage imageNamed:@"Login_VerCode"] forState:UIControlStateNormal];
        
        _verCodeButton = button;
    }
    
    return _verCodeButton;
}

- (NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendMessage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        _interval = 60;
    }
    return _timer;
}

- (void)sendMessage
{
    _interval --;
    NSString *title = [NSString stringWithFormat:@"%02ld",_interval];
    _verCodeButton.titleLabel.text = title;
    [_verCodeButton setTitle:title forState:UIControlStateDisabled];
    
    if (_interval == 0)
    {
        [self cancelSendVerCode];
    }
}


- (void)startSendVerCode
{
    [self timer];
    
    //不能连续点击
    _verCodeButton.enabled = NO;
}

// 取消发送验证码
- (void)cancelSendVerCode
{
    [_verCodeButton setTitle:@"发送" forState:UIControlStateDisabled];
    _interval = 60;
    _verCodeButton.enabled = YES;
    [self.timer invalidate];
}



@end
