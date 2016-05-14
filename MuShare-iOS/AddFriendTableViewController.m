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
    manager=[InternetHelper getSessionManager];
    dao=[[DaoManager alloc] init];
    loginedUser=[dao.userDao getLoginedUser];
}


#pragma mark - Action
- (IBAction)searchFriendId:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setValue:loginedUser.sid forKey:@"fromId"];
    [parameters setValue:[NSNumber numberWithInt:_friendIdTextField.text.intValue] forKey:@"toId"];
    [parameters setValue:loginedUser.token forKey:@"token"];
    NSLog(@"%@", parameters);
    [manager POST:[InternetHelper createUrl:@"api/user/friend/request"]
       parameters:parameters
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
