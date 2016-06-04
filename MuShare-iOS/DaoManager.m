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
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    self=[super init];
    if(self) {
        _context=[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        _userDao=[[UserDao alloc] initWithManagedObjectContext:_context];
    }
    return self;
}

-(NSManagedObject *)getObjectById:(NSManagedObjectID *)objectID {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    }
    return [_context existingObjectWithID:objectID error:nil];
}

- (void)saveContext{
    if(DEBUG==1)
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    if ([_context hasChanges]) {
        NSError *error=nil;
        if([_context save:&error]) {
            if(DEBUG==1)
                NSLog(@"_context saved changes to persistent store.");
        }
        else
            NSLog(@"Failed to save _context : %@",error);
    }else{
        NSLog(@"Skipped _context save, there are no changes.");
    }
}

@end
