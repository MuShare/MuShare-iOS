//
//  SheetDao.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/13/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "SheetDao.h"

@implementation SheetDao

- (NSManagedObjectID *)saveOrUpdateWithName:(NSString *)name
                               andPrivilege:(NSString *)privilege
                                     andSid:(NSNumber *)sid
                                    forUser:(User *)user {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    Sheet *sheet = [self getBySid:sid];
    if(sheet == nil) {
        sheet = [NSEntityDescription insertNewObjectForEntityForName:SheetEntityName
                                              inManagedObjectContext:self.context];
    }
    sheet.name = name;
    sheet.privilege = privilege;
    sheet.sid = sid;
    sheet.user = user;
    [self saveContext];
    return sheet.objectID;
}

- (Sheet *)getBySid:(NSNumber *)sid {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return (Sheet *)[self getByPredicate:[NSPredicate predicateWithFormat:@"sid=%@", sid]
                          withEntityName:SheetEntityName];
}

- (NSArray *)findByUser:(User *)user {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return [self findByPredicate:[NSPredicate predicateWithFormat:@"user=%@", user]
                  withEntityName:SheetEntityName
                         orderBy:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

@end
