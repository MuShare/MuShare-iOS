//
//  InternetHelper.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "InternetResponse.h"

@interface InternetHelper : NSObject

+ (AFHTTPSessionManager *)getSessionManager:(NSString *)token;

//创建访问服务器的url
+ (NSString *)createUrl:(NSString *)relativePosition;

+ (NSDictionary *)getResponse:(id  _Nullable )responseObject;

@end
