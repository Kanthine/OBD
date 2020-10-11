//
//  PageControlView.h
//  SportJX
//
//  Created by Why on 16/3/26.
//  Copyright © 2016年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlView : UIView
- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)count width:(float)width;
- (void)refreshPageCount:(NSInteger)count;
@end
