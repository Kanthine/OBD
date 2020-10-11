//
//  AuthorizationManager.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/25.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "AuthorizationManager.h"
#import "AccountInfo.h"

@implementation AuthorizationManager

+ (BOOL)isLoginState
{
    AccountInfo *user = [AccountInfo standardAccountInfo];
    
    NSString *token = user.uToken;
    NSString *userID = user.userId;
    
    if (token == nil || [token isEqualToString:@""])
    {
        return NO;
    }
    if (userID == nil || [userID isEqualToString:@""])
    {
        return NO;
    }
    
    return YES;
}

+ (UserProductType)getUserBrandType
{
    return [LocalConfigurationData getUserBrandType];
}

@end
