//
//  FriendRequestViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/21/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "FriendRequestViewController.h"
#import "InternetHelper.h"

@interface FriendRequestViewController ()

@end

@implementation FriendRequestViewController {
    AFHTTPSessionManager *manager;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    manager=[InternetHelper getSessionManager:nil];
    
    _nameLabel.text=[_requestFriend valueForKey:@"name"];
    _mailLabel.text=[_requestFriend valueForKey:@"mail"];
    _phoneLabel.text=[_requestFriend valueForKey:@"phone"];
}

#pragma mark - Action
- (IBAction)agreeFriendRequest:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager PUT:[InternetHelper createUrl:@"api/user/friend/request"]
      parameters:@{@"friendId": [_requestFriend valueForKey:@"id"]}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *response=[InternetHelper getResponse:responseObject];
             if([[response valueForKey:@"status"] intValue]==200) {
                 
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(DEBUG) {
                 NSLog(@"Server Error: %@", error);
             }
         }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
}
@end
