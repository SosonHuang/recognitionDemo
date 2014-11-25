//
//  TestViewController.m
//  CustomPickerAndFitler
//
//  Created by soson on 14-6-3.
//  Copyright (c) 2014年 Wu.weibin. All rights reserved.
//

#import "TestViewController.h"
#import "AFNetworking.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.hechengImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 300, 400)];
    
    self.hechengImage.image=  [self imageCompressForSize:self.testImage targetSize:CGSizeMake(300, 400)];
    
//    self.hechengImage.image = self.testImage;
    
    [self.view addSubview:self.hechengImage];
    
    
    
    
    
    
    
    
    UIImageWriteToSavedPhotosAlbum(self.hechengImage.image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    
}


#pragma MARK 图片压缩
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
-(void)putImage
{
    
    UIImage *image = self.hechengImage.image;
    NSData *data = UIImageJPEGRepresentation(image,0.5);
    
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://wb.tensquare.hk/wb/api/idv/" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        //UIImageWriteToSavedPhotosAlbum()保存照片到系统相册出现 －3310 不能保存成功的问题
        //Error Domain=ALAssetsLibraryErrorDomain Code=-3310 "数据不可用" UserInfo=0xc971ed0 {NSLocalizedRecoverySuggestion=启动“照片”应用程序, NSUnderlyingError=0xc974e50 "数据不可用", NSLocalizedDescription=数据不可用}
        
        //请在 设置-隐私-照片 中打开应用程序访问权限。
        msg = @"保存图片失败，请检查" ;
    }else{
        msg = @"保存图片成功" ;
        [self putImage];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
