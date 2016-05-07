//
//  AppDelegate.h
//  MuShare-iOS
//
//  Created by lidaye on 4/21/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "CoreDataHelper.h"

@interface AppDelegate: UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong,readonly) CoreDataHelper *coreDataHelper;
@property (nonatomic,strong) AFHTTPSessionManager *manager;

- (CoreDataHelper *)cdh;
@end

