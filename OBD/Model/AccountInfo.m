//
//  AccountInfo.m
//
//  Created by   on 2017/5/4
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "AccountInfo.h"
#import "LocalConfigurationData.h"


NSString *const kAccountInfoUserRank = @"user_rank";
NSString *const kAccountInfoAlias = @"alias";
NSString *const kAccountInfoFaceCard = @"face_card";
NSString *const kAccountInfoAiteId = @"aite_id";
NSString *const kAccountInfoFrozenMoney = @"frozen_money";
NSString *const kAccountInfoUserMoney = @"user_money";
NSString *const kAccountInfoCountry = @"country";
NSString *const kAccountInfoCard = @"card";
NSString *const kAccountInfoUserName = @"user_name";
NSString *const kAccountInfoAddressId = @"address_id";
NSString *const kAccountInfoAddress = @"address";
NSString *const kAccountInfoMediaUID = @"mediaUID";
NSString *const kAccountInfoSurplusPassword = @"surplus_password";
NSString *const kAccountInfoNickname = @"nickname";
NSString *const kAccountInfoRankPoints = @"rank_points";
NSString *const kAccountInfoFlag = @"flag";
NSString *const kAccountInfoIsValidated = @"is_validated";
NSString *const kAccountInfoRegTime = @"reg_time";
NSString *const kAccountInfoAnswer = @"answer";
NSString *const kAccountInfoDistrict = @"district";
NSString *const kAccountInfoPhone = @"phone";
NSString *const kAccountInfoRealName = @"real_name";
NSString *const kAccountInfoParentId = @"parent_id";
NSString *const kAccountInfoSex = @"sex";
NSString *const kAccountInfoSalt = @"salt";
NSString *const kAccountInfoBackCard = @"back_card";
NSString *const kAccountInfoEmail = @"email";
NSString *const kAccountInfoBirthday = @"birthday";
NSString *const kAccountInfoValidated = @"validated";
NSString *const kAccountInfoPayPoints = @"pay_points";
NSString *const kAccountInfoCity = @"city";
NSString *const kAccountInfoStatus = @"status";
NSString *const kAccountInfoHeadimg = @"headimg";
NSString *const kAccountInfoLastTime = @"last_time";
NSString *const kAccountInfoProvince = @"province";
NSString *const kAccountInfoFroms = @"froms";
NSString *const kAccountInfoUserId = @"user_id";
NSString *const kAccountInfoLastLogin = @"last_login";
NSString *const kAccountInfoQq = @"qq";
NSString *const kAccountInfoMsn = @"msn";
NSString *const kAccountInfoCreditLine = @"credit_line";
NSString *const kAccountInfoIsFenxiao = @"is_fenxiao";
NSString *const kAccountInfoVisitCount = @"visit_count";
NSString *const kAccountInfoMediaID = @"mediaID";
NSString *const kAccountInfoUToken = @"u_token";
NSString *const kAccountInfoQuestion = @"question";
NSString *const kAccountInfoPassword = @"password";
NSString *const kAccountInfoLastIp = @"last_ip";
NSString *const kAccountInfoIsSurplusOpen = @"is_surplus_open";
NSString *const kAccountInfoIsSpecial = @"is_special";


@interface AccountInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AccountInfo

