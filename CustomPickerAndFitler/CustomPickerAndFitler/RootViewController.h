//
//  RootViewController.h
//  CustomPickerAndFitler
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"

@interface RootViewController : UIViewController
<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate>
{
    IBOutlet UIImageView *imageView;
}

@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;
- (IBAction)test:(id)sender;
@end
