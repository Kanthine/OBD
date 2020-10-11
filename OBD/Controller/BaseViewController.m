//
//  BaseViewController.m
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "BaseViewController.h"
#define WeakSafe(pram)  __weak typeof(self) pram = self
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self.view sendSubviewToBack:self.backImageView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}
- (void)setUpView{
    [self.view addSubview:self.backImageView];
    WeakSafe(weakSelf);
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UIImageView*)backImageView{//beijing
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageNamed:@"kaiguan_beijing"];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
        UIVisualEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * visulEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [_backImageView addSubview:visulEffectView];
    }
    return _backImageView;
}
#pragma mark --屏幕旋转--
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
