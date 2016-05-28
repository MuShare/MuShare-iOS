//
//  FriendDao.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "DaoTemplate.h"
#import "User.h"
#import "Friend.h"

#define FriendEntityName @"Friend"

@interface FriendDao : DaoTemplate

- (NSManagedObjectID *)saveWithUser:(User *)me
                          andFriend:(User *)friendUser;

@end
