//
//  SwitchViewController.m
//  OBD
//
//  Created by Why on 16/3/29.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "SwitchViewController.h"
#import "SwitchOnewView.h"
#import "StatusTwoView.h"
#import "SwitchThreeView.h"
@interface SwitchViewController ()<SwitchOnewViewDelegate,SwitchThreeViewDelegate>
@property(nonatomic,strong)SwitchOnewView * switchOneView;
@property(nonatomic,strong)StatusTwoView * statusTwoView;
@property(nonatomic,strong)SwitchThreeView * statusThreeView;
@property(nonatomic,strong)UIView * blackBackView;
@end

@implementation SwitchViewController

{
    float _width;
    float _heigth;
    NSInteger  _lastSelectNum;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

     
    self.backImageView.image = [UIImage imageNamed:@"kaiguan_beijing"];
    [self orginalView];
    
    [[CurrentOBDModel sharedCurrentOBDModel]obdSwitchStatusChange:^(NSString *switchStatus)
     {
        if (switchStatus != nil)
        {
            NSLog(@"盒子状态 ========= %@",switchStatus);
            
            self.switchOneView.moveColorView.frame = CGRectMake(0, [self.switchOneView getCenterY:[CurrentOBDModel sharedCurrentOBDModel].switchStatusNum]-_width/2.0, _width, _width);
            [self switchStatusChangeWith:[CurrentOBDModel sharedCurrentOBDModel].switchStatusNum];
        }
    }];
    
}

- (void)orginalView
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 80);
    [btn setImage:[UIImage imageNamed:@"bizhi_fanhui"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.view addSubview:self.switchOneView];
    [self.view addSubview:self.statusTwoView];
    [self.view addSubview:self.statusThreeView];
    [self.view bringSubviewToFront:self.switchOneView];
    [self.view addSubview:self.blackBackView];
}

- (UIView*)blackBackView
{
    if (!_blackBackView)
    {
        _blackBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _blackBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    }
    return _blackBackView;
}
- (SwitchOnewView*)switchOneView{
    if (!_switchOneView) {
        _width = [WHYSizeManager getRelativelyWeight:107];
        _heigth = [WHYSizeManager getRelativelyHeight:333];
        _switchOneView = [[SwitchOnewView alloc]initWithFrame:CGRectMake((ScreenWidth-_width)/2.0, _width, _width, _heigth)];
        _switchOneView.delegate = self;
    }
    return _switchOneView;
}
- (StatusTwoView*)statusTwoView{
    if (!_statusTwoView) {
        _statusTwoView = [[StatusTwoView alloc]initWithFrame:CGRectMake(0, _switchOneView.frame.origin.y+_switchOneView.frame.size.height+[WHYSizeManager getRelativelyHeight:60], ScreenWidth, 40)];
                [self switchStatusChangeWith:_lastSelectNum];
    }
    return _statusTwoView;
}
- (SwitchThreeView*)statusThreeView{
    if (!_statusThreeView) {
        _statusThreeView = [[SwitchThreeView alloc]initWithFrame:CGRectMake(0, ScreenHeight-[WHYSizeManager getRelativelyHeight:200], ScreenWidth, [WHYSizeManager getRelativelyHeight:200])];
        _statusThreeView.hidden = YES;
        _statusThreeView.delegate = self;
        [self switchStatusChangeWith:_lastSelectNum];
    }
    return _statusThreeView;
}
- (void)switchStatusChangeWith:(NSInteger)statusNum{
    switch (statusNum) {
        case 0:
        {
            _statusThreeView.hidden = YES;
            _statusTwoView.hidden = NO;
            [_statusTwoView changeStatusWithSwitch:0];
        }
            break;
        case 1:
        {
            _statusThreeView.hidden = YES;
            _statusTwoView.hidden = NO;
            [_statusTwoView changeStatusWithSwitch:1];
        }
            break;
        case 2:
        {
            _statusThreeView.hidden = NO;
            _statusTwoView.hidden = YES;
        }
            break;
        default:
            break;
    }
    
}

#pragma mark --SwitchThreeViewDelegate--

- (void)bringToFont:(BOOL)yes
{
    if (yes) {
        [self.view bringSubviewToFront:self.switchOneView];
        [self.view bringSubviewToFront:self.blackBackView];
        self.blackBackView.frame = CGRectMake(0, 0, 0, 0);
    }else{
        [self.view bringSubviewToFront:self.statusThreeView];
        self.blackBackView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
    }
}

- (void)leftBarButtonItemClick{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
