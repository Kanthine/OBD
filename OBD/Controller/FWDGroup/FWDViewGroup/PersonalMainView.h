//
//  PersonalMainView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/5.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalMainView : UIView

@property (nonatomic ,strong) UITableView *tableView;

//@property (nonatomic ,copy) void(^ tableViewDidSelectClick)(NSIndexPath *indexPath);

- (instancetype)initWithFrame:(CGRect)frame Controller:(UIViewController *)viewController TopHeight:(CGFloat)topHeight;

- (void)updateUserInfo;

@end
