//
//  AddSheetViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AddSheetViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface AddSheetViewController ()

@end

@implementation AddSheetViewController {
    NSString *privilege;
    AFHTTPSessionManager *manager;
    DaoManager *dao;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    manager = [InternetHelper getSessionManager:nil];
    dao = [[DaoManager alloc] init];
    privilege=@"public";
    [_privilegeSegmentedControl addTarget:self
                                   action:@selector(privilegeSelected:)
                         forControlEvents:UIControlEventValueChanged];
}

- (void)privilegeSelected:(UISegmentedControl *)sender{
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    switch (sender.selectedSegmentIndex) {
        case 0:
            privilege=@"public";
            break;
        case 1:
            privilege=@"private";
            break;
        case 2:
            privilege=@"friend";
            break;
        default:
            break;
    }
}

#pragma mark - Action
- (IBAction)addSheet:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSString *sheetName=_sheetNameTextField.text;
    [manager POST:[InternetHelper createUrl:@"api/music/sheet/create"]
       parameters:@{
                    @"name": sheetName,
                    @"privilege": privilege
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
              if([response status200]) {
                  NSObject *object = [response getResponseBody];
                  [dao.sheetDao savwWithName:[object valueForKey:@"name"]
                                andPrivilege:[object valueForKey:@"privilege"]
                                      andSid:[NSNumber numberWithInt:[[object valueForKey:@"id"] intValue]]
                                     forUser:[dao.userDao getBySid:[NSNumber numberWithInt:[[object valueForKey:@"userId"] intValue]]]];
                  [self.navigationController popViewControllerAnimated:YES];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if(DEBUG) {
                  NSLog(@"Server Error: %@", error);
              }
          }];
}
@end
