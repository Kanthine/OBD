//
//  PageOneViewController.m
//  OBD
//
//  Created by Why on 16/3/24.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "PageOneViewController.h"
#import "OneBottomView.h"
#import "ThreeItemView.h"
#import "FeastsOpeningView.h"
#import "CheckViewController.h"
#import "SwitchViewController.h"
#import "CarOneStatus.h"
#import "CarTwoStatus.h"
#import "CarThreeStatus.h"
#import "ErrorCodeViewController.h"
#import "WHYLanguageTool.h"

#import "PersonalMainView.h"

@interface PageOneViewController ()
<ThreeItemViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

{
    BOOL _leftViewShow;
}

@property (nonatomic ,strong) PersonalMainView *personalView;
@property (nonatomic ,strong) UIView *leftView;
@property (nonatomic ,strong) UIView *rightView;

@property(nonatomic,strong)OneBottomView * bottomView;
@property(nonatomic,strong)ThreeItemView * threeView;
@property(nonatomic,strong)FeastsOpeningView * feastsOpenView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UIView * pageOneView;//第一页
@property(nonatomic,strong)UIView * pageTwoView;//第二页
@property(nonatomic,strong)CarOneStatus * carOneView;
@property(nonatomic,strong)CarTwoStatus * carTwoView;
@property(nonatomic,strong)CarThreeStatus * carThreeView;
@end
static NSInteger _searchNum;
@implementation PageOneViewController

- (PersonalMainView *)personalView
{
    if (_personalView == nil)
    {
        _personalView = [[PersonalMainView alloc]initWithFrame:CGRectMake(0, 0, 160, ScreenHeight) Controller:self TopHeight:60];
        _personalView.backgroundColor = RGBA(51, 51, 51, 1);
    }
    
    return _personalView;
}

- (UIView *)leftView
{
    if (_leftView == nil)
    {
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        leftView.backgroundColor = [UIColor clearColor];
        
        
        _leftViewShow = NO;
        
        [leftView addSubview:self.personalView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FWD_Circle"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CGRectGetMaxX(self.personalView.frame), 0, 25, ScreenHeight);
        imageView.backgroundColor = [UIColor blackColor];
        [leftView addSubview:imageView];
        
        
        UIView *gestureView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.personalView.frame), 0, ScreenWidth - CGRectGetMaxX(self.personalView.frame), ScreenHeight)];
        gestureView.backgroundColor = [UIColor clearColor];
        [leftView addSubview:gestureView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
        [gestureView addGestureRecognizer:tapGesture];
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureClick:)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [gestureView addGestureRecognizer:swipeGesture];
        
        
        _leftView = leftView;
    }
    
    return _leftView;
}

