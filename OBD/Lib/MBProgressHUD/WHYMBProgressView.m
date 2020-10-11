//
//  WHYMBProgressView.m
//  AnimationText 16-2-22
//
//  Created by Why on 16/2/23.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "WHYMBProgressView.h"
#define IPHONE5Weight 320
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
@interface WHYMBProgressView()
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UILabel * tishiLable;
@end

@implementation WHYMBProgressView
{
    NSMutableArray * _imageArray;//图片数组
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+ (WHYMB_INSTANCETYPE)whyShowHUDAddedTo:(UIView*)view{
    CGRect rect = view.frame;
    rect.size.width = ScreenWidth;
    rect.size.height = ScreenHeight;
    view.frame = rect;
    NSLog(@"%@",NSStringFromCGRect(view.frame));
    WHYMBProgressView * hub = [[self alloc]initWithView:view];
    BOOL isFound = NO;
    
    for (UIView *aView in view.subviews) {
        if ([aView isKindOfClass:self]) {
            isFound = YES;
        }
    }
    if (!isFound&&view!=nil) {
        
        [view addSubview:hub];
    }
    return hub;
}
- (id)initWithView:(UIView*)view{
    return [self initWithFrame:view.bounds];
}
- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray array];
        //[imageArr addObject:[UIImage imageNamed:@"Loading_00051"]];
        for (int i = 0; i<39; i++) {
            UIImage * image =[UIImage imageNamed:[NSString stringWithFormat:@"Loading_000%d",i+15]];
            [_imageArray addObject:image];
        }
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [self addSubview:self.backView];
        [self.backView addSubview:self.imageView];
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.backView addSubview:self.tishiLable];
//        });
        
        [_imageView startAnimating];
    }
    return self;
}
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        float width = [WHYSizeManager getRelativelyWeight:31];
        float height = [WHYSizeManager getRelativelyWeight:25];
        _imageView.frame = CGRectMake((_backView.frame.size.width-width)/2.0, [WHYSizeManager getRelativelyWeight:10], width, height);
        // _imageView.center = _backView.center;
        // _imageView.bounds = CGRectMake(0, 0, [self getRelativelyWeight:62], [self getRelativelyWeight:50]);
        _imageView.animationImages = [NSArray arrayWithArray:_imageArray];
        _imageView.animationDuration = 1.6;
    }
    return _imageView;
}

- (UIView*)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.center = self.center;
        _backView.bounds = CGRectMake(0, 0, [WHYSizeManager getRelativelyWeight:120], [WHYSizeManager getRelativelyWeight:70]);
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 6.0;
        _backView.clipsToBounds = YES;
    }
    return _backView;
}
- (UILabel*)tishiLable{
    if (!_tishiLable) {
        _tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _backView.frame.size.height-[WHYSizeManager getRelativelyWeight:25], _backView.frame.size.width, [WHYSizeManager getRelativelyWeight:15])];
        _tishiLable.font = [UIFont systemFontOfSize:11];
        _tishiLable.text = @"主人,小的正在加载...";
        _tishiLable.textAlignment = NSTextAlignmentCenter;
        _tishiLable.textColor = [UIColor colorWithRed:243.0 / 255.0 green:82.0 / 255.0 blue:15.0 / 255.0 alpha:1];
    }
    return _tishiLable;
}
+ (void)whyHideHUDForView:(UIView*)view{
//    dispatch_async(dispatch_get_main_queue(), ^{
        WHYMBProgressView * hub = [self HUDForView:view];
        if (hub != nil) {
            [hub hideUsingAnimation];
        }
//    });
}
- (void)hideUsingAnimation{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    // 0.02 prevents the hud from passing through touches during the animation the hud will get completely hidden
    // in the done method
    self.alpha = 0.02f;
    [UIView commitAnimations];
}
- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void*)context {
    [self done];
}
- (void)done {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.alpha = 0.0f;
    [self removeFromSuperview];
}
+ (WHYMB_INSTANCETYPE)HUDForView:(UIView*)view{
    NSEnumerator * subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView * subView in subviewsEnum) {
        if ([subView isKindOfClass:self]) {
            return (WHYMBProgressView*)subView;
        }
    }
    return nil;
}
@end
