//
//  InputView.h
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (nonatomic ,strong) UITextField *textFiled;
@property (nonatomic ,strong) UIButton *verCodeButton;

- (instancetype)initWithPlacterText:(NSString *)laceholder IsVerBtn:(BOOL)isVerBtn;

- (void)startSendVerCode;

- (void)cancelSendVerCode;

@end
