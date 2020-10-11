//
//  CheckViewController.m
//  OBD
//
//  Created by Why on 16/3/29.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "CheckViewController.h"
#import "CheckTableViewCell.h"
#import "CheckDetailViewController.h"
@interface CheckViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation CheckViewController
{
    NSArray * _iconArray;
    NSArray * _titleArray;
    NSArray * _detailTitleArray;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backImageView.image = [UIImage imageNamed:@"kaiguan_beijing"];
    // Do any additional setup after loading the view.
    _titleArray = @[WHYGetStringWithKeyFromTable(@"DRIVETIME", @""),WHYGetStringWithKeyFromTable(@"JINGQIYALI", @""),WHYGetStringWithKeyFromTable(@"ENGINELOAD", @""),WHYGetStringWithKeyFromTable(@"JINQILIULIANG", @""),WHYGetStringWithKeyFromTable(@"FEATSOPENING", @""),WHYGetStringWithKeyFromTable(@"KONGRANBI", @""),WHYGetStringWithKeyFromTable(@"CARSPEED", @""),WHYGetStringWithKeyFromTable(@"OILLOSS", @""),WHYGetStringWithKeyFromTable(@"JINQIWENDU", @""),WHYGetStringWithKeyFromTable(@"AVERGEOILLOSS", @""),WHYGetStringWithKeyFromTable(@"DRIVEDISTANCE", @""),WHYGetStringWithKeyFromTable(@"AVERGESPEED", @""),WHYGetStringWithKeyFromTable(@"DAISUTIME", @"")];
    _iconArray = @[@"xingshishijian_2",@"jinqiyali",@"fadongjifuhe",@"jinqiliuliang_12",@"jieqimen",@"kongranbi",@"chesu_2",@"youhao_13",@"jinqiwendu",@"youhao_13",@"xingshilicheng_2",@"pingjunchesu_2",@"daisu"];
    _detailTitleArray = @[@"TEXTDRIVETIME",@"TEXTINTAKEPRESSURE"];
    self.title = WHYGetStringWithKeyFromTable(@"MESSAGE", @"");
    
    [self.view addSubview:self.tableView];
}
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _iconArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckTableViewCell * checkCell = [tableView dequeueReusableCellWithIdentifier:@"checkCell"];
    if (!checkCell) {
        checkCell = [[[NSBundle mainBundle]loadNibNamed:@"CheckTableViewCell" owner:self options:nil]firstObject];
    }
    checkCell.backgroundColor = RGBA(14, 11, 18, 0.3);
    checkCell.iconImageView.image = [UIImage imageNamed:_iconArray[indexPath.row]];
    checkCell.messageLable.text = _titleArray[indexPath.row];
    return checkCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CheckDetailViewController * check = [[CheckDetailViewController alloc]init];
    check.navBarGroundColor = RGBA(14, 11, 18, 0.46);
    check.navTitleColor = [UIColor whiteColor];
    check.index = indexPath.row;
    check.titleStr = _titleArray[indexPath.row];
    [self.navigationController pushViewController:check animated:YES];
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

@end
