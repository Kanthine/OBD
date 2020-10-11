//
//  ControlBoxWaveView.h
//  OBD
//
//  Created by 苏沫离 on 2017/4/28.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlBoxWaveView : UIView

- (void)startFWDAnimation;

- (void)stopFWDAnimation;

- (void)matchSuccessAnimationBlock:(void (^) (UIImage *image,CGSize size))block;

@end
