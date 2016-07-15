//
//  LoginViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "LoginViewController.h"
#import "DaoManager.h"
#import "InternetHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    AFHTTPSessionManager *manager;
    DaoManager *dao;
}

- (void)viewDidLoad {
    if(DEBUG==1)
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    [super viewDidLoad];
    manager=[InternetHelper getSessionManager: nil];
    dao=[[DaoManager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    if(DEBUG==1)
        NSLog(@"Running %@ '%@'",self.class,NSStringFromSelector(_cmd));
    [super viewDidAppear:animated];
    //已有用户登录直接跳转到首页
    User *user=[dao.userDao getLoginedUser];
    if(user!=nil) {
        [InternetHelper getSessionManager:user.token];
        [self performSegueWithIdentifier:@"loginSuccessSegue" sender:self];
    }
}

#pragma mark - Action
- (IBAction)loginSubmit:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager POST:[InternetHelper createUrl:@"api/user/account/login"]
       parameters:@{
                    @"mail": _emailTextField.text,
                    @"password": _passwordTextField.text
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
              if([response status200]) {
                  NSManagedObjectID *uid = [dao.userDao saveOrUpdateWithJSONObject:[response getResponseBody]];
                  [dao.userDao setUserLogin:YES withUid:uid];
              }
              [self performSegueWithIdentifier:@"loginSuccessSegue" sender:self];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if(DEBUG) {
                  NSLog(@"Error: %@", error);
              }

          }];

}
@end
