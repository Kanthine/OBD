//
//  ErrorCodeViewController.m
//  OBD
//
//  Created by Why on 16/4/7.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "ErrorCodeViewController.h"
#import "ErrorcodeTableViewCell.h"
@interface ErrorCodeViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  没有故障码时显示的提示
 */
@property(nonatomic,strong)UILabel * informationLable;
@end

@implementation ErrorCodeViewController
{
    NSMutableArray * _dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:14 isCheck:YES newOrder:@""];//查询氧传感设置情况
    self.tishiLable.text = WHYGetStringWithKeyFromTable(@"CLEANERRORCODE", @"");
    _dataArray = [NSMutableArray array];
    self.backImageView.image = [UIImage imageNamed:@"kaiguan_beijing"];
    self.title = WHYGetStringWithKeyFromTable(@"ERRORCODECHECK", @"");
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topBackView.backgroundColor = RGBA(14, 11, 18, 0.6);
    [self.cleanButton setTitle:WHYGetStringWithKeyFromTable(@"CLEANONEKEY", @"") forState:UIControlStateNormal];
    self.cleanButton.layer.borderWidth = 6.0;
    self.cleanButton.clipsToBounds = YES;
    [self.view addSubview:self.informationLable];
    [[CurrentOBDModel sharedCurrentOBDModel]orderMangerErrorcodeChange:^(NSString *errorcode)
    {
        
        NSLog(@"错误码 =========== %@",errorcode);
        
        if (_dataArray.count>0) {
            [_dataArray removeAllObjects];
        }
        if (![errorcode isEqualToString:@"NULL"])
        {
            _dataArray = [NSMutableArray arrayWithArray:[errorcode componentsSeparatedByString:@"|"]];
            [self errorText];
            [_tableview reloadData];
        }
    }];
    [[CurrentOBDModel sharedCurrentOBDModel]orderManagerOxygenErrorChangeBlock:^(NSString *oxygenError) {
        if (oxygenError != nil) {
            if ([oxygenError isEqualToString:@"ON"]) {
                self.oxygenSwitch.on = YES;
            }else if ([oxygenError isEqualToString:@"OFF"]||[oxygenError isEqualToString:@"ERROR"]){
                self.oxygenSwitch.on = NO;
            }
        }
    }];
    [self errorText];
}
- (void)errorText
{
    if (_dataArray.count>0)
    {
        self.cleanButton.hidden = NO;
        self.informationLable.hidden = YES;
    }
    else
    {
        self.cleanButton.hidden = YES;
        self.informationLable.hidden = NO;
    }

}
- (UILabel*)informationLable{
    if (!_informationLable) {
        _informationLable = [[UILabel alloc]init];
        _informationLable.frame = CGRectMake(0, [WHYSizeManager getRelativelyHeight:270], ScreenWidth, 40);
//        _informationLable.bounds = CGRectMake(0, 0, ScreenWidth, 40);
        _informationLable.text = WHYGetStringWithKeyFromTable(@"DISCOVERERROR", @"");
        _informationLable.textColor = [UIColor whiteColor];
        _informationLable.font = [UIFont systemFontOfSize:14];
        _informationLable.numberOfLines = 0;
        _informationLable.textAlignment = NSTextAlignmentCenter;
        _informationLable.hidden = YES;
    }
    return _informationLable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ErrorcodeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"errorCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ErrorcodeTableViewCell" owner:self options:nil]firstObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.errorbutton setTitle:WHYGetStringWithKeyFromTable(@"COPY", @"") forState:UIControlStateNormal];
    }

    cell.errorbutton.tag = indexPath.row;
    [cell.errorbutton addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    NSString * errocde = _dataArray[indexPath.row];
    cell.errcodeLable.text = errocde;
    if (![errocde isEqualToString:WHYGetStringWithKeyFromTable(errocde, @"")]) {
        cell.errorcodeDetailLable.text = WHYGetStringWithKeyFromTable(errocde, @"");
        cell.errorbutton.hidden = YES;
    }else{
        cell.errorcodeDetailLable.text = WHYGetStringWithKeyFromTable(@"NOERROR", @"");
        cell.errorbutton.hidden = NO;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIFont * fnt = [UIFont systemFontOfSize:14];
    NSString * error = _dataArray[indexPath.row];
    CGRect tmpRect = [WHYGetStringWithKeyFromTable(error, @"") boundingRectWithSize:CGSizeMake(ScreenWidth-168, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height+60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cleanErrorCode:(UIButton *)sender {
    if (_dataArray.count>0) {
        /**
         *  清除故障码
         */
        [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:11 isCheck:NO newOrder:@""];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"正在清除故障码";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.2];
        [self performSelector:@selector(dissmissView) withObject:self afterDelay:1.2];
    }
}
- (void)copyButtonClick:(UIButton*)btn{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =  _dataArray[btn.tag];
}
- (void)dissmissView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)oxygenSwitch:(UISwitch *)sender {
    NSString * str = sender.on?@"ON":@"OFF";
    [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:15 isCheck:NO newOrder:str];//查询氧传感设置情况
}
@end
