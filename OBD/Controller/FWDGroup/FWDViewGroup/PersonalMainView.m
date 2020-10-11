//
//  PersonalMainView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define CellIdentifer @"UITableViewCell"

#import "PersonalMainView.h"
#import "AuthorizationManager.h"
#import "AccountInfo.h"
#import "UIImageView+WebCache.h"
#import "OBD-Swift.h"

#import "ErrorCodeViewController.h"
#import "SwitchViewController.h"

@interface PersonalMainView()
<UITableViewDelegate,UITableViewDataSource,SharePopViewDelegate>

{
    CGFloat _topHeight;
}

@property (nonatomic ,strong) UIButton *loginButton;
@property (nonatomic ,strong) UIView *tableHeaderView;
@property (nonatomic ,weak) UIViewController *viewController;
@property (nonatomic ,strong) NSArray<NSArray *> *dataArray;
@end

@implementation PersonalMainView

- (void)dealloc
{
    NSLog(@"PersonalMainView ------- 你被释放了嘛？");
}

- (instancetype)initWithFrame:(CGRect)frame Controller:(UIViewController *)viewController TopHeight:(CGFloat)topHeight
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGBA(232, 106, 90, 1);

        _topHeight = topHeight;
        self.viewController = viewController;
        
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.equalTo(self);
         }];
    }
    
    return self;
}

- (void)updateUserInfo
{
    UIImageView *portraitImageView = [self.tableHeaderView viewWithTag:1];
    UILabel *nameLable = [self.tableHeaderView viewWithTag:2];
    if ([AuthorizationManager isLoginState])
    {
        AccountInfo *account = [AccountInfo standardAccountInfo];
        [portraitImageView sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"appLogo"]];
        nameLable.text = account.nickname;
    }
    else
    {
        portraitImageView.image = [UIImage imageNamed:@"appLogo"];
        nameLable.text = @"请登录";
    }
}

- (NSArray<NSArray *> *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = @[@[@"我的消息",@"账号设置"],
                      @[@"故障码",@"控制器",@"切换品牌",@"控制盒匹配"],
                      @[@"分享iExhaust",@"关于我们"]];
    }
    
    return _dataArray;
}


- (UIView *)tableHeaderView
{
    if (_tableHeaderView == nil)
    {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame), _topHeight + 100)];
        
        UIImageView *portraitImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, _topHeight + 20, 60, 60)];
        portraitImageView.tag = 1;
        portraitImageView.layer.cornerRadius = 30;
        portraitImageView.clipsToBounds = YES;
        [headerView addSubview:portraitImageView];
        
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(portraitImageView.frame) + 10, CGRectGetMaxY(portraitImageView.frame) - 30 - 10, 100, 20)];
        nameLable.tag = 2;
        nameLable.font = [UIFont systemFontOfSize:15];
        nameLable.textColor = [UIColor whiteColor];
        [headerView addSubview:nameLable];
        
        
        
        self.loginButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(headerView.frame));
        [headerView addSubview:self.loginButton];
        
        
        
        if ([AuthorizationManager isLoginState])
        {
            AccountInfo *account = [AccountInfo standardAccountInfo];
            [portraitImageView sd_setImageWithURL:[NSURL URLWithString:account.headimg] placeholderImage:[UIImage imageNamed:@"appLogo"]];
            nameLable.text = account.nickname;
        }
        else
        {
            portraitImageView.image = [UIImage imageNamed:@"appLogo"];
            nameLable.text = @"请登录";
        }
        
        _tableHeaderView = headerView;
    }
    
    return _tableHeaderView;
}

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableHeaderView = self.tableHeaderView;
        tableView.rowHeight = 32;
        tableView.scrollEnabled = NO;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifer];

        _tableView = tableView;
    }
    
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = @"1";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([AuthorizationManager getUserBrandType] == UserProductTypeNone)
    {
        [self didSelectRowAtIndexPathFWDBrand:indexPath];
    }
    else if ([AuthorizationManager getUserBrandType] == UserProductTypeDefault)
    {
        [self didSelectRowAtIndexPathDefaultBrand:indexPath];
    }
    else if ([AuthorizationManager getUserBrandType] == UserProductTypeFWD)
    {
        [self didSelectRowAtIndexPathFWDBrand:indexPath];
    }

}


