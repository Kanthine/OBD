//
//  SwitchOnewView.m
//  OBD
//
//  Created by Why on 16/4/5.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "SwitchOnewView.h"
#define ON @"0"
#define OFF @"1"
#define AUTO @"2"

@interface SwitchOnewView()
@property(nonatomic,strong)UIView * bottomView;

@end
@implementation SwitchOnewView
{
    float _width;
    float _heigth;
    NSString * _switchStatus;
    NSArray * _selectImage;
    NSArray * _unSelectImage;
    NSArray * _titleArr;
    NSArray * _titleColorArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
       
        _titleColorArr = @[[UIColor colorConvertWithHexString:@"0af5fa"],[UIColor colorConvertWithHexString:@"e61c35"],[UIColor colorConvertWithHexString:@"f7bf0c"]];
        _titleArr = @[@"ON",@"OFF",@"AUTO"];
        _unSelectImage = @[@"kaiguan_on",@"kaiguan_off",@"kaiguan_auto"];
        _selectImage = @[@"kaiguan_on_bai",@"kaiguan_off_bai",@"kaiguan_auto_bai"];
        [self addSubview:self.backView];
        [self.backView addSubview:self.moveColorView];
        [self addView];
        [self delegateWithStatus:[CurrentOBDModel sharedCurrentOBDModel].switchStatusNum];
        
        
        
    }
    return self;
}
#pragma mark --添加图片和文字--
- (void)addView{
    for (int i = 0; i<3; i++) {
        float imageWidth = [WHYSizeManager getRelativelyWeight:23];
        float imageHeight = [WHYSizeManager getRelativelyWeight:24];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-imageHeight)/2.0, [WHYSizeManager getRelativelyHeight:33]+([WHYSizeManager getRelativelyHeight:100]+imageWidth)*i, imageWidth, imageHeight)];
        if (i != [CurrentOBDModel sharedCurrentOBDModel].switchStatusNum) {
            imageView.image = [UIImage imageNamed:_unSelectImage[i]];
        }else{
            imageView.image = [UIImage imageNamed:_selectImage[i]];
        }
        imageView.tag = i+5;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y+imageHeight+15, _width, 15)];
        lable.tag = i+10;
        lable.text = _titleArr[i];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentCenter;
        if (i != [CurrentOBDModel sharedCurrentOBDModel].switchStatusNum) {
            lable.textColor = _titleColorArr[i];
        }else{
            lable.textColor = [UIColor whiteColor];
        }
        
        [self.backView addSubview:lable];
        [self.backView addSubview:imageView];
    }
}
#pragma mark --背景--
- (UIView*)backView{
    if (!_backView) {
        _width = [WHYSizeManager getRelativelyWeight:107];
        _heigth = [WHYSizeManager getRelativelyHeight:333];
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _heigth)];
        _backView.backgroundColor = [UIColor colorConvertWithHexString:@"0a3747"];
        _backView.layer.cornerRadius = _width/2.0;
        _backView.clipsToBounds = YES;
    }
    return _backView;
}
#pragma mark --变颜色的移动图--
- (UIView*)moveColorView{
    if (!_moveColorView) {
        _moveColorView = [[UIView alloc]init];
        _moveColorView.frame = CGRectMake(0, [self getCenterY:[CurrentOBDModel sharedCurrentOBDModel].switchStatusNum]-_width/2.0, _width, _width);
        _moveColorView.layer.cornerRadius = _width/2.0;
        _moveColorView.clipsToBounds = YES;
        [_moveColorView.layer addSublayer:self.gradientLayer];
        UIPanGestureRecognizer * upRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureClick:)];
        [_moveColorView addGestureRecognizer:upRecognizer];
    }
    return _moveColorView;
}

