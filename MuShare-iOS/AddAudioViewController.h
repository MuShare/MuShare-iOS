//
//  AddAudioViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 8/11/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaoManager.h"

@interface AddAudioViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Sheet *sheet;

@property (weak, nonatomic) IBOutlet UITextField *audioNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *audioCoverImageView;

- (IBAction)saveAudio:(id)sender;
- (IBAction)chooseAudioCover:(id)sender;

@end
