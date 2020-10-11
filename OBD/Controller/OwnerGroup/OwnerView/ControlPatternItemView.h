//
//  ControlPatternItemView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoxControlAutoModelConfiguration.h"


@class ControlPatternItemView;

@protocol ControlPatternItemViewDelegate <NSObject>

@required

- (void)configurationModelDataClick:(BoxControlAutoModelConfiguration *)configurationModel;

- (void)setDefaultPatternClick:(ControlPatternItemView *)itemView;

@end


@interface ControlPatternItemView : UIView


@property (nonatomic ,strong) BoxControlAutoModelConfiguration *configurationModel;
@property (nonatomic ,weak) id <ControlPatternItemViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame PatternType:(BoxControlAutoPattern)patternType;

@end
