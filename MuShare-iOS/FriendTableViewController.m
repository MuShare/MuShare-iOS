//
//  FriendTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "FriendTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface FriendTableViewController ()

@end

@implementation FriendTableViewController {
    AFHTTPSessionManager *manager;
    DaoManager *dao;
    User *loginedUser;
    NSMutableArray *myFriends;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    dao=[[DaoManager alloc] init];
    loginedUser=[dao.userDao getLoginedUser];
    manager=[InternetHelper getSessionManager: loginedUser.token];
    
}

- (void)viewDidAppear:(BOOL)animated {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidAppear:animated];
    [self loadFriend];
}

#pragma mark - Table view data source
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
    return myFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"friendIdentifier"
                                                          forIndexPath:indexPath];
    UILabel *nameLabel=(UILabel *)[cell viewWithTag:1];
    UILabel *mailLabel=(UILabel *)[cell viewWithTag:2];
    NSObject *friend=[myFriends objectAtIndex:indexPath.row];
    nameLabel.text=[friend valueForKey:@"name"];
    mailLabel.text=[friend valueForKey:@"mail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if(editingStyle==UITableViewCellEditingStyleDelete) {

        [manager DELETE:[InternetHelper createUrl:@"api/user/friend/delete"]
             parameters:@{@"friendId": [[myFriends objectAtIndex:indexPath.row] valueForKey:@"id"]}
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *response=[InternetHelper getResponse:responseObject];
                    if([[response valueForKey:@"status"] intValue]==200) {
                        [myFriends removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                         withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if(DEBUG) {
                        NSLog(@"Server Error: %@", error);
                    }
                }];
            }
}


#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
}

#pragma mark - Action

- (void)loadFriend {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [manager GET:[InternetHelper createUrl:@"api/user/friend/list"]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *response=[InternetHelper getResponse:responseObject];
             if([[response valueForKey:@"status"] intValue]==200) {
                 myFriends=[response valueForKey:@"body"];
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
