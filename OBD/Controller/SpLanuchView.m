//
//  SpLanuchView.m
//  SportJX
//
//  Created by Why on 16/3/26.
//  Copyright © 2016年 TianLinqiang. All rights reserved.
//

#import "SpLanuchView.h"
#import "PageControlView.h"
#define HIGHT self.bounds.origin.y
@interface SpLanuchView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIButton * startButton;
@property(nonatomic,strong)UIScrollView * lanuchScrollView;
@property (strong,nonatomic) PageControlView * pageControl;
@property(nonatomic,strong)UIView * backView;
@end
@implementation SpLanuchView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self addSubview:self.backView];
        [self addSubview:self.lanuchScrollView];
        [self setUpview];
        [self.lanuchScrollView addSubview:self.startButton];
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (void)setUpview
{
    NSArray * a = @[@"guide1.png",@"guide2.png",@"guide3.png"];

    for (int i = 0; i<3; i++)
    {
        UIImageView * bannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0+ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
        //bannerImageView.backgroundColor = [UIColor blueColor];
        bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        bannerImageView.image = [UIImage imageNamed:a[i]];

//        if(isiPhone4)
//        {
//        }else if(isiPhone5)
//        {
//            bannerImageView.image = [UIImage imageNamed:b[i]];
//        }else if(isiPhone6)
//        {
//            bannerImageView.image = [UIImage imageNamed:c[i]];
//        }else if(isiPhone6P)
//        {
//            bannerImageView.image = [UIImage imageNamed:d[i]];
//        }
        [self.lanuchScrollView addSubview:bannerImageView];
    }
}
- (UIView*)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        CAGradientLayer * grantLayer = [CAGradientLayer layer];
        grantLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        grantLayer.startPoint = CGPointMake(0, 0);
        grantLayer.endPoint = CGPointMake(1.0, 1.0);
        [_backView.layer insertSublayer:grantLayer atIndex:0];
    }
    return _backView;
}
- (PageControlView*)pageControl
{
    if (!_pageControl)
    {
        //
        _pageControl = [[PageControlView alloc]initWithFrame:CGRectMake(0,_startButton.frame.origin.y+_startButton.frame.size.height+[WHYSizeManager getRelativelyHeight:30], ScreenWidth, 10) pageCount:3 width:10];
    }
    return _pageControl;
}
- (UIScrollView*)lanuchScrollView
{
    if (!_lanuchScrollView) {
        _lanuchScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
       // _lanuchScrollView.backgroundColor = [UIColor redColor];
        _lanuchScrollView.contentSize = CGSizeMake(ScreenWidth*3, ScreenHeight);
        _lanuchScrollView.delegate = self;
        _lanuchScrollView.showsHorizontalScrollIndicator = NO;
        _lanuchScrollView.showsVerticalScrollIndicator = NO;
        _lanuchScrollView.pagingEnabled = YES;
        _lanuchScrollView.scrollEnabled = YES;
    }
    return _lanuchScrollView;
}
- (UIButton*)startButton{
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float width  = [WHYSizeManager getRelativelyWeight:115];
        float height = [WHYSizeManager getRelativelyWeight:38];
        _startButton.frame = CGRectMake((ScreenWidth-width)/2.0+ScreenWidth*2, ScreenHeight-height-[self getRelativelyHeight:75 orginHeight:667],width , height);
        _startButton.backgroundColor = [UIColor clearColor];
        _startButton.layer.cornerRadius = 6.0;
        _startButton.layer.borderWidth = 1.0;
        _startButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _startButton.clipsToBounds = YES;
        [_startButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (float)getRelativelyHeight:(float)originalHeight orginHeight:(float)height{
    return (originalHeight*ScreenHeight)/height;
}
- (float)getRelativelyWeight:(float)originalWeight width:(float)width{
    return (originalWeight*ScreenWidth)/width;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float num = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self.pageControl refreshPageCount:num];
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    float num = scrollView.contentOffset.x/ScreenWidth;
//    [self.pageControl refreshPageCount:num];
//}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float scorll = scrollView.contentOffset.x;
    if (scorll>ScreenWidth*2) {
        if ([self.delegate respondsToSelector:@selector(spLaunVctartButtonTouchEvent)]) {
            [self.delegate spLaunVctartButtonTouchEvent];
        }
    }

}
- (void)startButtonClick{
    if ([self.delegate respondsToSelector:@selector(spLaunVctartButtonTouchEvent)]) {
        [self.delegate spLaunVctartButtonTouchEvent];
    }
}
@end