- (float)getCenterY:(NSInteger)index{
    float centerY;
    switch (index) {
        case 0:
        {
            centerY = _width/2.0;
        }
            break;
        case 1:
        {
            centerY = _heigth/2.0;
        }
            break;
        case 2:
        {
            centerY = _heigth-_width/2.0;
        }
            break;
            
        default:
            break;
    }
    return centerY;
}
- (CAGradientLayer*)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.frame = CGRectMake(0, 0, _width, _width);
        _gradientLayer.colors = [self getColorArray:[CurrentOBDModel sharedCurrentOBDModel].switchStatusNum];
    }
    return _gradientLayer;
}
- (NSArray*)getColorArray:(NSInteger)index{
    NSArray * selectArr = nil;
    switch (index) {
        case 0:
        {
            selectArr = @[(__bridge id)[UIColor colorConvertWithHexString:@"009482"].CGColor,(__bridge id)[UIColor colorConvertWithHexString:@"035e7d"].CGColor];
        }
            break;
        case 1:
        {
            selectArr = @[(__bridge id)[UIColor colorConvertWithHexString:@"ed1f2b"].CGColor,(__bridge id)[UIColor colorConvertWithHexString:@"be1253"].CGColor];
        }
            break;
        case 2:
        {
            selectArr = @[(__bridge id)[UIColor colorConvertWithHexString:@"f7bf0c"].CGColor,(__bridge id)[UIColor colorConvertWithHexString:@"d4c503"].CGColor];
        }
            break;
        default:
            break;
    }
    return selectArr;
}
#pragma mark --拖动手势-
- (void)panGestureClick:(UIPanGestureRecognizer*)pan{
    CGPoint  point = [pan translationInView:_backView];
    CGPoint panCenter = CGPointMake(pan.view.center.x, pan.view.center.y+point.y);
    NSLog(@"%@",NSStringFromCGPoint(pan.view.center));
    pan.view.center = panCenter;
    [pan setTranslation:CGPointMake(0, 0) inView:_backView];
    if ([pan state] == UIGestureRecognizerStateEnded) {
        [self makePoint:panCenter];
    }
    
}
#pragma mark --拖动开关--
- (void)makePoint:(CGPoint)panCenter{
    NSInteger status;
    if (panCenter.y<[WHYSizeManager getRelativelyHeight:150]) {
        status = 0;
        _switchStatus = ON;
        [CurrentOBDModel sharedCurrentOBDModel].localSwitchStatus = @"MANON";
       
    }else if (panCenter.y>[WHYSizeManager getRelativelyHeight:220]){
        status = 2;
        _switchStatus = AUTO;
        [CurrentOBDModel sharedCurrentOBDModel].localSwitchStatus = @"AUTON";
    }else{
        status = 1;
         _switchStatus = OFF;
        [CurrentOBDModel sharedCurrentOBDModel].localSwitchStatus = @"MANOFF";
    }
    panCenter.y = [self getCenterY:status];
    _gradientLayer.colors = [self getColorArray:status];
    [self imageAndTitleChaneWithIndex:status];
    _moveColorView.center = panCenter;
    [self delegateWithStatus:status];
    /**
     *  控制盒子状态 
     */
    [[OBDOrderManager sharedOBDOrderManager]setOrderWithOrderIndex:3 isCheck:NO newOrder:[CurrentOBDModel sharedCurrentOBDModel].localSwitchStatus];
}
#pragma mark --换图片颜色和字体颜色--
- (void)imageAndTitleChaneWithIndex:(NSInteger)index{
    [CurrentOBDModel sharedCurrentOBDModel].switchStatusNum = index;
    for (id  obj in self.backView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = (UIImageView*)obj;
            if (imageView.tag-5 == index) {
                imageView.image = [UIImage imageNamed:_selectImage[imageView.tag-5]];
            }else{
                imageView.image = [UIImage imageNamed:_unSelectImage[imageView.tag-5]];
            }
        }
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel * lable = (UILabel*)obj;
            if (lable.tag-10 == index) {
                lable.textColor = [UIColor whiteColor];
            }else{
                lable.textColor = _titleColorArr[lable.tag-10];
            }
        }
    }
}

- (void)delegateWithStatus:(NSInteger)status{
    if ([self.delegate respondsToSelector:@selector(switchStatusChangeWith:)]) {
        [self.delegate switchStatusChangeWith:status];
    }
}
@end
