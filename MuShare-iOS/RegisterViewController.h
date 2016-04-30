//
//  RegisterViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 4/30/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)registerSubmit:(id)sender;
- (IBAction)login:(id)sender;

@end
