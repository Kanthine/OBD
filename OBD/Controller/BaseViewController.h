//
//  BaseViewController.h
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic,strong)UIColor * navBarGroundColor;
@property (nonatomic,strong)UIColor * navTitleColor;
@property(nonatomic,strong)UIImageView * backImageView;
@end
