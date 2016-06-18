//
//  Friend+CoreDataProperties.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 6/18/16.
//  Copyright © 2016 limeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createAt;
@property (nullable, nonatomic, retain) User *friend;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
