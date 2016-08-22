////
////  ViewController.m
////  QiniuDemo
////
////  Created by   何舒 on 16/3/2.
////  Copyright © 2016年 Aaron. All rights reserved.
////
//
//#import "ViewController.h"
//#import "AFNetworking.h"
//#import "UIImageView+AFNetworking.h"
//#import "XYQNToken.h"
//#define AK @"jMqcyWMLWaE5Uoh5oDu9F_VASk_jNudY6CajJ2xP"
//#define SK @"8FIR4zGqvaYrbR9XyMeeAN67C1MhZ072w5kxF4jA"
//@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//
//@property (nonatomic, strong) NSString *token;
//@property (nonatomic, strong) UIImage *pickImage;
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"七牛云上传";
//}
//
//- (IBAction)chooseAction:(id)sender {
//    NSString *accesstoken= [XYQNToken createTokenWithScope:@"zpx1123" accessKey:AK secretKey:SK];
//    NSString*host=@"rsf.qbox.me";
//    
//    
//    NSString*token=[@"QBox " stringByAppendingString: accesstoken];
//    NSString*URL=[host stringByAppendingString:@"/list"];
//    
//    
//    NSURL *url = [NSURL URLWithString:URL];
//    //请求初始化，可以在这针对缓存，超时做出一些设置
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval:10];
//    NSString *post = @"bucket=qiniu-ts-demo&prefix=00";
//    
//    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
//    [request setHTTPBody:postData];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    [request setValue:host forHTTPHeaderField:@"Host"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
//    [request setValue:token forHTTPHeaderField:@"Authorization"];
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString*str6=[[NSString alloc]initWithData:returnData  encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str6);
//    //    [self gotoImageLibrary];
//}
//
//- (IBAction)uploadAction:(id)sender {
//    if (self.pickImage == nil) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"还未选择图片"
//                              message:@""
//                              delegate:nil
//                              cancelButtonTitle:@"OK!"
//                              otherButtonTitles:nil];
//        [alert show];
//    } else {
//        [self uploadImageToQNFilePath:[self getImagePath:self.pickImage]];
//    }
//}
//
//- (void)uploadImageToQNFilePath:(NSString *)filePath {
//    
//    
//    NSString *token= [XYQNToken createTokenWithScope:@"zpx1123" accessKey:AK secretKey:SK];
//    NSLog(@"token:%@",token);
//    
//    self.token =token;
//    QNUploadManager *upManager = [[QNUploadManager alloc] init];
//    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
//        NSLog(@"percent == %.2f", percent);
//    }
//                                                                 params:nil
//                                                               checkCrc:NO
//                                                     cancellationSignal:nil];
//    [upManager putFile:filePath key:@"zpx1123" token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        NSLog(@"info ===== %@", info);
//        NSLog(@"resp ===== %@", resp);
//    }
//                option:uploadOption];
//}
//
//- (void)gotoImageLibrary {
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:picker animated:YES completion:nil];
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"访问图片库错误"
//                              message:@""
//                              delegate:nil
//                              cancelButtonTitle:@"OK!"
//                              otherButtonTitles:nil];
//        [alert show];
//    }
//}
//
////再调用以下委托：
//#pragma mark UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker
//        didFinishPickingImage:(UIImage *)image
//                  editingInfo:(NSDictionary *)editingInfo {
//    self.pickImage = image; //imageView为自己定义的UIImageView
//    [picker dismissViewControllerAnimated:YES completion:^{
//    }];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
////照片获取本地路径转换
//- (NSString *)getImagePath:(UIImage *)Image {
//    NSString *filePath = nil;
//    NSData *data = nil;
//    if (UIImagePNGRepresentation(Image) == nil) {
//        data = UIImageJPEGRepresentation(Image, 1.0);
//    } else {
//        data = UIImagePNGRepresentation(Image);
//    }
//    
//    //图片保存的路径
//    //这里将图片放在沙盒的documents文件夹中
//    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    
//    //文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //把刚刚图片转换的data对象拷贝至沙盒中
//    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
//    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
//    
//    //得到选择后沙盒中图片的完整路径
//    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
//    return filePath;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
