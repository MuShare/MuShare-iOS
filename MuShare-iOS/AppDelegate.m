//
//  AppDelegate.m
//  MuShare-iOS
//
//  Created by lidaye on 4/21/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AppDelegate.h"
#import "DaoManager.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize managedObjectContext = managedObjectContext;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    self.manager=[AFHTTPSessionManager manager];
    self.manager.responseSerializer=[[AFCompoundResponseSerializer alloc] init];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self setupContext];
    
    [self setRootViewControllerWithIdentifer:@"loginViewController"];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
}

#pragma mark - Service
- (void)setRootViewControllerWithIdentifer:(NSString *)identifer {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:identifer];
    [self.window makeKeyAndVisible];
}

#pragma mark - CoreDate Stack
- (void)setupContext {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSError *error;
    NSURL *modelURL=[[NSBundle mainBundle] URLForResource:@"Model"
                                            withExtension:@"momd"];
    NSManagedObjectModel *model=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSDictionary *options=@{
                            NSMigratePersistentStoresAutomaticallyOption: @YES,
                            NSInferMappingModelAutomaticallyOption: @YES
                            };
    NSURL *storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:@"store.sqlite"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:storeURL
                                    options:options
                                      error:&error];
    if(error) {
        NSLog(@"Error: %@", error.localizedDescription);
        return;
    }
    managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.persistentStoreCoordinator=coordinator;
    managedObjectContext.mergePolicy=NSMergeByPropertyObjectTrumpMergePolicy;
}

@end
