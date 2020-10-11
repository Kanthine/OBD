//
//  WHYToolModel.m
//  OBD
//
//  Created by Why on 16/1/21.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "WHYToolModel.h"

@implementation WHYToolModel

+ (NSString*)getHexNumFrom:(NSString*)commondCodeStr
{
    NSDictionary * dic = @{@"00":@"0",@"01":@"1",@"02":@"2",@"03":@"3",@"04":@"4",@"05":@"5",@"06":@"6",@"07":@"7",@"08":@"8",@"09":@"9",@"0A":@"10",@"0B":@"11",@"0C":@"12",@"0D":@"13",@"0E":@"14",@"0F":@"15",@"10":@"16",@"11":@"17",@"12":@"18",@"13":@"19"};
    return [dic objectForKey:commondCodeStr];
}

+ (NSString*)getUnitFrom:(NSString*)commondCodeStr
{
     NSDictionary * dic = @{@"01":@"",@"02":@"rpm",@"03":@"3",@"04":@"4",@"05":@"5",@"06":@"6",@"07":@"7",@"08":@"8",@"09":@"9",@"0A":@"10",@"0B":@"11",@"0C":@"12",@"0D":@"13",@"0E":@"14",@"0F":@"15"};
    return [dic objectForKey:commondCodeStr];
}

+ (UIColor*)getBigTitleColor
{
    return RGBA(30, 123, 175, 1);
}

@end
