//
//  AddFriendTableViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *friendIdTextField;

- (IBAction)searchFriendId:(id)sender;

@end
