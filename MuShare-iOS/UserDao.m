//
//  UserDao.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "UserDao.h"

@implementation UserDao

- (NSManagedObjectID *)saveWithMail:(NSString *)mail
                       andTelephone:(NSString *)phone
                            andName:(NSString *)name
                      andScreenName:(NSString *)screenName
                          andGender:(NSNumber *)gender
                        andDescribe:(NSString *)describe
                           andBirth:(NSDate *)birth
                          andAvatar:(NSString *)avatar
                           andToken:(NSString *)token
                             andSid:(NSNumber *)sid {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    User *user=[NSEntityDescription insertNewObjectForEntityForName:UserEntityName
                                             inManagedObjectContext:self.context];
    user.mail=mail;
    user.phone=phone;
    user.screenName=screenName;
    user.name=screenName;
    user.gender=gender;
    user.describe=describe;
    user.birth=birth;
    user.avatar=avatar;
    user.token=token;
    user.sid=sid;
    [self saveContext];
    return user.objectID;
}

- (User *)getByMail:(NSString *)mail {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    return (User *)[self getByPredicate:[NSPredicate predicateWithFormat:@"mail=%@",mail]
                         withEntityName:UserEntityName];
    
}

- (User *)getLoginedUser {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    return (User *)[self getByPredicate:[NSPredicate predicateWithFormat:@"login=%@",[NSNumber numberWithBool:YES]]
                         withEntityName:UserEntityName];
}

-(void)setUserLogin:(BOOL)login withUid:(NSManagedObjectID *)uid {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:UserEntityName];
    NSArray *allUser=[self.context executeFetchRequest:request error:nil];
    for(User *user in allUser) {
        user.login=[NSNumber numberWithBool:NO];
    }
    User *user=(User *)[self.context existingObjectWithID:uid error:nil];
    user.login=[NSNumber numberWithBool:YES];
    [self saveContext];
}

@end
