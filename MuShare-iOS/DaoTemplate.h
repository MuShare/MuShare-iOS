//
//  DaoTemplate.h
//  AccountManagement
//
//  Created by 李大爷 on 15/4/26.
//  Copyright (c) 2015年 李大爷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "User.h"
#import "Friend.h"
#import "Sheet.h"

#define DAO_DEBUG 0

@interface DaoTemplate : NSObject

@property (nonatomic,readonly) NSManagedObjectContext *context;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (void)saveContext;

//通过谓词和实体名称查询一个托管对象
-(NSManagedObject *)getByPredicate:(NSPredicate *)predicate
                    withEntityName:(NSString *)entityName;

//通过谓词、排序规则和实体名称查询一个托管对象
-(NSManagedObject *)getByPredicate:(NSPredicate *)predicate
                    withEntityName:(NSString *)entityName
                           orderBy:(NSSortDescriptor *)sortDescriptor;

//通过谓词和实体名称查询一个托管对象数组
-(NSArray *)findByPredicate:(NSPredicate *)predicate
             withEntityName:(NSString *)entityName;

//通过谓词、排序规则和实体名称查询一个托管对象数组
-(NSArray *)findByPredicate:(NSPredicate *)predicate
             withEntityName:(NSString *)entityName
                    orderBy:(NSSortDescriptor *)sortDescriptor;

@end