- (UIView *)rightView
{
    if (_rightView == nil)
    {
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        
        [rightView addSubview:self.threeView];//头部三个按钮
        [rightView addSubview:self.scrollView];//下部分汽车数据
        
        _rightView = rightView;
    }
    
    return _rightView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGesture:)];
    // 指定左边缘滑动
    screenEdgePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePanGesture];

    
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.leftView];

    // 如果ges的手势与scrollView手势都识别的话,指定以下代码,代表是识别传入的手势
    [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:screenEdgePanGesture];
    
    [self addItemInScrollView];

    self.bottomView.drive_DistanceLable.text = @"0";
    self.bottomView.oil_ConsumptionLable.text = @"0";
    self.bottomView.averge_oilConsumptionLable.text = @"0";
    [OBDCentralMangerModel sharedOBDCentralMangerModel];
    
    [[CurrentOBDModel sharedCurrentOBDModel]obdSwitchStatusChange:^(NSString *switchStatus)
    {
        if (switchStatus != nil)
        {
            [self.threeView changeMiddleValue];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
    self.navigationController.delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = self;
    
    if (_leftViewShow)
    {
        [self recoverNormalAnimation];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:self.class] || [viewController isKindOfClass:[SwitchViewController class]])
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)addItemInScrollView
{
    [self.scrollView addSubview:self.pageOneView];
    [self.scrollView addSubview:self.pageTwoView];
}

#pragma mark  - GestureClick

- (void)swipeGestureClick:(UISwipeGestureRecognizer *)swipeGesture
{
    [self recoverNormalAnimation];
}

- (void)tapGestureClick:(UITapGestureRecognizer *)tapGesture
{
    [self recoverNormalAnimation];
}

//恢复原状
- (void)recoverNormalAnimation
{
    [UIView animateWithDuration:0.25 animations:^{
        self.leftView.frame = CGRectMake(-ScreenWidth, 0, ScreenWidth, ScreenHeight);
        self.rightView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
    _leftViewShow = NO;
}

//侧滑展示左视图
- (void)leftViewShowAnimation
{
    [UIView animateWithDuration:0.25 animations:^{
        self.leftView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.rightView.frame = CGRectMake(185, 0, ScreenWidth, ScreenHeight);
    }];
    _leftViewShow = YES;
}


- (void)screenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)screenEdgeGesture
{
    if (_leftViewShow == YES)
    {
        return;
    }
    
    // 让view跟着手指去移动
    // frame的x应该为多少??应该获取到手指的x值
    // 取到手势在当前控制器视图中识别的位置
    CGPoint point = [screenEdgeGesture locationInView:self.view];
    CGRect frame = self.leftView.frame;
    // 更改adView的x值. 手指的位置 - 屏幕宽度
    frame.origin.x = point.x - [UIScreen mainScreen].bounds.size.width;
    // 重新设置上去
    self.leftView.frame = frame;
    if (self.leftView.frame.origin.x + 185 > 0)
    {
        self.rightView.frame = CGRectMake(self.leftView.frame.origin.x + 185, 0, ScreenWidth, ScreenHeight);
    }
    
    
    if (screenEdgeGesture.state == UIGestureRecognizerStateEnded || screenEdgeGesture.state == UIGestureRecognizerStateCancelled)
    {
        [self leftViewShowAnimation];
//        // 判断当前广告视图在屏幕上显示是否超过一半
//        if (CGRectContainsPoint(self.view.frame, self.leftView.center))
//        {
//            // 如果超过,那么完全展示出来
//            [self leftViewShowAnimation];
//        }
//        else
//        {
//            // 如果没有,隐藏
//            [self recoverNormalAnimation];
//        }
    }
}

#pragma mark --UIScrollView--

- (UIScrollView*)scrollView
{
    if (_scrollView == nil)
    {
        float top = _threeView.frame.origin.y+_threeView.frame.size.height+12;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, top, ScreenWidth, ScreenHeight-top)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-top);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}
#pragma mark --固定的三个--
- (ThreeItemView*)threeView
{
    if (!_threeView)
    {
        _threeView = [[ThreeItemView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, [WHYSizeManager getRelativelyHeight:85])];
        _threeView.delegate = self;
    }
    return _threeView;
}
#pragma mark --第二界面--
- (UIView*)pageTwoView{
    if (!_pageTwoView) {
        
        _pageTwoView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView.frame.size.height)];
        [_pageTwoView addSubview:self.carOneView];
        [_pageTwoView addSubview:self.carTwoView];
        [_pageTwoView addSubview:self.carThreeView];
    }
    return _pageTwoView;
}

//平均车速、水温、转速
- (CarOneStatus*)carOneView{
    if (!_carOneView) {
        _carOneView = [[CarOneStatus alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [WHYSizeManager getRelativelyHeight:180])];
    }
    return _carOneView;
}

//空燃比、进气压力、进气流量、进气温度
- (CarTwoStatus*)carTwoView{
    if (!_carTwoView) {
        _carTwoView = [[CarTwoStatus alloc]initWithFrame:CGRectMake(0,_carOneView.frame.origin.y+_carOneView.frame.size.height, ScreenWidth, [WHYSizeManager getRelativelyHeight:180])];
    }
    return _carTwoView;
}

//平均车速、本次怠时、
- (CarThreeStatus*)carThreeView{
    if (!_carThreeView) {
        _carThreeView = [[CarThreeStatus alloc]initWithFrame:CGRectMake(25, _pageTwoView.frame.size.height-90, ScreenWidth-50, 90)];
    }
    return _carThreeView;
}

#pragma mark --第一界面--

