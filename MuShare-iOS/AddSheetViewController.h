//
//  AddSheetViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 5/28/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSheetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *privilegeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *sheetNameTextField;

- (IBAction)addSheet:(id)sender;

@end
