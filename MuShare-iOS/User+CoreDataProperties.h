//
//  User+CoreDataProperties.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 6/18/16.
//  Copyright © 2016 limeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *avatar;
@property (nullable, nonatomic, retain) NSDate *birth;
@property (nullable, nonatomic, retain) NSString *describe;
@property (nullable, nonatomic, retain) NSNumber *gender;
@property (nullable, nonatomic, retain) NSNumber *login;
@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *screenName;
@property (nullable, nonatomic, retain) NSNumber *sid;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSSet<Friend *> *friends;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet<Friend *> *)values;
- (void)removeFriends:(NSSet<Friend *> *)values;

@end

NS_ASSUME_NONNULL_END
