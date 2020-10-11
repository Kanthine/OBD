//
//  UIControl+SafeClick.m
//  NewXinLing
//
//  Created by Dinotech on 15/12/11.
//  Copyright © 2015年 why. All rights reserved.
//

#import "UIControl+SafeClick.h"
#import <objc/runtime.h>
@implementation UIControl (SafeClick)

+ (void)load{
    static dispatch_once_t once_Token;
    dispatch_once(&once_Token, ^{
    
        Method instance1  = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method instance2 = class_getInstanceMethod(self, @selector(__ry_sendAction:to:forEvent:));
        method_exchangeImplementations(instance1, instance2);
    });
   
    
    
}
- (void)__ry_sendAction:(SEL )action  to:(id)target forEvent:(UIEvent *)event{
    
    
    if (self.ry_ignoreEvent) {
        return;
    }
    NSLog(@"rytime = =%f ===%f",[[NSDate date] timeIntervalSince1970],self.ry_acceptClickEventInteral);
//    if ([[NSDate date] timeIntervalSince1970]-self.ry_acceptClickEventInteral<self.ry_acceptClickEventInteral) {
//        return;
//    }
    NSLog(@"rytime = =%f",self.ry_acceptClickEventInteral);
   
    if (self.ry_acceptClickEventInteral>0) {
        self.ry_ignoreEvent = YES;
        [self performSelector:@selector(__ry_setIgnoreEvent:) withObject:@(NO) afterDelay:self.ry_acceptClickEventInteral];
//        self.ry_acceptClickEventInteral = [[NSDate date] timeIntervalSince1970];
        
    }
    [self __ry_sendAction:action to:target forEvent:event];
}
- (void)__ry_setIgnoreEvent:(NSNumber *)isignore{
    self.ry_ignoreEvent = isignore.boolValue;
    
}
- (NSTimeInterval)ry_acceptClickEventInteral{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval)doubleValue];
    
}
- (void)setRy_acceptClickEventInteral:(NSTimeInterval)ry_acceptClickEventInteral{
    
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(ry_acceptClickEventInteral), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (BOOL)ry_ignoreEvent{
    return [objc_getAssociatedObject(self, UIControl_acceptIgnore) boolValue];
    
}
- (void)setRy_ignoreEvent:(BOOL)ry_ignoreEvent{
    objc_setAssociatedObject(self, UIControl_acceptIgnore, @(ry_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
    
}
@end
