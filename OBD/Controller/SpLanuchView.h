//
//  SpLanuchView.h
//  SportJX
//
//  Created by Why on 16/3/26.
//  Copyright © 2016年 TianLinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SpLanuchViewDelegate <NSObject>

- (void)spLaunVctartButtonTouchEvent;

@end

@interface SpLanuchView : UIView
@property(nonatomic,assign)id<SpLanuchViewDelegate>delegate;
@end


