//
//  RegisterViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 4/30/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "InternetHelper.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController {
    AppDelegate *delegate;
    AFHTTPSessionManager *manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    manager=delegate.manager;
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

- (IBAction)registerSubmit:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    [parameters setValue:_emailTextField.text forKey:@"mail"];
    [parameters setValue:_telephoneTextField.text forKey:@"phone"];
    [parameters setValue:_nameTextField.text forKey:@"name"];
    [parameters setValue:_passwordTextField.text forKey:@"password"];
    
    [manager POST:[InternetHelper createUrl:@"api/user/account/register"]
       parameters:parameters
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
              NSLog(@"error: %@", error);
              
          }];
    
}

- (IBAction)login:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
