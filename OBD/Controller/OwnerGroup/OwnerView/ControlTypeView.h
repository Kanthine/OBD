//
//  ControlTypeView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ControlType)
{
    ControlTypeOn = 0,
    ControlTypeOff,
    ControlTypeAuto
};

@interface ControlTypeView : UIView

@property (nonatomic ,assign) BOOL isSelected;
@property (nonatomic ,strong) UIButton *button;

- (instancetype)initWithFrame:(CGRect)frame Type:(ControlType)type;

@end
