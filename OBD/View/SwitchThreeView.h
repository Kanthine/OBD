//
//  SwitchThreeView.h
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchThreeViewDelegate <NSObject>

- (void)bringToFont:(BOOL)yes;

@end
@interface SwitchThreeView : UIView<UITextFieldDelegate>
@property(nonatomic,assign)id<SwitchThreeViewDelegate>delegate;
@end
