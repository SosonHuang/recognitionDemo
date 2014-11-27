//
//  ImageFilterProcessViewController.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "ImageFilterProcessViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import "IphoneScreen.h"
#import "Singleton.h"
#import "TestViewController.h"
#import "ZDStickerView.h"
#import "MVArrowOverlayView.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface ImageFilterProcessViewController ()
{
    UIImageView *watchView;
    UIImage *hello;
    
    int watchX;
    int watchY;
    
    ZDStickerView *userResizableView1;
    
    //判断是否隐藏了控件
    BOOL isHidden;
    
    MVArrowOverlayView *tappableView;
        MVArrowOverlayView *tappableView2;
    UIView *bg;
}
@end

@implementation ImageFilterProcessViewController
@synthesize currentImage = currentImage, delegate = delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)backView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


//- (IBAction)fitlerDone:(id)sender
//{
//    //[self dismissViewControllerAnimated:NO completion:^{
////        userResizableView1.borderView.hidden=YES;
////        userResizableView1.resizingControl.hidden=YES;
////        UIGraphicsBeginImageContext( rootImageView.frame.size);
////        [rootImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
////        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
////        UIGraphicsEndImageContext();
////    
////        TestViewController *test=[[TestViewController alloc]init];
////        test.testImage=newImage;
////        [self presentViewController:test animated:YES completion:nil];
////     userResizableView1.resizingControl.hidden=NO;
//    
//            //[delegate imageFitlerProcessDone:newImage];
//    //}];
//}
//
//
//
////-(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
////{
////    long double rotate = 0.0;
////    CGRect rect;
////    float translateX = 0;
////    float translateY = 0;
////    float scaleX = 1.0;
////    float scaleY = 1.0;
////    
////    switch (orientation) {
////        case UIImageOrientationLeft:
////            rotate = M_PI_2;
////            rect = CGRectMake(0, 0, image.size.height, image.size.width);
////            translateX = 0;
////            translateY = -rect.size.width;
////            scaleY = rect.size.width/rect.size.height;
////            scaleX = rect.size.height/rect.size.width;
////            break;
////        case UIImageOrientationRight:
////            rotate = 3 * M_PI_2;
////            rect = CGRectMake(0, 0, image.size.height, image.size.width);
////            translateX = -rect.size.height;
////            translateY = 0;
////            scaleY = rect.size.width/rect.size.height;
////            scaleX = rect.size.height/rect.size.width;
////            break;
////        case UIImageOrientationDown:
////            rotate = M_PI;
////            rect = CGRectMake(0, 0, image.size.width, image.size.height);
////            translateX = -rect.size.width;
////            translateY = -rect.size.height;
////            break;
////        default:
////            rotate = 0.0;
////            rect = CGRectMake(0, 0, image.size.width, image.size.height);
////            translateX = 0;
////            translateY = 0;
////            break;
////    }
////    
////    UIGraphicsBeginImageContext(rect.size);
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    //做CTM变换
////    CGContextTranslateCTM(context, 0.0, rect.size.height);
////    CGContextScaleCTM(context, 1.0, -1.0);
////    CGContextRotateCTM(context, rotate);
////    CGContextTranslateCTM(context, translateX, translateY);
////    
////    CGContextScaleCTM(context, scaleX, scaleY);
////    //绘制图片
////    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
////    
////    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
////    
////    return newPic;
////}
//
//// 指定回调方法
////
////-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
////{
////    NSString *msg = nil ;
////    if(error != NULL){
////        
////        msg = @"保存图片失败" ;
////    }else{
////        msg = @"保存图片成功" ;
////    }
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
////                                    message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////    [alert show];
////}
//
//
//
//
//#pragma MARK 图片移动
//-(void)handlePan:(UIPanGestureRecognizer*)recognizer
//{
//    //获取图片的大小
//    CGFloat smallwidth=rootImageView.frame.size.width;
//    CGFloat smallheight=rootImageView.frame.size.height;
//    NSLog(@"%f",rootImageView.frame.origin.x);
//    NSLog(@"%f", rootImageView.frame.origin.y);
//    
//    
//    //获取底部图片的大小
//    CGFloat imageWatchwidth=userResizableView1.frame.size.width;
//    CGFloat imageWatchheight=userResizableView1.frame.size.height;
//    NSLog(@"%f",userResizableView1.frame.origin.x);
//    NSLog(@"%f", userResizableView1.frame.origin.y);
//    
//    
//    CGPoint translation = [recognizer translationInView:rootImageView];
//    
//    NSLog(@"%f", recognizer.view.center.x);
//    NSLog(@"%f", recognizer.view.center.y);
//    NSLog(@"origin %f", recognizer.view.frame.origin.y);
//    
//    //移动到右边超出范围，即到达右边不能超出
//    if(recognizer.view.frame.origin.x>(300-imageWatchwidth)){
//        [recognizer.view setCenter:CGPointMake(300-imageWatchwidth/2,recognizer.view.center.y)];
//    }
//    
//    //移动到左边超出范围
//    if(recognizer.view.frame.origin.x<10){
//        [recognizer.view setCenter:CGPointMake(imageWatchwidth/2, recognizer.view.center.y)];
//    }
//    
//    //移动到上边超出范围
//    if(recognizer.view.frame.origin.y<=0){
//        [recognizer.view setCenter:CGPointMake(recognizer.view.center.x,imageWatchheight/2)];
//    }
//    
//    //移动到下边超出范围
//    if(recognizer.view.frame.origin.y>rootImageView.frame.size.height-imageWatchheight){
//        [recognizer.view setCenter:CGPointMake(recognizer.view.center.x,rootImageView.frame.size.height-imageWatchheight/2)];
//    }
//    //
//    //    if(recognizer.view.frame.origin.y<40||recognizer.view.frame.origin.y>440){
//    //        [recognizer.view setCenter:CGPointMake(recognizer.view.center.x, 440)];
//    //    }
//    
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                         recognizer.view.center.y + translation.y);
//    
//    
//    [recognizer setTranslation:CGPointZero inView:rootImageView];
//    
////    watchX=userResizableView1.frame.origin.x;
////    watchY=userResizableView1.frame.origin.y;
////    NSLog(@"%f",  recognizer.view.frame.origin.x);
////    NSLog(@"%f",  recognizer.view.frame.origin.y);
//    
//    
//    
//    
//    
//}
//
//#pragma MARK 图片放大缩小
//-(void)scaGesture:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
//    //方法一：
//    //    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
//    //    //当手指离开屏幕时,将lastscale设置为1.0
//    //    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
//    //        lastScale = 1.0;
//    //        return;
//    //    }
//    //
//    //    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
//    //    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
//    //    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
//    //    [[(UIPinchGestureRecognizer*)sender view]setTransform:newTransform];
//    //    lastScale = [(UIPinchGestureRecognizer*)sender scale];
//    
//    
//    //方法二：
//    UIView *view = pinchGestureRecognizer.view;
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        
//        pinchGestureRecognizer.scale = 1;
//    }
//}
//
//#pragma MARK 旋转
//// 旋转
//-(void)rotate:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
//    //方法一：
//    //    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
//    //
//    //        _lastRotation = 0.0;
//    //        return;
//    //    }
//    //
//    //    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
//    //
//    //    CGAffineTransform currentTransform = imageWatch.transform;
//    //    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
//    //
//    //    [imageWatch setTransform:newTransform];
//    //
//    //    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
//    //    [self showOverlayWithFrame:imageWatch.frame];
//    
//    //方法二：
//    UIView *view = rotationGestureRecognizer.view;
//    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
//        [rotationGestureRecognizer setRotation:0];
//    }
//    
//   
////    [aPath addLineToPoint:CGPointMake(200.0, 40.0)];
////    
////    [aPath addLineToPoint:CGPointMake(160, 140)];
////    
////    [aPath addLineToPoint:CGPointMake(40.0, 140)];
////    
////    [aPath addLineToPoint:CGPointMake(0.0, 40.0)];
//    
//
//}
//
//-(void)SingleTapSmall:(id)sender
//{
//    userResizableView1.borderView.hidden=NO;
//    userResizableView1.resizingControl.hidden=NO;
//
//}
//
//
//
//-(void)SingleTapBig:(id)sender
//{
//    userResizableView1.borderView.hidden=YES;
//    userResizableView1.resizingControl.hidden=YES;
//}



