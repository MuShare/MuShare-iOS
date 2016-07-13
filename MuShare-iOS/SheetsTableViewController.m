//
//  SheetsTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "SheetsTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface SheetsTableViewController ()

@end

@implementation SheetsTableViewController {
    DaoManager *dao;
    AFHTTPSessionManager *manager;
    User *loginedUser;
    NSMutableArray *sheets;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    dao=[[DaoManager alloc] init];
    manager=[InternetHelper getSessionManager:nil];
    loginedUser=[dao.userDao getLoginedUser];
    [self loadSheets];
}

- (void)viewDidAppear:(BOOL)animated {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    sheets = [NSMutableArray arrayWithArray:[dao.sheetDao findByUser:loginedUser]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return sheets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetIdentifier"
                                                            forIndexPath:indexPath];
    Sheet *sheet = [sheets objectAtIndex:indexPath.row];
    UILabel *sheetNameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *privilegeLabel = (UILabel *)[cell viewWithTag:2];
    sheetNameLabel.text = sheet.name;
    privilegeLabel.text = sheet.privilege;
    return cell;
}

#pragma mark - Service
- (void) loadSheets {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager GET:[InternetHelper createUrl:[NSString stringWithFormat:@"api/music/sheet/list?ToID=%@", loginedUser.sid]]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
             NSArray *objects = [response getResponseBody];
             for(NSObject *object in objects) {
                 [dao.sheetDao saveOrUpdateWithName:[object valueForKey:@"name"]
                                       andPrivilege:[object valueForKey:@"privilege"]
                                             andSid:[NSNumber numberWithInt:[[object valueForKey:@"id"] intValue]]
                                            forUser:[dao.userDao getBySid:[NSNumber numberWithInt:[[object valueForKey:@"userId"] intValue]]]];
             }
             sheets = [NSMutableArray arrayWithArray:[dao.sheetDao findByUser:loginedUser]];
             [self.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(DEBUG) {
                 NSLog(@"Server Error: %@", error);
             }
         }];
}

@end
