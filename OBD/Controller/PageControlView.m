//
//  PageControlView.m
//  SportJX
//
//  Created by Why on 16/3/26.
//  Copyright © 2016年 TianLinqiang. All rights reserved.
//

#import "PageControlView.h"
@implementation PageControlView
{
    float _totalWidth;
    float _pageCount;
    float _pageWidth;
    UIView * _backView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)count width:(float)width{
    if (self == [super initWithFrame:frame]) {
        _pageWidth = width;
        _pageCount = count;
        _totalWidth = width*count+(count-1)*10;
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    _backView = [[UIView alloc]init];
    _backView.frame = CGRectMake((ScreenWidth-_totalWidth)/2.0, 0, _totalWidth, _pageWidth);
    [self addSubview:_backView];
    for (int i = 0; i<_pageCount; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0+(_pageWidth+10)*i, 0, _pageWidth, _pageWidth)];
        imageView.layer.cornerRadius = _pageWidth/2.0;
        imageView.clipsToBounds = YES;
        if (i==0) {
             imageView.backgroundColor = [UIColor colorConvertWithHexString:@"d2a413"];
        }else{
             imageView.backgroundColor = [UIColor colorConvertWithHexString:@"727172"];
        }
        imageView.tag = i+10;
        [_backView addSubview:imageView];
    }
}

- (void)refreshPageCount:(NSInteger)count{
    for (id obj in _backView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = (UIImageView*)obj;
            if (imageView.tag-10==count) {
                imageView.backgroundColor = [UIColor colorConvertWithHexString:@"d2a413"];
            }else{
                 imageView.backgroundColor = [UIColor colorConvertWithHexString:@"727172"];
            }
        }
    }
}
@end