@synthesize userRank = _userRank;
@synthesize alias = _alias;
@synthesize faceCard = _faceCard;
@synthesize aiteId = _aiteId;
@synthesize frozenMoney = _frozenMoney;
@synthesize userMoney = _userMoney;
@synthesize country = _country;
@synthesize card = _card;
@synthesize userName = _userName;
@synthesize addressId = _addressId;
@synthesize address = _address;
@synthesize mediaUID = _mediaUID;
@synthesize surplusPassword = _surplusPassword;
@synthesize nickname = _nickname;
@synthesize rankPoints = _rankPoints;
@synthesize flag = _flag;
@synthesize isValidated = _isValidated;
@synthesize regTime = _regTime;
@synthesize answer = _answer;
@synthesize district = _district;
@synthesize phone = _phone;
@synthesize realName = _realName;
@synthesize parentId = _parentId;
@synthesize sex = _sex;
@synthesize salt = _salt;
@synthesize backCard = _backCard;
@synthesize email = _email;
@synthesize birthday = _birthday;
@synthesize validated = _validated;
@synthesize payPoints = _payPoints;
@synthesize city = _city;
@synthesize status = _status;
@synthesize headimg = _headimg;
@synthesize lastTime = _lastTime;
@synthesize province = _province;
@synthesize froms = _froms;
@synthesize userId = _userId;
@synthesize lastLogin = _lastLogin;
@synthesize qq = _qq;
@synthesize msn = _msn;
@synthesize creditLine = _creditLine;
@synthesize isFenxiao = _isFenxiao;
@synthesize visitCount = _visitCount;
@synthesize mediaID = _mediaID;
@synthesize uToken = _uToken;
@synthesize question = _question;
@synthesize password = _password;
@synthesize lastIp = _lastIp;
@synthesize isSurplusOpen = _isSurplusOpen;
@synthesize isSpecial = _isSpecial;

static  AccountInfo*user = nil;
static dispatch_once_t rootOnceToken;
+ (AccountInfo *)standardAccountInfo{
    dispatch_once(&rootOnceToken, ^{
        user = [AccountInfo readAccountInfo];
        if (user == nil){
            user = [[AccountInfo alloc]init];
        }
    });
    return user;
}

+ (AccountInfo *)readAccountInfo
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:[AccountInfo getFilePath]];
    
    // 2,创建一个反序列化器,把要读的数据 传给它,让它读数据
    NSKeyedUnarchiver *unrachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    // 3,从反序列化器中解码出数组
    AccountInfo *account = (AccountInfo *) [unrachiver decodeObject];
    // 4 结束解码
    [unrachiver finishDecoding];
    
    return account;
}

+ (NSString *)getFilePath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/accountInfo.plist"];//Appending 添加 Component 成分 Directory目录;
}

- (BOOL)storeAccountInfo
{
    self.userId = @"123456";
    
    //    把原本不能够直接写入到文件中的对象(_array)--->>编码成NSData--->writeToFile
    
    // 1,创建一个空的data(类似于一个袋子),用来让序列化器把 编码之后的data存放起来
    NSMutableData *data = [[NSMutableData alloc] init];
    
    // 2,创建一个序列化器,并且给它一个空的data,用来存放编码之后的数据
    NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 3,把数组进行编码
    [archive encodeObject:[AccountInfo standardAccountInfo]];//encode 编码
    
    // 4,结束编码
    [archive finishEncoding];
    
    //    NSLog(@"data  %@",data);
    
    // 5,把data写入文件
    BOOL isSuccees = [data writeToFile:[AccountInfo getFilePath] atomically:YES];
    
    
    
    return isSuccees;
}

- (BOOL)logoutAccount
{
    NSFileManager *fmanager=[NSFileManager defaultManager];
    BOOL isSucceed = [fmanager removeItemAtPath:[AccountInfo getFilePath] error:nil];
//    
//    [LocalConfigurationData clearAllUserLocalData];
    
    if (isSucceed)
    {
        //释放单利
        user = nil;
        rootOnceToken = 0l;
        //清除本地 收货地址
        
        NSLog(@"退出登录");
        
    }
    return isSucceed;
}









+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    AccountInfo *model = [AccountInfo standardAccountInfo];
    [model parserDataWithDictionary:dict];
    
    return [AccountInfo standardAccountInfo];
}

