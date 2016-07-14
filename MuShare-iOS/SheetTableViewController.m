//
//  SheetTableViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/13/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "SheetTableViewController.h"
#import "InternetHelper.h"

@interface SheetTableViewController ()

@end

@implementation SheetTableViewController {
    AFHTTPSessionManager *manager;
}

- (void)viewDidLoad {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    self.title = _sheet.name;
    manager = [InternetHelper getSessionManager:nil];
    [manager GET:[InternetHelper createUrl:@"api/music/audio/list"]
      parameters:@{@"SheetID": _sheet.sid}
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if(DEBUG) {
                 NSLog(@"Server error: %@", error);
             }
         }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    return 0;
}
@end
