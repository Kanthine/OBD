//
//  OneBottomView.m
//  OBD
//
//  Created by Why on 16/3/28.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "OneBottomView.h"
@interface OneBottomView()

@end
@implementation OneBottomView
{
    float _itemWidth;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _itemWidth = (frame.size.width-20)/3.0;
        [self setUpView];
      [[CurrentOBDModel sharedCurrentOBDModel]obdOilLossChangeWithBlock:^(NSString *currentOilLoss) {
//          if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//              return ;
//          }
          if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
               self.averge_oilConsumptionLable.attributedText = [self getAttributeStr:currentOilLoss unChangeLength:7 unchangeStr:@"L/100Km"];
          }
         
      }];
        [[CurrentOBDModel sharedCurrentOBDModel]obdDriveDistanceChangeWithBlock:^(NSString *driveDistance) {
//            if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//                return ;
//            }
            if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
                if (driveDistance != nil) {
                    self.drive_DistanceLable.attributedText = [self getAttributeStr:driveDistance unChangeLength:2 unchangeStr:@"Km"];
                }
            }
            
        }];
        [[CurrentOBDModel sharedCurrentOBDModel]obdOilMainLossChangeWithBlock:^(NSString *oilMainLoss) {
//            if ([CurrentOBDModel sharedCurrentOBDModel].isNoFirstView) {
//                return ;
//            }
            if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
                if (oilMainLoss != nil) {
                    self.oil_ConsumptionLable.attributedText = [self getAttributeStr:oilMainLoss unChangeLength:1 unchangeStr:@"L"];
                }
            }
            
        }];
    }
    return self;
}
- (NSMutableAttributedString*)getAttributeStr:(NSString*)oldStr unChangeLength:(NSInteger)len unchangeStr:(NSString*)unchangeStr{
    float lenght = oldStr.length; //
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",oldStr,unchangeStr]];
    //[str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, lenght+1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DBLCDTempBlack" size:20] range:NSMakeRange(0, lenght+1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(lenght+1, len)];
    //[str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"a0b751"] range:NSMakeRange(lenght+1, len)];
    //[str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"219dd0"] range:NSMakeRange(lenght+1+len, 1)];
    return str;
}
#pragma mark --创建试图
- (void)setUpView{
    NSArray * iconArr = @[@"xingshilicheng",@"youhao",@"youhaoliang"];
    NSArray * titleArr = @[WHYGetStringWithKeyFromTable(@"DRIVEDISTANCE", @""),WHYGetStringWithKeyFromTable(@"OILLOSS", @""),WHYGetStringWithKeyFromTable(@"AVERGEOILLOSS", @"")];
    for (int i = 0; i<3; i++) {
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0+(_itemWidth+13)*i, 0, _itemWidth, _itemWidth)];
        //backView.backgroundColor = [UIColor redColor];
        UIImageView * iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, [WHYSizeManager getRelativelyWeight:20], [WHYSizeManager getRelativelyWeight:20])];
        iconImageView.image = [UIImage imageNamed:iconArr[i]];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.clipsToBounds = YES;
        [backView addSubview:iconImageView];
//        float font = 10;
//        if (isiPhone5) {
//            font = 10;
//        }else if (isiPhone6){
//            font = 14;
//        }else if (isiPhone6P){
//            font = 18;
//        }
        float font = 8;
        if (isiPhone5) {
            font = 8;
        }else if (isiPhone6){
            font = 10;
        }else if (isiPhone6P){
            font = 13;
        }
         CGRect tmpRect = [titleArr[i] boundingRectWithSize:CGSizeMake(_itemWidth-38, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"ArialMT" size:font],NSFontAttributeName, nil] context:nil];
        //[[UILabel alloc]initWithFrame:CGRectMake(iconImageView.frame.origin.x+iconImageView.frame.size.width+10, (20*tmpRect.size.height)/15.0, _itemWidth-38, tmpRect.size.height)];
        UILabel * titleLable = [[UILabel alloc]init];
        titleLable.center = CGPointMake(iconImageView.center.x+iconImageView.frame.size.width/2.0+10+(_itemWidth-38)/2.0, iconImageView.center.y);
        titleLable.bounds = CGRectMake(0, 0, _itemWidth-38, tmpRect.size.height);
        titleLable.font = [UIFont fontWithName:@"ArialMT" size:font];
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.text = titleArr[i];
        titleLable.numberOfLines = 2;
        titleLable.textColor = [UIColor colorConvertWithHexString:@"0bf5fa"];
        [backView addSubview:titleLable];
        
        UILabel * numTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, iconImageView.frame.origin.y+iconImageView.frame.size.width+17, _itemWidth, 25)];
        numTitleLable.font = [UIFont fontWithName:@"DBLCDTempBlack" size:20];
        numTitleLable.textColor = [UIColor whiteColor];
        numTitleLable.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:numTitleLable];
        switch (i) {
            case 0:
            {
                self.drive_DistanceLable = numTitleLable;
            }
                break;
            case 1:
            {
                self.oil_ConsumptionLable = numTitleLable;
            }
                break;
            case 2:
            {
                self.averge_oilConsumptionLable = numTitleLable;
            }
                break;
            default:
                break;
        }
        [self addSubview:backView];
    }
}


@end
