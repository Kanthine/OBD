//
//  SwitchPickerView.h
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchPickerViewDelegate <NSObject>

- (void)selectItem:(NSString*)item status:(BOOL)select textFiledNum:(NSInteger)textFieldNum;

@end

@interface SwitchPickerView : UIView
@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,assign)id<SwitchPickerViewDelegate>delegate;
@property(nonatomic,assign)NSInteger textFiledNum;
@property(nonatomic,strong)UILabel * titleLable;
@end

