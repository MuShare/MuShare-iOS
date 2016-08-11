//
//  AddAudioViewController.m
//  MuShare-iOS
//
//  Created by 李大爷的电脑 on 8/11/16.
//  Copyright © 2016 limeng. All rights reserved.
//

#import "AddAudioViewController.h"
#import "InternetHelper.h"
#import "AlertTool.h"

@interface AddAudioViewController ()

@end

@implementation AddAudioViewController {
    AFHTTPSessionManager *manager;
    UIImagePickerController *imagePickerController;
}

- (void)viewDidLoad {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [super viewDidLoad];
    
    manager = [InternetHelper getSessionManager:nil];
    
    //Init ImagePickerController
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
        NSLog(@"MediaInfo: %@", info);
    }
    // 获取用户拍摄的是照片还是视频
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        _audioCoverImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    //Hide UIImagePickerController
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    //Upload image to aliyun OSS
    if(_audioCoverImageView.image != nil) {
        
    }
}

#pragma mark - Action
- (IBAction)saveAudio:(id)sender {
    if (DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if([_audioNameTextField.text isEqualToString:@""]) {
        
        return;
    }
    [manager POST:[InternetHelper createUrl:@"api/music/audio/addEmptyAudio"]
       parameters:@{
                    @"name": _audioNameTextField.text,
                    @"sheetId": _sheet.sid
                    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              InternetResponse *response = [[InternetResponse alloc] initWithResponseObject:responseObject];
              if([response status200]) {
                  
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              InternetResponse *response = [[InternetResponse alloc] initWithError:error];
              switch ([response errorCode]) {
                      
                  default:
                      break;
              }
          }];
}

- (IBAction)chooseAudioCover:(id)sender {
    if(DEBUG) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit Profile Photo"
                                                                             message:@"Choose a photo from library or take a photo."
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Take Photo"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                              // 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
                                                              imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
                                                              // 设置模式为拍摄照片
                                                              imagePickerController.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
                                                              // 设置使用手机的后置摄像头（默认使用后置摄像头）
                                                              imagePickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;
                                                              // 设置拍摄的照片允许编辑
                                                              imagePickerController.allowsEditing=YES;
                                                          }else{
                                                              if(DEBUG) {
                                                                  NSLog(@"iOS Simulator cannot open camera.");
                                                              }
                                                              [AlertTool showAlertWithTitle:@"Warning"
                                                                                 andContent:@"iOS Simulator cannot open camera."
                                                                           inViewController:self];
                                                          }
                                                          // 显示picker视图控制器
                                                          [self presentViewController:imagePickerController animated: YES completion:nil];
                                                      }];
    
    UIAlertAction *choose = [UIAlertAction actionWithTitle:@"Choose from Photos"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       // 设置选择载相册的图片
                                                       imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                       imagePickerController.allowsEditing = YES;
                                                       // 显示picker视图控制器
                                                       [self presentViewController:imagePickerController animated: YES completion:nil];
                                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alertController addAction:takePhoto];
    [alertController addAction:choose];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
