//
//  AddFriendTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AddFriendTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"
#import "AlertTool.h"

@interface AddFriendTableViewController ()

@end

@implementation AddFriendTableViewController {
    AFHTTPSessionManager *manager;
    DaoManager *dao;
    User *loginedUser;
    NSArray *users;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    dao = [[DaoManager alloc] init];
    loginedUser = [dao.userDao getLoginedUser];
    manager = [InternetHelper getSessionManager:nil];
}



#pragma mark - UITableViewDataSource
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    //Clear header view color
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userIdentifier"
                                                            forIndexPath:indexPath];
    NSObject *user = [users objectAtIndex:indexPath.row];
    //UIImageView *avatarImageView = (UIImageView *)[cell viewWithTag:0];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *emailLabel = (UILabel *)[cell viewWithTag:2];
    nameLabel.text = [user valueForKey:@"name"];
    emailLabel.text = [user valueForKey:@"mail"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    NSObject *user = [users objectAtIndex:indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Friend"
                                                                             message:[NSString stringWithFormat:@"Send a request to %@", [user valueForKey:@"name"]]
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Send Request"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
        [manager POST:[InternetHelper createUrl:@"api/user/friend/request"]
           parameters:@{
                        @"friendId": [user valueForKey:@"id"]                                                                        }
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSDictionary *response=[InternetHelper getResponse:responseObject];
                  if([[response valueForKey:@"status"] intValue]==200) {
                      [AlertTool showAlertWithTitle:@"Tip"
                                         andContent:[NSString stringWithFormat:@"Send a request to %@", [user valueForKey:@"name"]]
                                   inViewController:self];
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  if(DEBUG) {
                      NSLog(@"Server Error: %@", error);
                  }
              }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Action
- (IBAction)searchFriendId:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [_friendIdTextField resignFirstResponder];
    if([_friendIdTextField.text isEqualToString:@""]) {
        //Alert friend name not empty.
        [AlertTool showAlertWithTitle:@"Tip"
                           andContent:@"Friend name cannot be empty!"
                     inViewController:self];
        return;
    }
    [manager GET:[InternetHelper createUrl:@"api/user/search/stranger"]
      parameters:@{
                   @"keyword": _friendIdTextField.text
                   }
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *response=[InternetHelper getResponse:responseObject];
             if([[response valueForKey:@"status"] intValue]==200) {
                 users = [response valueForKey:@"body"];
                 [self.tableView reloadData];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(DEBUG) {
                 NSLog(@"Server Error: %@", error);
             }
         }];
}
@end
