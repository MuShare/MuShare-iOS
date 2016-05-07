//
//  LoginViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/7/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
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
    manager=[InternetHelper getSessionManager];
    dao=[[DaoManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginSubmit:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setValue:_emailTextField.text forKey:@"mail"];
    [parameters setValue:_passwordTextField.text forKey:@"password"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"http://test.mushare.cn/api/user/account/login"
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
              if(DEBUG) {
                  NSLog(@"%@", response);
              }
              NSDictionary *body=[response valueForKey:@"body"];
              User *user=(User *)[dao.userDao getByMail:[body valueForKey:@"mail"]];
              if(user==nil) {
                  NSManagedObjectID *uid=[dao.userDao saveWithMail:[body valueForKey:@"mail"]
                                                      andTelephone:[body valueForKey:@"phone"]
                                                           andName:[body valueForKey:@"name"]
                                                     andScreenName:[body valueForKey:@"screenName"]
                                                         andGender:[NSNumber numberWithInt:[[body valueForKey:@"gender"] intValue]]
                                                       andDescribe:[body valueForKey:@"description"]
                                                          andBirth:nil
                                                         andAvatar:[body valueForKey:@"avatar"]
                                                          andToken:[body valueForKey:@"token"]
                                                            andSid:[NSNumber numberWithInt:[[body valueForKey:@"sid"] intValue]]];
                  [dao.userDao setUserLogin:YES withUid:uid];
              } else {
                  user.mail=[body valueForKey:@"mail"];
                  user.phone=[body valueForKey:@"phone"];
                  user.name=[body valueForKey:@"name"];
                  user.screenName=[body valueForKey:@"screenName"];
                  user.gender=[NSNumber numberWithInt:[[body valueForKey:@"gender"] intValue]];
                  user.describe=[body valueForKey:@"description"];
                  user.birth=nil;
                  user.avatar=[body valueForKey:@"avatar"];
                  user.token=[body valueForKey:@"token"];
                  [dao.cdh saveContext];
                  [dao.userDao setUserLogin:YES withUid:user.objectID];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"error: %@", error);
          }];

}
@end