- (void)didSelectRowAtIndexPathDefaultBrand:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //我的消息
                    MessageListViewController *messageVC = [[MessageListViewController alloc]init];
                    [self.viewController.navigationController pushViewController:messageVC animated:YES];
                }
                    break;
                case 1:
                {
                    //账号设置
                    [self loginButtonClick];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //故障码数量大于0，则查询
                    if ([[CurrentOBDModel sharedCurrentOBDModel].errcodeNum integerValue]>0)
                    {
                        //查询故障码
                        [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:10 isCheck:YES newOrder:@""];
                    }
                    ErrorCodeViewController *errorCodeVC = [[ErrorCodeViewController alloc]init];
                    [self.viewController.navigationController pushViewController:errorCodeVC animated:YES];
                }
                    break;
                case 1:
                {
                    //控制器
                    //关于我们
                    SwitchViewController *controlVC = [[SwitchViewController alloc]init];
                    [self.viewController.navigationController pushViewController:controlVC animated:YES];
                }
                    break;
                case 2:
                {
                    //切换品牌
                    ProductTypeSetVC *productVC = [[ProductTypeSetVC alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:productVC];
                    nav.navigationBarHidden = YES;
                    
                    
                    [UIView transitionFromView:self.viewController.view toView:productVC.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished)
                     {
                         [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                     }];
                }
                    break;
                case 3:
                {
                    //控制盒匹配
                    ControlBoxSetVC *boxVC = [[ControlBoxSetVC alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:boxVC];
                    nav.navigationBarHidden = YES;
                    
                    [UIView transitionFromView:self.viewController.view toView:boxVC.view duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished)
                     {
                         [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                     }];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //分享iExhaust
                    SharePopView *shareView = [[SharePopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                    [self.viewController.view addSubview:shareView];
                    [shareView showMenuView];
                }
                    break;
                case 1:
                {
                    //关于我们
                    AboutViewController *aboutVC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
                    [self.viewController.navigationController pushViewController:aboutVC animated:YES];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }

}

- (void)didSelectRowAtIndexPathFWDBrand:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //我的消息
                    MessageListViewController *messageVC = [[MessageListViewController alloc]init];
                    [self.viewController.navigationController pushViewController:messageVC animated:YES];
                }
                    break;
                case 1:
                {
                    //账号设置
                    [self loginButtonClick];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //故障码数量大于0，则查询
                    if ([[CurrentOBDModel sharedCurrentOBDModel].errcodeNum integerValue]>0)
                    {
                        //查询故障码
                        [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:10 isCheck:YES newOrder:@""];
                    }
                    WrongCodeViewController *errorCodeVC = [[WrongCodeViewController alloc]init];
                    [self.viewController.navigationController pushViewController:errorCodeVC animated:YES];
                }
                    break;
                case 1:
                {
                    //控制器
                    ControlCenterViewController *controlVC = [[ControlCenterViewController alloc]init];
                    [self.viewController.navigationController pushViewController:controlVC animated:YES];
                }
                    break;
                case 2:
                {
                    //切换品牌
                    ProductTypeSetVC *productVC = [[ProductTypeSetVC alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:productVC];
                    nav.navigationBarHidden = YES;
                    
                    
                    [UIView transitionFromView:self.viewController.view toView:productVC.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished)
                     {
                         [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                     }];
                }
                    break;
                case 3:
                {
                    //控制盒匹配
                    ControlBoxSetVC *boxVC = [[ControlBoxSetVC alloc]init];
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:boxVC];
                    nav.navigationBarHidden = YES;
                    
                    [UIView transitionFromView:self.viewController.view toView:boxVC.view duration:1 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished)
                     {
                         [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                     }];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    //分享iExhaust
                    SharePopView *shareView = [[SharePopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                    [self.viewController.view addSubview:shareView];
                    [shareView showMenuView];
                }
                    break;
                case 1:
                {
                    //关于我们
                    AboutViewController *aboutVC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
                    [self.viewController.navigationController pushViewController:aboutVC animated:YES];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }

}

- (UIButton *)loginButton
{
    if (_loginButton == nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        _loginButton = button;
    }
    
    return _loginButton;
}

- (void)loginButtonClick
{
    if ([AuthorizationManager isLoginState])
    {
        //个人信息
        
        AccountSetViewController *accountVC = [[AccountSetViewController alloc]init];
        [self.viewController.navigationController pushViewController:accountVC animated:YES];
    }
    else
    {
        //登录界面
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        nav.navigationBarHidden = YES;
        
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        
    }
}


- (void)shareSelectedPlatformWithPlatformType:(UMSocialPlatformType)platformType
{
    if ([[UMSocialManager defaultManager] isInstall:platformType] == NO)
    {
        NSString *platName = @"";
        
        switch (platformType)
        {
            case UMSocialPlatformType_WechatSession:
            case UMSocialPlatformType_WechatTimeLine:
                platName = @"微信";
                break;
            case UMSocialPlatformType_Facebook:
                platName = @"Facebook";
                break;
            case UMSocialPlatformType_QQ:
            case UMSocialPlatformType_Qzone:
                platName = @"QQ";
                break;
            default:
                break;
        }
        
        NSString *string = [NSString stringWithFormat:@"您的手机没有安装%@",platName];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"分享失败" message:string preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}];
        
        [alertController addAction:cancelAction];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    
    NSString *detaileStr = @"iExhaust 汽车声浪掌控者";
    NSString *linkString = @"http://www.iexhaust.cn";
    UIImage *image = [UIImage imageNamed:@"appLogo"];
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = detaileStr;
    
    UMShareWebpageObject *shareURLObject = [UMShareWebpageObject shareObjectWithTitle:@"iExhaust" descr:detaileStr thumImage:image];
    shareURLObject.webpageUrl = linkString;
    messageObject.shareObject = shareURLObject;

    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.viewController completion:^(id data, NSError *error)
     {
         if (error)
         {
             NSLog(@"************Share fail with error %@*********",error);
         }
         else
         {
             NSLog(@"response data is %@",data);
         }
     }];
    
}


@end
