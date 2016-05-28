//
//  FriendRequestTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "FriendRequestTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface FriendRequestTableViewController ()

@end

@implementation FriendRequestTableViewController {
    AFHTTPSessionManager *manager;
    DaoManager *dao;
    User *loginedUser;
    NSMutableArray *requestFriends;
    NSObject *selectedRequestFriend;
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
    [self loadRequestFriend];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return requestFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"friendRequestIdentifier"
                                                          forIndexPath:indexPath];
    UILabel *nameLabel=(UILabel *)[cell viewWithTag:1];
    UILabel *mailLabel=(UILabel *)[cell viewWithTag:2];
    NSObject *requestFriend=[requestFriends objectAtIndex:indexPath.row];
    nameLabel.text=[requestFriend valueForKey:@"name"];
    mailLabel.text=[requestFriend valueForKey:@"mail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    selectedRequestFriend=[requestFriends objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"friendRequestSegue" sender:self];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if([segue.identifier isEqualToString:@"friendRequestSegue"]) {
        UIViewController *controller=[segue destinationViewController];
        [controller setValue:selectedRequestFriend forKey:@"requestFriend"];
    }
}


#pragma mark - Action
- (IBAction)refreshFriendList:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [self loadRequestFriend];
}

- (void)loadRequestFriend {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [manager GET:[InternetHelper createUrl:[NSString stringWithFormat:@"api/user/friend/request"]]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *response=[InternetHelper getResponse:responseObject];
             if([[response valueForKey:@"status"] intValue]==200) {
                 requestFriends=[response valueForKey:@"body"];
             }
             [self.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(DEBUG) {
                 NSLog(@"Server Error: %@", error);
             }
         }];
}
@end
