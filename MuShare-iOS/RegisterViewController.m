//
//  RegisterViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 4/30/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController {
    AppDelegate *delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [parameters setValue:_emailTextField.text forKey:@"email"];
    [parameters setValue:_userIdTextField.text forKey:@"name"];
    [parameters setValue:_nameTextField.text forKey:@"screen_name"];
    [parameters setValue:_passwordTextField.text forKey:@"password"];
    [delegate.manager POST:@"http://test.mushare.cn/user/register"
                parameters:parameters
                  progress:nil
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       NSLog(@"JSON: %@", responseObject);
                   }
                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       NSLog(@"Error: %@", error);
                   }];
}

- (IBAction)login:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
