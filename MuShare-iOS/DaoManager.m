//
//  DaoManager.m
//  AccountManagement
//
//  Created by 李大爷 on 15/5/4.
//  Copyright (c) 2015年 李大爷. All rights reserved.
//

#import "DaoManager.h"

@implementation DaoManager

-(id)init {
    if(DEBUG==1)
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    self=[super init];
    self.userDao=[[UserDao alloc] init];
    self.cdh=[(AppDelegate *)[[UIApplication sharedApplication] delegate] cdh];
    return self;
}

-(NSManagedObject *)getObjectById:(NSManagedObjectID *)objectID {
    return [self.cdh.context existingObjectWithID:objectID error:nil];
}
@end
