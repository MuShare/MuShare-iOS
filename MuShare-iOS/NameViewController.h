//
//  NameViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 7/14/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)saveName:(id)sender;

@end
