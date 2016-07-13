//
//  SheetDao.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/13/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "SheetDao.h"

@implementation SheetDao

- (NSManagedObjectID *)savwWithName:(NSString *)name
                       andPrivilege:(NSString *)privilege
                             andSid:(NSNumber *)sid
                            forUser:(User *)user {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    Sheet *sheet = [NSEntityDescription insertNewObjectForEntityForName:SheetEntityName
                                                 inManagedObjectContext:self.context];
    sheet.name = name;
    sheet.privilege = privilege;
    sheet.sid = sid;
    sheet.user = user;
    [self saveContext];
    return sheet.objectID;
}

@end
