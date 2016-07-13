//
//  UserDao.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "DaoTemplate.h"

#define UserEntityName @"User"

@interface UserDao : DaoTemplate

- (NSManagedObjectID *)saveWithMail:(NSString *)mail
                       andTelephone:(NSString *)telephone
                            andName:(NSString *)name
                      andScreenName:(NSString *)screenName
                          andGender:(NSNumber *)gender
                        andDescribe:(NSString *)describe
                           andBirth:(NSDate *)birth
                          andAvatar:(NSString *)avatar
                           andToken:(NSString *)token
                             andSid:(NSNumber *)sid;

//通过email得到用户
- (User *)getByMail:(NSString *)mail;

//得到当前登录的用户
- (User *)getLoginedUser;

//设置用户在iOS客户端的登录状态
- (void)setUserLogin:(BOOL)login withUid:(NSManagedObjectID *)uid;

- (User *)getBySid:(NSNumber *)sid;

@end
