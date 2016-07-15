//
//  NameViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "NameViewController.h"
#import "DaoManager.h"
#import "AlertTool.h"

@interface NameViewController ()

@end

@implementation NameViewController {
    DaoManager *dao;
    User *loginedUser;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    dao = [[DaoManager alloc] init];
    loginedUser = [dao.userDao getLoginedUser];
    _nameTextField.text = loginedUser.name;
}


#pragma mark - Action
- (IBAction)saveName:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if([_nameTextField.text isEqualToString:@""]) {
        [AlertTool showAlertWithTitle:@"Warning"
                           andContent:@"User name cannot be empty!"
                     inViewController:self];
        return;
    }
    loginedUser.name = _nameTextField.text;
    [dao saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
