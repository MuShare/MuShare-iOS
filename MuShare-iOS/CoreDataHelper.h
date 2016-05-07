//
//  CoreDataHelper.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define StoreFileName @"musahre.sqlite"

@interface CoreDataHelper : NSObject<NSXMLParserDelegate>

@property (nonatomic,readonly) NSManagedObjectContext *context;
@property (nonatomic,readonly) NSManagedObjectModel *model;
@property (nonatomic,readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic,readonly) NSPersistentStore *store;

@property (nonatomic,readonly) NSManagedObjectContext *importContext;

@property (nonatomic,strong) NSXMLParser *parser;

-(void)setupCoreData;
-(void)saveContext;

@end
