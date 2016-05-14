//
//  InternetHelper.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "InternetHelper.h"

#define Domain @"test.mushare.cn"

@implementation InternetHelper

+ (AFHTTPSessionManager *)getSessionManager {
    if(DEBUG==1) {
         NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    AppDelegate *delegate=[[UIApplication sharedApplication] delegate];
    return delegate.manager;
}

+ (NSString *)createUrl:(NSString *)relativePosition {
    NSString *url=[NSString stringWithFormat:@"http://%@/%@",Domain,relativePosition];
    if(DEBUG==1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"Request URL is: %@",url);
    }
    return url;
}

+ (NSDictionary *)getResponse:(id)responseObject {
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"Get Message from server: %@", response);
    }
    return response;
}
@end
