//
//  OBDOrderManager.h
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  命令 查询和设置
 */
@interface OBDOrderManager : NSObject

+ (OBDOrderManager*)sharedOBDOrderManager;
/**
 *  命令代号
 */
@property(nonatomic,assign)NSInteger index;
/**
 *  是否是查询
 */
@property(nonatomic,assign)BOOL isCheck;
/**
 *  设置的新值
 */
@property(nonatomic,copy)NSString * setOderStr;
/**
 *  发送指令给obd
 *
 *  @param orderIndex 命令代号
 *  @param ischeck    是否是查询
 *  @param newOrder   设置的新的值
 */
- (void)setOrderWithOrderIndex:(NSInteger)orderIndex isCheck:(BOOL)ischeck newOrder:(NSString*)newOrder;


@end
