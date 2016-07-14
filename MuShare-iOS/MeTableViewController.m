//
//  MeTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "MeTableViewController.h"
#import "DaoManager.h"

@interface MeTableViewController ()

@end

@implementation MeTableViewController {
    DaoManager *dao;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    dao = [[DaoManager alloc] init];
    User *user = [dao.userDao getLoginedUser];
    _nameLabel.text = user.name;
    _mailLabel.text = user.mail;
}

@end
