
//
//  AddSheetTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 8/11/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AddSheetTableViewController.h"
#import "InternetHelper.h"
#import "DaoManager.h"

@interface AddSheetTableViewController ()

@end

NSString * const privileges[] = {@"public", @"private", @"friend"};

@implementation AddSheetTableViewController {
    NSString *privilege;
    AFHTTPSessionManager *manager;
    DaoManager *dao;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    privilege = privileges[0];
    dao = [[DaoManager alloc] init];
    manager = [InternetHelper getSessionManager:nil];
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if(indexPath.section == 0) {
        privilege = privileges[indexPath.row];
        _publicTableViewCell.accessoryType = UITableViewCellAccessoryNone;
        _privateTableViewCell.accessoryType = UITableViewCellAccessoryNone;
        _friendTableViewCell.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            case 0:
                _publicTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            case 1:
                _privateTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            case 2:
                _friendTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            default:
                break;
        }
    }
}

#pragma mark - Action
- (IBAction)addSheet:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if ([_sheetNameTextField.text isEqualToString:@""]) {
        
        return;
    }
    [manager POST:[InternetHelper createUrl:@"api/music/sheet/create"]
       parameters:@{
                    @"name": _sheetNameTextField.text,
                    @"privilege": privilege
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
              if([response status200]) {
                  NSObject *object = [response getResponseBody];
                  [dao.sheetDao saveOrUpdateWithName:[object valueForKey:@"name"]
                                        andPrivilege:[object valueForKey:@"privilege"]
                                              andSid:[NSNumber numberWithInt:[[object valueForKey:@"id"] intValue]]
                                             forUser:[dao.userDao getBySid:[NSNumber numberWithInt:[[object valueForKey:@"userId"] intValue]]]];
                  [self.navigationController popViewControllerAnimated:YES];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if(DEBUG) {
                  NSLog(@"Server Error: %@", error.localizedDescription);
              }
              InternetResponse *response = [[InternetResponse alloc] initWithError:error];
              switch ([response errorCode]) {

                  default:
                      break;
              }
          }];
}
@end