- (void)parserDataWithDictionary:(NSDictionary *)dict
{
    if(self && [dict isKindOfClass:[NSDictionary class]])
    {
        self.userRank = [self objectOrNilForKey:kAccountInfoUserRank fromDictionary:dict];
        self.alias = [self objectOrNilForKey:kAccountInfoAlias fromDictionary:dict];
        self.faceCard = [self objectOrNilForKey:kAccountInfoFaceCard fromDictionary:dict];
        self.aiteId = [self objectOrNilForKey:kAccountInfoAiteId fromDictionary:dict];
        self.frozenMoney = [self objectOrNilForKey:kAccountInfoFrozenMoney fromDictionary:dict];
        self.userMoney = [self objectOrNilForKey:kAccountInfoUserMoney fromDictionary:dict];
        self.country = [self objectOrNilForKey:kAccountInfoCountry fromDictionary:dict];
        self.card = [self objectOrNilForKey:kAccountInfoCard fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kAccountInfoUserName fromDictionary:dict];
        self.addressId = [self objectOrNilForKey:kAccountInfoAddressId fromDictionary:dict];
        self.address = [self objectOrNilForKey:kAccountInfoAddress fromDictionary:dict];
        self.mediaUID = [self objectOrNilForKey:kAccountInfoMediaUID fromDictionary:dict];
        self.surplusPassword = [self objectOrNilForKey:kAccountInfoSurplusPassword fromDictionary:dict];
        self.nickname = [self objectOrNilForKey:kAccountInfoNickname fromDictionary:dict];
        self.rankPoints = [self objectOrNilForKey:kAccountInfoRankPoints fromDictionary:dict];
        self.flag = [self objectOrNilForKey:kAccountInfoFlag fromDictionary:dict];
        self.isValidated = [self objectOrNilForKey:kAccountInfoIsValidated fromDictionary:dict];
        self.regTime = [self objectOrNilForKey:kAccountInfoRegTime fromDictionary:dict];
        self.answer = [self objectOrNilForKey:kAccountInfoAnswer fromDictionary:dict];
        self.district = [self objectOrNilForKey:kAccountInfoDistrict fromDictionary:dict];
        self.phone = [self objectOrNilForKey:kAccountInfoPhone fromDictionary:dict];
        self.realName = [self objectOrNilForKey:kAccountInfoRealName fromDictionary:dict];
        self.parentId = [self objectOrNilForKey:kAccountInfoParentId fromDictionary:dict];
        self.sex = [self objectOrNilForKey:kAccountInfoSex fromDictionary:dict];
        self.salt = [self objectOrNilForKey:kAccountInfoSalt fromDictionary:dict];
        self.backCard = [self objectOrNilForKey:kAccountInfoBackCard fromDictionary:dict];
        self.email = [self objectOrNilForKey:kAccountInfoEmail fromDictionary:dict];
        self.birthday = [self objectOrNilForKey:kAccountInfoBirthday fromDictionary:dict];
        self.validated = [self objectOrNilForKey:kAccountInfoValidated fromDictionary:dict];
        self.payPoints = [self objectOrNilForKey:kAccountInfoPayPoints fromDictionary:dict];
        self.city = [self objectOrNilForKey:kAccountInfoCity fromDictionary:dict];
        self.status = [self objectOrNilForKey:kAccountInfoStatus fromDictionary:dict];
        self.headimg = [self objectOrNilForKey:kAccountInfoHeadimg fromDictionary:dict];
        self.lastTime = [self objectOrNilForKey:kAccountInfoLastTime fromDictionary:dict];
        self.province = [self objectOrNilForKey:kAccountInfoProvince fromDictionary:dict];
        self.froms = [self objectOrNilForKey:kAccountInfoFroms fromDictionary:dict];
        self.userId = [self objectOrNilForKey:kAccountInfoUserId fromDictionary:dict];
        self.lastLogin = [self objectOrNilForKey:kAccountInfoLastLogin fromDictionary:dict];
        self.qq = [self objectOrNilForKey:kAccountInfoQq fromDictionary:dict];
        self.msn = [self objectOrNilForKey:kAccountInfoMsn fromDictionary:dict];
        self.creditLine = [self objectOrNilForKey:kAccountInfoCreditLine fromDictionary:dict];
        self.isFenxiao = [self objectOrNilForKey:kAccountInfoIsFenxiao fromDictionary:dict];
        self.visitCount = [self objectOrNilForKey:kAccountInfoVisitCount fromDictionary:dict];
        self.mediaID = [self objectOrNilForKey:kAccountInfoMediaID fromDictionary:dict];
        self.uToken = [self objectOrNilForKey:kAccountInfoUToken fromDictionary:dict];
        self.question = [self objectOrNilForKey:kAccountInfoQuestion fromDictionary:dict];
        self.password = [self objectOrNilForKey:kAccountInfoPassword fromDictionary:dict];
        self.lastIp = [self objectOrNilForKey:kAccountInfoLastIp fromDictionary:dict];
        self.isSurplusOpen = [self objectOrNilForKey:kAccountInfoIsSurplusOpen fromDictionary:dict];
        self.isSpecial = [self objectOrNilForKey:kAccountInfoIsSpecial fromDictionary:dict];
        
    }
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userRank = [self objectOrNilForKey:kAccountInfoUserRank fromDictionary:dict];
            self.alias = [self objectOrNilForKey:kAccountInfoAlias fromDictionary:dict];
            self.faceCard = [self objectOrNilForKey:kAccountInfoFaceCard fromDictionary:dict];
            self.aiteId = [self objectOrNilForKey:kAccountInfoAiteId fromDictionary:dict];
            self.frozenMoney = [self objectOrNilForKey:kAccountInfoFrozenMoney fromDictionary:dict];
            self.userMoney = [self objectOrNilForKey:kAccountInfoUserMoney fromDictionary:dict];
            self.country = [self objectOrNilForKey:kAccountInfoCountry fromDictionary:dict];
            self.card = [self objectOrNilForKey:kAccountInfoCard fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kAccountInfoUserName fromDictionary:dict];
            self.addressId = [self objectOrNilForKey:kAccountInfoAddressId fromDictionary:dict];
            self.address = [self objectOrNilForKey:kAccountInfoAddress fromDictionary:dict];
            self.mediaUID = [self objectOrNilForKey:kAccountInfoMediaUID fromDictionary:dict];
            self.surplusPassword = [self objectOrNilForKey:kAccountInfoSurplusPassword fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:kAccountInfoNickname fromDictionary:dict];
            self.rankPoints = [self objectOrNilForKey:kAccountInfoRankPoints fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kAccountInfoFlag fromDictionary:dict];
            self.isValidated = [self objectOrNilForKey:kAccountInfoIsValidated fromDictionary:dict];
            self.regTime = [self objectOrNilForKey:kAccountInfoRegTime fromDictionary:dict];
            self.answer = [self objectOrNilForKey:kAccountInfoAnswer fromDictionary:dict];
            self.district = [self objectOrNilForKey:kAccountInfoDistrict fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kAccountInfoPhone fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kAccountInfoRealName fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kAccountInfoParentId fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kAccountInfoSex fromDictionary:dict];
            self.salt = [self objectOrNilForKey:kAccountInfoSalt fromDictionary:dict];
            self.backCard = [self objectOrNilForKey:kAccountInfoBackCard fromDictionary:dict];
            self.email = [self objectOrNilForKey:kAccountInfoEmail fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kAccountInfoBirthday fromDictionary:dict];
            self.validated = [self objectOrNilForKey:kAccountInfoValidated fromDictionary:dict];
            self.payPoints = [self objectOrNilForKey:kAccountInfoPayPoints fromDictionary:dict];
            self.city = [self objectOrNilForKey:kAccountInfoCity fromDictionary:dict];
            self.status = [self objectOrNilForKey:kAccountInfoStatus fromDictionary:dict];
            self.headimg = [self objectOrNilForKey:kAccountInfoHeadimg fromDictionary:dict];
            self.lastTime = [self objectOrNilForKey:kAccountInfoLastTime fromDictionary:dict];
            self.province = [self objectOrNilForKey:kAccountInfoProvince fromDictionary:dict];
            self.froms = [self objectOrNilForKey:kAccountInfoFroms fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kAccountInfoUserId fromDictionary:dict];
            self.lastLogin = [self objectOrNilForKey:kAccountInfoLastLogin fromDictionary:dict];
            self.qq = [self objectOrNilForKey:kAccountInfoQq fromDictionary:dict];
            self.msn = [self objectOrNilForKey:kAccountInfoMsn fromDictionary:dict];
            self.creditLine = [self objectOrNilForKey:kAccountInfoCreditLine fromDictionary:dict];
            self.isFenxiao = [self objectOrNilForKey:kAccountInfoIsFenxiao fromDictionary:dict];
            self.visitCount = [self objectOrNilForKey:kAccountInfoVisitCount fromDictionary:dict];
            self.mediaID = [self objectOrNilForKey:kAccountInfoMediaID fromDictionary:dict];
            self.uToken = [self objectOrNilForKey:kAccountInfoUToken fromDictionary:dict];
            self.question = [self objectOrNilForKey:kAccountInfoQuestion fromDictionary:dict];
            self.password = [self objectOrNilForKey:kAccountInfoPassword fromDictionary:dict];
            self.lastIp = [self objectOrNilForKey:kAccountInfoLastIp fromDictionary:dict];
            self.isSurplusOpen = [self objectOrNilForKey:kAccountInfoIsSurplusOpen fromDictionary:dict];
            self.isSpecial = [self objectOrNilForKey:kAccountInfoIsSpecial fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userRank forKey:kAccountInfoUserRank];
    [mutableDict setValue:self.alias forKey:kAccountInfoAlias];
    [mutableDict setValue:self.faceCard forKey:kAccountInfoFaceCard];
    [mutableDict setValue:self.aiteId forKey:kAccountInfoAiteId];
    [mutableDict setValue:self.frozenMoney forKey:kAccountInfoFrozenMoney];
    [mutableDict setValue:self.userMoney forKey:kAccountInfoUserMoney];
    [mutableDict setValue:self.country forKey:kAccountInfoCountry];
    [mutableDict setValue:self.card forKey:kAccountInfoCard];
    [mutableDict setValue:self.userName forKey:kAccountInfoUserName];
    [mutableDict setValue:self.addressId forKey:kAccountInfoAddressId];
    [mutableDict setValue:self.address forKey:kAccountInfoAddress];
    [mutableDict setValue:self.mediaUID forKey:kAccountInfoMediaUID];
    [mutableDict setValue:self.surplusPassword forKey:kAccountInfoSurplusPassword];
    [mutableDict setValue:self.nickname forKey:kAccountInfoNickname];
    [mutableDict setValue:self.rankPoints forKey:kAccountInfoRankPoints];
    [mutableDict setValue:self.flag forKey:kAccountInfoFlag];
    [mutableDict setValue:self.isValidated forKey:kAccountInfoIsValidated];
    [mutableDict setValue:self.regTime forKey:kAccountInfoRegTime];
    [mutableDict setValue:self.answer forKey:kAccountInfoAnswer];
    [mutableDict setValue:self.district forKey:kAccountInfoDistrict];
    [mutableDict setValue:self.phone forKey:kAccountInfoPhone];
    [mutableDict setValue:self.realName forKey:kAccountInfoRealName];
    [mutableDict setValue:self.parentId forKey:kAccountInfoParentId];
    [mutableDict setValue:self.sex forKey:kAccountInfoSex];
    [mutableDict setValue:self.salt forKey:kAccountInfoSalt];
    [mutableDict setValue:self.backCard forKey:kAccountInfoBackCard];
    [mutableDict setValue:self.email forKey:kAccountInfoEmail];
    [mutableDict setValue:self.birthday forKey:kAccountInfoBirthday];
    [mutableDict setValue:self.validated forKey:kAccountInfoValidated];
    [mutableDict setValue:self.payPoints forKey:kAccountInfoPayPoints];
    [mutableDict setValue:self.city forKey:kAccountInfoCity];
    [mutableDict setValue:self.status forKey:kAccountInfoStatus];
    [mutableDict setValue:self.headimg forKey:kAccountInfoHeadimg];
    [mutableDict setValue:self.lastTime forKey:kAccountInfoLastTime];
    [mutableDict setValue:self.province forKey:kAccountInfoProvince];
    [mutableDict setValue:self.froms forKey:kAccountInfoFroms];
    [mutableDict setValue:self.userId forKey:kAccountInfoUserId];
    [mutableDict setValue:self.lastLogin forKey:kAccountInfoLastLogin];
    [mutableDict setValue:self.qq forKey:kAccountInfoQq];
    [mutableDict setValue:self.msn forKey:kAccountInfoMsn];
    [mutableDict setValue:self.creditLine forKey:kAccountInfoCreditLine];
    [mutableDict setValue:self.isFenxiao forKey:kAccountInfoIsFenxiao];
    [mutableDict setValue:self.visitCount forKey:kAccountInfoVisitCount];
    [mutableDict setValue:self.mediaID forKey:kAccountInfoMediaID];
    [mutableDict setValue:self.uToken forKey:kAccountInfoUToken];
    [mutableDict setValue:self.question forKey:kAccountInfoQuestion];
    [mutableDict setValue:self.password forKey:kAccountInfoPassword];
    [mutableDict setValue:self.lastIp forKey:kAccountInfoLastIp];
    [mutableDict setValue:self.isSurplusOpen forKey:kAccountInfoIsSurplusOpen];
    [mutableDict setValue:self.isSpecial forKey:kAccountInfoIsSpecial];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userRank = [aDecoder decodeObjectForKey:kAccountInfoUserRank];
    self.alias = [aDecoder decodeObjectForKey:kAccountInfoAlias];
    self.faceCard = [aDecoder decodeObjectForKey:kAccountInfoFaceCard];
    self.aiteId = [aDecoder decodeObjectForKey:kAccountInfoAiteId];
    self.frozenMoney = [aDecoder decodeObjectForKey:kAccountInfoFrozenMoney];
    self.userMoney = [aDecoder decodeObjectForKey:kAccountInfoUserMoney];
    self.country = [aDecoder decodeObjectForKey:kAccountInfoCountry];
    self.card = [aDecoder decodeObjectForKey:kAccountInfoCard];
    self.userName = [aDecoder decodeObjectForKey:kAccountInfoUserName];
    self.addressId = [aDecoder decodeObjectForKey:kAccountInfoAddressId];
    self.address = [aDecoder decodeObjectForKey:kAccountInfoAddress];
    self.mediaUID = [aDecoder decodeObjectForKey:kAccountInfoMediaUID];
    self.surplusPassword = [aDecoder decodeObjectForKey:kAccountInfoSurplusPassword];
    self.nickname = [aDecoder decodeObjectForKey:kAccountInfoNickname];
    self.rankPoints = [aDecoder decodeObjectForKey:kAccountInfoRankPoints];
    self.flag = [aDecoder decodeObjectForKey:kAccountInfoFlag];
    self.isValidated = [aDecoder decodeObjectForKey:kAccountInfoIsValidated];
    self.regTime = [aDecoder decodeObjectForKey:kAccountInfoRegTime];
    self.answer = [aDecoder decodeObjectForKey:kAccountInfoAnswer];
    self.district = [aDecoder decodeObjectForKey:kAccountInfoDistrict];
    self.phone = [aDecoder decodeObjectForKey:kAccountInfoPhone];
    self.realName = [aDecoder decodeObjectForKey:kAccountInfoRealName];
    self.parentId = [aDecoder decodeObjectForKey:kAccountInfoParentId];
    self.sex = [aDecoder decodeObjectForKey:kAccountInfoSex];
    self.salt = [aDecoder decodeObjectForKey:kAccountInfoSalt];
    self.backCard = [aDecoder decodeObjectForKey:kAccountInfoBackCard];
    self.email = [aDecoder decodeObjectForKey:kAccountInfoEmail];
    self.birthday = [aDecoder decodeObjectForKey:kAccountInfoBirthday];
    self.validated = [aDecoder decodeObjectForKey:kAccountInfoValidated];
    self.payPoints = [aDecoder decodeObjectForKey:kAccountInfoPayPoints];
    self.city = [aDecoder decodeObjectForKey:kAccountInfoCity];
    self.status = [aDecoder decodeObjectForKey:kAccountInfoStatus];
    self.headimg = [aDecoder decodeObjectForKey:kAccountInfoHeadimg];
    self.lastTime = [aDecoder decodeObjectForKey:kAccountInfoLastTime];
    self.province = [aDecoder decodeObjectForKey:kAccountInfoProvince];
    self.froms = [aDecoder decodeObjectForKey:kAccountInfoFroms];
    self.userId = [aDecoder decodeObjectForKey:kAccountInfoUserId];
    self.lastLogin = [aDecoder decodeObjectForKey:kAccountInfoLastLogin];
    self.qq = [aDecoder decodeObjectForKey:kAccountInfoQq];
    self.msn = [aDecoder decodeObjectForKey:kAccountInfoMsn];
    self.creditLine = [aDecoder decodeObjectForKey:kAccountInfoCreditLine];
    self.isFenxiao = [aDecoder decodeObjectForKey:kAccountInfoIsFenxiao];
    self.visitCount = [aDecoder decodeObjectForKey:kAccountInfoVisitCount];
    self.mediaID = [aDecoder decodeObjectForKey:kAccountInfoMediaID];
    self.uToken = [aDecoder decodeObjectForKey:kAccountInfoUToken];
    self.question = [aDecoder decodeObjectForKey:kAccountInfoQuestion];
    self.password = [aDecoder decodeObjectForKey:kAccountInfoPassword];
    self.lastIp = [aDecoder decodeObjectForKey:kAccountInfoLastIp];
    self.isSurplusOpen = [aDecoder decodeObjectForKey:kAccountInfoIsSurplusOpen];
    self.isSpecial = [aDecoder decodeObjectForKey:kAccountInfoIsSpecial];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userRank forKey:kAccountInfoUserRank];
    [aCoder encodeObject:_alias forKey:kAccountInfoAlias];
    [aCoder encodeObject:_faceCard forKey:kAccountInfoFaceCard];
    [aCoder encodeObject:_aiteId forKey:kAccountInfoAiteId];
    [aCoder encodeObject:_frozenMoney forKey:kAccountInfoFrozenMoney];
    [aCoder encodeObject:_userMoney forKey:kAccountInfoUserMoney];
    [aCoder encodeObject:_country forKey:kAccountInfoCountry];
    [aCoder encodeObject:_card forKey:kAccountInfoCard];
    [aCoder encodeObject:_userName forKey:kAccountInfoUserName];
    [aCoder encodeObject:_addressId forKey:kAccountInfoAddressId];
    [aCoder encodeObject:_address forKey:kAccountInfoAddress];
    [aCoder encodeObject:_mediaUID forKey:kAccountInfoMediaUID];
    [aCoder encodeObject:_surplusPassword forKey:kAccountInfoSurplusPassword];
    [aCoder encodeObject:_nickname forKey:kAccountInfoNickname];
    [aCoder encodeObject:_rankPoints forKey:kAccountInfoRankPoints];
    [aCoder encodeObject:_flag forKey:kAccountInfoFlag];
    [aCoder encodeObject:_isValidated forKey:kAccountInfoIsValidated];
    [aCoder encodeObject:_regTime forKey:kAccountInfoRegTime];
    [aCoder encodeObject:_answer forKey:kAccountInfoAnswer];
    [aCoder encodeObject:_district forKey:kAccountInfoDistrict];
    [aCoder encodeObject:_phone forKey:kAccountInfoPhone];
    [aCoder encodeObject:_realName forKey:kAccountInfoRealName];
    [aCoder encodeObject:_parentId forKey:kAccountInfoParentId];
    [aCoder encodeObject:_sex forKey:kAccountInfoSex];
    [aCoder encodeObject:_salt forKey:kAccountInfoSalt];
    [aCoder encodeObject:_backCard forKey:kAccountInfoBackCard];
    [aCoder encodeObject:_email forKey:kAccountInfoEmail];
    [aCoder encodeObject:_birthday forKey:kAccountInfoBirthday];
    [aCoder encodeObject:_validated forKey:kAccountInfoValidated];
    [aCoder encodeObject:_payPoints forKey:kAccountInfoPayPoints];
    [aCoder encodeObject:_city forKey:kAccountInfoCity];
    [aCoder encodeObject:_status forKey:kAccountInfoStatus];
    [aCoder encodeObject:_headimg forKey:kAccountInfoHeadimg];
    [aCoder encodeObject:_lastTime forKey:kAccountInfoLastTime];
    [aCoder encodeObject:_province forKey:kAccountInfoProvince];
    [aCoder encodeObject:_froms forKey:kAccountInfoFroms];
    [aCoder encodeObject:_userId forKey:kAccountInfoUserId];
    [aCoder encodeObject:_lastLogin forKey:kAccountInfoLastLogin];
    [aCoder encodeObject:_qq forKey:kAccountInfoQq];
    [aCoder encodeObject:_msn forKey:kAccountInfoMsn];
    [aCoder encodeObject:_creditLine forKey:kAccountInfoCreditLine];
    [aCoder encodeObject:_isFenxiao forKey:kAccountInfoIsFenxiao];
    [aCoder encodeObject:_visitCount forKey:kAccountInfoVisitCount];
    [aCoder encodeObject:_mediaID forKey:kAccountInfoMediaID];
    [aCoder encodeObject:_uToken forKey:kAccountInfoUToken];
    [aCoder encodeObject:_question forKey:kAccountInfoQuestion];
    [aCoder encodeObject:_password forKey:kAccountInfoPassword];
    [aCoder encodeObject:_lastIp forKey:kAccountInfoLastIp];
    [aCoder encodeObject:_isSurplusOpen forKey:kAccountInfoIsSurplusOpen];
    [aCoder encodeObject:_isSpecial forKey:kAccountInfoIsSpecial];
}

