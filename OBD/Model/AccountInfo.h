//
//  AccountInfo.h
//
//  Created by   on 2017/5/4
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headimg;

@property (nonatomic, strong) NSString *qq;


@property (nonatomic, strong) NSString *userRank;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *faceCard;
@property (nonatomic, strong) NSString *aiteId;
@property (nonatomic, strong) NSString *frozenMoney;
@property (nonatomic, strong) NSString *userMoney;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *card;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mediaUID;
@property (nonatomic, strong) NSString *surplusPassword;
@property (nonatomic, strong) NSString *rankPoints;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *isValidated;
@property (nonatomic, strong) NSString *regTime;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *salt;
@property (nonatomic, strong) NSString *backCard;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *validated;
@property (nonatomic, strong) NSString *payPoints;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *lastTime;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *froms;
@property (nonatomic, strong) NSString *lastLogin;
@property (nonatomic, strong) NSString *msn;
@property (nonatomic, strong) NSString *creditLine;
@property (nonatomic, strong) NSString *isFenxiao;
@property (nonatomic, strong) NSString *visitCount;
@property (nonatomic, strong) NSString *mediaID;
@property (nonatomic, strong) NSString *uToken;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *lastIp;
@property (nonatomic, strong) NSString *isSurplusOpen;
@property (nonatomic, strong) NSString *isSpecial;

+ (AccountInfo *)standardAccountInfo;
- (BOOL)storeAccountInfo;//存储用户信息
- (BOOL)logoutAccount;//销毁



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
