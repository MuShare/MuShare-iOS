//
//  RegisterViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 4/30/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "RegisterViewController.h"
#import "InternetHelper.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController {
    AFHTTPSessionManager *manager;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    manager=[InternetHelper getSessionManager:nil];
}

#pragma mark - Action
- (IBAction)registerSubmit:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager POST:[InternetHelper createUrl:@"api/user/account/register"]
       parameters:@{
                    @"mail":_emailTextField.text,
                    @"phone":_telephoneTextField.text,
                    @"name":_nameTextField.text,
                    @"password":_passwordTextField.text
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
              if(DEBUG) {
                  NSLog(@"Get response from server: %@", response);
              }
              if([[response valueForKey:@"status"] intValue]==200) {
                  [self dismissViewControllerAnimated:YES
                                           completion:nil];
              } 
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if(DEBUG) {
                  NSLog(@"Error: %@", error);
              }
          }];
    
}

- (IBAction)login:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