-(void)createScrollView:(NSArray *)arr{
    UIScrollView *sv  =[[UIScrollView alloc] initWithFrame:CGRectMake(10, 40,self.view.frame.size.width, 500)];
    sv.pagingEnabled = YES;
    
    sv.showsVerticalScrollIndicator = YES;
    
    sv.showsHorizontalScrollIndicator = YES;
    sv.delegate = self;
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width * arr.count, 500);
    [sv setContentSize:newSize];
    
    for (int i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(i * 300+10, 40, 320, 500)];
        [img setImageWithURL:[[arr objectAtIndex:i]objectForKey:@"img"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]  options:SDWebImageProgressiveDownload];
        [sv addSubview:img];
    }
    
    
    [self.view addSubview: sv];
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
    
    UIImage *image =rootImageView.image;
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
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSError *error;
        NSDictionary *jsonParsed = [NSJSONSerialization JSONObjectWithData:resData
                                                                   options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr=[jsonParsed objectForKey:@"data"];
        NSLog(@"arr %i",arr.count);
        if (arr.count==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有匹配图片！"
                                                            message:@"NO NO NO" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return ;
        }
        
        [self createScrollView:arr];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(10, 20, 34, 34)];
    [leftBtn addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.388 alpha:1.000]];
    rootImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(10, 80, 300, 400)];
    rootImageView.image = currentImage;
    rootImageView.hidden=YES;
    [self.view addSubview:rootImageView];
    
    rootImageView.image=  [self imageCompressForSize:currentImage targetSize:CGSizeMake(300, 400)];
    
    UIImageWriteToSavedPhotosAlbum(rootImageView.image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    [self putImage];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [super dealloc];
    scrollerView = nil;
    rootImageView = nil;
    [currentImage release],currentImage  =nil;
    
}
@end
