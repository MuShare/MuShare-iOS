//
//  FriendDao.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "FriendDao.h"

@implementation FriendDao

- (NSManagedObjectID *)saveWithUser:(User *)me andFriend:(User *)friendUser {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    Friend *friend=[NSEntityDescription insertNewObjectForEntityForName:FriendEntityName
                                                 inManagedObjectContext:self.context];
    friend.user=me;
    friend.friend=friendUser;
    friend.createAt=[[NSDate alloc] init];
    [self saveContext];
    return friend.objectID;
}

@end
