//
//  ControlPatternRightView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlPatternItemView.h"

@interface ControlPatternRightView : UIView

@property (nonatomic ,strong ,readonly) BoxControlAutoModelConfiguration *configurationModel;

- (instancetype)initWithConfigurationModel:(BoxControlAutoModelConfiguration *)configurationModel;


@end

