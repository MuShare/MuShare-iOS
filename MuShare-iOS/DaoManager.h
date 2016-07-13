//
//  DaoManager.h
//  AccountManagement
//
//  Created by 李大爷 on 15/5/4.
//  Copyright (c) 2015年 李大爷. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserDao.h"
#import "FriendDao.h"
#import "SheetDao.h"

@interface DaoManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *context;

@property (strong, nonatomic) UserDao *userDao;
@property (strong, nonatomic) FriendDao *friendDao;
@property (strong, nonatomic) SheetDao *sheetDao;

-(NSManagedObject *)getObjectById:(NSManagedObjectID *)objectID;
- (void)saveContext;

@end
