//
//  FriendRequestViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/21/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendRequestViewController : UIViewController

@property (nonatomic, strong) NSObject *requestFriend;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

- (IBAction)agreeFriendRequest:(id)sender;

@end
