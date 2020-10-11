//
//  SetAndCheckViewController.m
//  OBD
//
//  Created by Why on 16/1/18.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "SetAndCheckViewController.h"
#import "DisplayAndSetViewController.h"
@interface SetAndCheckViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SetAndCheckViewController
{
    NSArray * optionsTitleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    //[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view addSubview:self.tableView];
    optionsTitleArray = @[@"查询转速阀值",@"设置转速阀",@"查询盒子状态",@"控制盒子状态",@"查询数据流设置状态",@"设置数据流开关",@"查询数据流间隔",@"设置数据流间隔",@"读取已配对盒子ID",@"获取当前配对成功的ID",@"读取故障码",@"清除故障码"];
    //,@"OBD 连接成功提示",@"OBD 断线提示"
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackClick)];
}
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)goBackClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return optionsTitleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * indentifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    cell.textLabel.text = optionsTitleArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * str = optionsTitleArray[indexPath.row];
    DisplayAndSetViewController * vc = [[DisplayAndSetViewController alloc]init];
    if ([str hasPrefix:@"查询"]||[str hasPrefix:@"获取"]||[str hasPrefix:@"读取"]) {
        vc.isCheck = YES;
    }
    vc.index = indexPath.row;
    vc.titleStr = str;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return NO;
}

@end
