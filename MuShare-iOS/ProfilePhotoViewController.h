//
//  ProfilePhotoViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/16/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;

- (IBAction)editProfilePhoto:(id)sender;

@end
