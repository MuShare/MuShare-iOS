//
//  Sheet+CoreDataProperties.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/13/16.
//  Copyright © 2016 limeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Sheet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sheet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *sid;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *privilege;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
