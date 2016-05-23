//
//  AddFriendTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AddFriendTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface AddFriendTableViewController ()

@end

@implementation AddFriendTableViewController {
    AFHTTPSessionManager *manager;
    DaoManager *dao;
    User *loginedUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dao=[[DaoManager alloc] init];
    loginedUser=[dao.userDao getLoginedUser];
    manager=[InternetHelper getSessionManager: loginedUser.token];
}


#pragma mark - Action
- (IBAction)searchFriendId:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager POST:[InternetHelper createUrl:@"api/user/friend/request"]
       parameters:@{
                    @"friendId": [NSNumber numberWithInt:_friendIdTextField.text.intValue]
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
              if(DEBUG) {
                  NSLog(@"Get Message from server: %@", response);
              }
              if([[response valueForKey:@"status"] intValue]==200) {
                  UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Tip"
                                                                                         message:[NSString stringWithFormat:@"Send request to %@", _friendIdTextField.text]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:nil];
                  [alertController addAction:cancelAction];
                  [self presentViewController:alertController animated:YES completion:nil];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if(DEBUG) {
                  NSLog(@"Server Error: %@", error);
              }
          }];
}
@end
