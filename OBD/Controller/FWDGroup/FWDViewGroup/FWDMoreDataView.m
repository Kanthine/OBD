//
//  FWDMoreDataView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/9.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "FWDMoreDataView.h"

#import "OBDThisTimeData.h"

@interface FWDMoreDataItemView()

{
    NSString *_unitString;
}

@property (nonatomic ,strong) NSString *valueString;
@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) UILabel *valueLable;


- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Title:(NSString *)title Unit:(NSString *)unit;

@end

@implementation FWDMoreDataItemView

- (instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Title:(NSString *)title Unit:(NSString *)unit
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _unitString = unit;
        
        [self addSubview:self.logoImageView];
        [self addSubview:self.valueLable];
        [self addSubview:self.titleLable];
        
        
        self.titleLable.text = title;
        self.logoImageView.image = [UIImage imageNamed:imageName];
        

    }
    
    return self;
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 40)/2.0, 15, 40, 40)];
        imageView.tintColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UILabel *)valueLable
{
    if (_valueLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame) + 8, CGRectGetWidth(self.frame), 16)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:13];
        lable.textColor = [UIColor whiteColor];
        lable.attributedText = [self setAttributeText:@"0.0 "];

        
        _valueLable = lable;
    }
    return _valueLable;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.valueLable.frame) + 10, CGRectGetWidth(self.frame), 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor whiteColor];
        
        
        _titleLable = lable;
    }
    return _titleLable;
}


- (void)setValueString:(NSString *)valueString
{
    if ([_valueString isEqualToString:valueString] == NO)
    {
        _valueString = valueString;
        
        self.valueLable.attributedText = [self setAttributeText:valueString];
    }
}


- (NSMutableAttributedString *)setAttributeText:(NSString *)newString
{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:newString];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, string1.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string1.length)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:_unitString];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, string2.length)];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string2.length)];
    
    [string1 appendAttributedString:string2];
    
    return string1;
}



@end




@interface FWDMoreDataView()



@end


@implementation FWDMoreDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        
        NSArray *titleArray = @[@"本次行驶里程",@"本次油耗量",@"本次怠速时间",@"本次行驶时间",@"瞬间油耗",@"平均车速"];
        NSArray *imageArray = @[@"FWD_XingShiLiCheng",@"FWD_HaoYouLiang",@"FWD_DaiSuShiJian",@"FWD_XingShiShiJian",@"FWD_PingJunYouHao",@"FWD_PingJunCheSu"];
        NSArray *unitArray = @[@"km",@"L",@"min",@"min",@"L/100km",@"km/h"];
        
        
        
        CGFloat width = CGRectGetWidth(self.frame) / 2.0;
        CGFloat height = CGRectGetHeight(self.frame) / 3.0;

        
        [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            int i = idx % 2;
            int j = idx / 2;
            
            FWDMoreDataItemView *itemView = [[FWDMoreDataItemView alloc]initWithFrame:CGRectMake(i * width, j * height, width, height) Image:imageArray[idx] Title:obj Unit:unitArray[idx]];
            itemView.tag = idx + 10;
            [self addSubview:itemView];
        }];
        
        
        
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, height, CGRectGetWidth(self.frame), 1)];
        lineView1.backgroundColor = RGBA(17, 17, 17, 1);
        [self addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, height * 2,  CGRectGetWidth(self.frame), 1)];
        lineView2.backgroundColor = RGBA(17, 17, 17, 1);
        [self addSubview:lineView2];

        
        UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(width, 0, 1, CGRectGetHeight(self.frame))];
        lineView3.backgroundColor = RGBA(17, 17, 17, 1);
        [self addSubview:lineView3];

        [self addValueObserverEvent];
    }
    
    return self;
}

- (void)addValueObserverEvent
{
    NSObject *object = [[NSObject alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //本次行驶里程
        FWDMoreDataItemView *itemView0 = [self viewWithTag:10];
        [[CurrentOBDModel sharedCurrentOBDModel]obdDriveDistanceChangeWithBlock:^(NSString *driveDistance)
         {
//             NSLog(@"本次行驶里程 ----------- %@",driveDistance);
             if (driveDistance != nil)
             {
                 NSString *newValueString = [OBDThisTimeData getThisTimeDriveDistance:driveDistance];
                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     itemView0.valueString = newValueString;
                 });
             }
             
         }];

        
    });

    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //本次油耗量
        FWDMoreDataItemView *itemView1 = [self viewWithTag:11];
        [[CurrentOBDModel sharedCurrentOBDModel]obdOilMainLossChangeWithBlock:^(NSString *oilMainLoss)
         {
             if (oilMainLoss != nil)
             {
                 NSString *newValueString = [OBDThisTimeData getThisTimeOilConsumption:oilMainLoss];

                dispatch_async(dispatch_get_main_queue(), ^{
                     itemView1.valueString = newValueString;
                 });
             }
         }];
        

    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //本次怠速时间
        FWDMoreDataItemView *itemView4 = [self viewWithTag:12];
        [[CurrentOBDModel sharedCurrentOBDModel]obdDaiSuTimeChangeWithBlock:^(NSString *daiSuTime)
         {
             //             NSLog(@"本次怠速时间----------- %@",daiSuTime);
             if (daiSuTime != nil)
             {
                 NSString *newValueString = [OBDThisTimeData getThisTimeIdlingTime:daiSuTime];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     itemView4.valueString = newValueString;
                 });
             }
         }];
        
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //本次行驶时间
        FWDMoreDataItemView *itemView3 = [self viewWithTag:13];
        [[CurrentOBDModel sharedCurrentOBDModel]obdDriveTimeChangeWithBlock:^(NSString *driveTime)
         {
//             NSLog(@"本次行驶时间----------- %@",driveTime);
             if (driveTime != nil)
             {
                 NSString *newValueString = [OBDThisTimeData getThisTimeDrivableTime:driveTime];

                 dispatch_async(dispatch_get_main_queue(), ^{
                     itemView3.valueString = newValueString;
                 });
             }
             
         }];
        
        
    });



    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //平均油耗
        FWDMoreDataItemView *itemView2 = [self viewWithTag:14];
        [[CurrentOBDModel sharedCurrentOBDModel]obdOilLossChangeWithBlock:^(NSString *currentOilLoss)
         {
             if (currentOilLoss != nil)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     itemView2.valueString = currentOilLoss;
                 });
             }
         }];
    });
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //平均车速
        FWDMoreDataItemView *itemView5 = [self viewWithTag:15];
        [[CurrentOBDModel sharedCurrentOBDModel]obdAverageCarSpeedChangeWithBlock:^(NSString *averCarSpeed)
         {
//             NSLog(@"平均车速 ----------- %@",averCarSpeed);
             if (averCarSpeed != nil)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     itemView5.valueString = averCarSpeed;
                 });
             }
         }];
    });
    
    
    
}


@end