- (id)copyWithZone:(NSZone *)zone
{
    AccountInfo *copy = [[AccountInfo alloc] init];
    
    if (copy) {

        copy.userRank = [self.userRank copyWithZone:zone];
        copy.alias = [self.alias copyWithZone:zone];
        copy.faceCard = [self.faceCard copyWithZone:zone];
        copy.aiteId = [self.aiteId copyWithZone:zone];
        copy.frozenMoney = [self.frozenMoney copyWithZone:zone];
        copy.userMoney = [self.userMoney copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.card = [self.card copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.addressId = [self.addressId copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.mediaUID = [self.mediaUID copyWithZone:zone];
        copy.surplusPassword = [self.surplusPassword copyWithZone:zone];
        copy.nickname = [self.nickname copyWithZone:zone];
        copy.rankPoints = [self.rankPoints copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.isValidated = [self.isValidated copyWithZone:zone];
        copy.regTime = [self.regTime copyWithZone:zone];
        copy.answer = [self.answer copyWithZone:zone];
        copy.district = [self.district copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.salt = [self.salt copyWithZone:zone];
        copy.backCard = [self.backCard copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.validated = [self.validated copyWithZone:zone];
        copy.payPoints = [self.payPoints copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.headimg = [self.headimg copyWithZone:zone];
        copy.lastTime = [self.lastTime copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.froms = [self.froms copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.lastLogin = [self.lastLogin copyWithZone:zone];
        copy.qq = [self.qq copyWithZone:zone];
        copy.msn = [self.msn copyWithZone:zone];
        copy.creditLine = [self.creditLine copyWithZone:zone];
        copy.isFenxiao = [self.isFenxiao copyWithZone:zone];
        copy.visitCount = [self.visitCount copyWithZone:zone];
        copy.mediaID = [self.mediaID copyWithZone:zone];
        copy.uToken = [self.uToken copyWithZone:zone];
        copy.question = [self.question copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.lastIp = [self.lastIp copyWithZone:zone];
        copy.isSurplusOpen = [self.isSurplusOpen copyWithZone:zone];
        copy.isSpecial = [self.isSpecial copyWithZone:zone];
    }
    
    return copy;
}

- (NSString *)headimg
{
    if (_headimg == nil || [_headimg isEqualToString:@""] || _headimg.length == 0)
    {
        _headimg = @"";
    }
    
    return _headimg;
}


@end
