//
//  AddSheetTableViewController.h
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 8/11/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSheetTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *sheetNameTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell *publicTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *privateTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *friendTableViewCell;
- (IBAction)addSheet:(id)sender;

@end