- (UIView*)pageOneView
{
    if (_pageOneView == nil)
    {
        _pageOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _scrollView.frame.size.height)];
        [_pageOneView addSubview:self.topView];
        [_pageOneView addSubview:self.feastsOpenView];
        [_pageOneView addSubview:self.bottomView];
    }
    return _pageOneView;
}

- (OneTopView*)topView{
    if (!_topView) {
        _topView = [[OneTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, [WHYSizeManager getRelativelyHeight:200.0])];
       // _topView.backgroundColor = [UIColor orangeColor];
    }
    return _topView;
}
- (FeastsOpeningView*)feastsOpenView{
    if (!_feastsOpenView) {
        _feastsOpenView = [[FeastsOpeningView alloc]initWithFrame:CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height+12, ScreenWidth, [WHYSizeManager getRelativelyHeight:150.0])];
    }
    return _feastsOpenView;
}

//本次行驶里程、本次油耗量、平均油耗
- (OneBottomView*)bottomView{
    if (!_bottomView) {
        _bottomView = [[OneBottomView alloc]initWithFrame:CGRectMake(25, _pageOneView.frame.size.height-90, ScreenWidth-50, 90)];
    }
    return _bottomView;
}

- (void)trySearch
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:9 isCheck:YES newOrder:@""];
    });
}
#pragma mark --跳转到查询数据知识界面--
- (void)threeItemSelect:(NSInteger)index
{
    if (index == 0)
    {
        //黄色按钮的处理结果
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:WHYGetStringWithKeyFromTable(@"PEIDUI", @"") delegate:self cancelButtonTitle:WHYGetStringWithKeyFromTable(@"SWITCHCANCEL", @"") otherButtonTitles:WHYGetStringWithKeyFromTable(@"SWITCHCERTAIN", @""), nil];
        [alert show];

    }
    else if (index == 1)
    {
#pragma mark --查询延时时间--
        if ([CurrentOBDModel sharedCurrentOBDModel].boxID != nil&&![[CurrentOBDModel sharedCurrentOBDModel].boxID isEqualToString:@"NULL"]&&![[CurrentOBDModel sharedCurrentOBDModel].boxID isEqualToString:@"ERROR"])
        {
            [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:12 isCheck:YES newOrder:nil];
            
            SwitchViewController *switchVC = [[SwitchViewController alloc]init];
            [self.navigationController pushViewController:switchVC animated:YES];
        }
        else
        {
            Alert(WHYGetStringWithKeyFromTable(@"NOPEIDUI", @""));
            //Alert(NSLocalizedString(@"NOPEIDUI", @""));
        }
    
    }else if (index == 2){
        
        if ([[CurrentOBDModel sharedCurrentOBDModel].errcodeNum integerValue]>0) {
            /**
             *  查询故障码
             */
            [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:10 isCheck:YES newOrder:@""];
        }
            ErrorCodeViewController * vc = [[ErrorCodeViewController alloc]init];
            vc.navBarGroundColor = RGBA(14, 11, 18, 0.46);
            vc.navTitleColor = [UIColor whiteColor];
            [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark --UIScrollViewDelegate--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.contentOffset.x;

    if (pageWidth>=ScreenWidth) {
        [CurrentOBDModel sharedCurrentOBDModel].isNoFirstView = YES;
      //  NSLog(@"YES YES YES");
    }else{
        [CurrentOBDModel sharedCurrentOBDModel].isNoFirstView = NO;
        // NSLog(@"NO NO NO");
    }
}
#pragma mark --UIALertViewDelegate--
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1)
    {
        _searchNum = 0;
        [self trySearch];
        
        
        [[CurrentOBDModel sharedCurrentOBDModel] orderManagerGetBoxIdChangeBlock:^(NSString *boxID)
         {
            _searchNum++;
             
             NSLog(@"boxID ---------- %@",boxID);

             
            NSLog(@" ++++++++ %ld",(long)_searchNum);
            if ([boxID isEqualToString:@"ERROR"])
            {
                 Alert(WHYGetStringWithKeyFromTable(@"ERRORPEIDUI", @""));
            }
            else
            {
                Alert(WHYGetStringWithKeyFromTable(@"SUCCESSPEIDUI", @""));
            }
             
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
