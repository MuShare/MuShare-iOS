//
//  UserDao.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "UserDao.h"

@implementation UserDao

- (NSManagedObjectID *)saveOrUpdateWithJSONObject:(NSObject *)object {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    User *user = [self getByMail:[object valueForKey:@"mail"]];
    if(user == nil) {
        user=[NSEntityDescription insertNewObjectForEntityForName:UserEntityName
                                           inManagedObjectContext:self.context];
    }
    user.mail = [object valueForKey:@"mail"];
    user.phone = [object valueForKey:@"phone"];
    user.name = [object valueForKey:@"name"];
    user.screenName = [object valueForKey:@"screenName"];
    user.gender = [NSNumber numberWithInt:[[object valueForKey:@"gender"] intValue]];
    user.describe = [object valueForKey:@"description"];
    user.birth = nil;
    user.avatar = [object valueForKey:@"avatar"];
    user.token = [object valueForKey:@"token"];
    user.sid = [NSNumber numberWithInt:[[object valueForKey:@"id"] intValue]];

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

- (void)setUserLogin:(BOOL)login withUid:(NSManagedObjectID *)uid {
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

- (User *)getBySid:(NSNumber *)sid {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    return (User *)[self getByPredicate:[NSPredicate predicateWithFormat:@"sid=%@", sid]
                         withEntityName:UserEntityName];
}

@end
