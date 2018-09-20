//
//  headImage.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "headImage.h"
#import "HeaderTotal.h"
#import "myinfoData.h"

@interface headImage ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation headImage
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"个人头像";
    UIImage* image = [[UIImage imageNamed:@"dian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(uploadImage)];
    self.navigationItem.rightBarButtonItem = leftBarutton;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(screenWidth));
    }];
    
    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapAction:)];
    [imageView addGestureRecognizer:lpress];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
}
- (void) longTapAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self uploadImage];
    }
}
- (void)uploadImage{

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",@"保存图片", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];

//    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        NSArray *titles = @[@"拍照",@"从手机相册选择",@"保存图片"];
//        [self addActionTarget:alert titles:titles];
//        [self addCancelActionTarget:alert title:@"取消"];
//        
//        // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
//        UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
//        UIFont *font = [UIFont systemFontOfSize:15];
//        [appearanceLabel setAppearanceFont:font];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    }else{
//        [actionSheet showInView:self.view];
//    }
}

// 添加其他按钮
//- (void)addActionTarget:(UIAlertController *)alertController titles:(NSArray *)titles
//{
//    for (NSString *title in titles) {
//        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            if ([action.title isEqualToString:@"拍照"]) {
//#if TARGET_IPHONE_SIMULATOR
//#elif TARGET_OS_IPHONE
//                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
//                        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//                    }
//                    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//                    [self presentViewController:self.imagePicker animated:YES completion:NULL];
//                } else {
//                    
//                }
//#endif
//            } else if ([action.title isEqualToString:@"从手机相册选择"]) {
//                self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//                [self presentViewController:self.imagePicker animated:YES completion:NULL];
//                
//            }else if ([action.title isEqualToString:@"保存图片"]) {
//                [self saveImageToPhotos:self.imageView.image];
//            }
//        }];
//        [action setValue:[UIColor whiteColor] forKey:@"_titleTextColor"];
//        [alertController addAction:action];
//    }
//}

// 取消按钮
//- (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title
//{
//    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        
//    }];
//    [action setValue:[UIColor redColor] forKey:@"_titleTextColor"];
//    [alertController addAction:action];
//}

// iOS8.0之前可用
//- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
//{
//    for (UIView *view in actionSheet.subviews) {
//        UIButton *btn = (UIButton *)view;
//        btn.titleLabel.font = [UIFont systemFontOfSize:15];
//        if([[btn titleForState:UIControlStateNormal] isEqualToString:@"取消"])
//        {
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        }else{
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//    }
//}
////

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
#if TARGET_IPHONE_SIMULATOR
        
#elif TARGET_OS_IPHONE
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
            [self presentViewController:self.imagePicker animated:YES completion:^{
            
            }];


        } else {
            
        }
#endif
    } else if (buttonIndex == 1) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:self.imagePicker animated:YES completion:^{


        }];
        
    }else if (buttonIndex == 2) {
        [self saveImageToPhotos:self.imageView.image];
    }
}

//保存图片到手机相册
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if(error != NULL){
        [MBProgressHUD showError:@"保存图片失败,请重新保存" toView:self.view];
    }else{
        [MBProgressHUD showSuccess:@"保存图片成功" toView:self.view];
    }
}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self showHint:@"搭讪"];
    UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (orgImage) {
        self.imageView.image = orgImage;
        
        [MBProgressHUD showMessage:@"正在上传" toView:self.view];
        __weak typeof(self) weakSelf = self;
        [[TWClient sharedInstance] avatarUploadWithavatarFile:orgImage progress:^(NSProgress* progress) {
          //  CGFloat progresscg = progress.completedUnitCount / progress.totalUnitCount;
            
          //  CGFloat rate;// = self.imageView.rate;
           // rate += progresscg;
//            self.imageView.rate = rate;
           // if (rate >= 1.0) {
             //   [self.imageView removeProgressCover:YES];
           // }
        } success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakSelf.view];
            [MBProgressHUD showSuccess:@"上传成功" toView:weakSelf.view];
            NSString *avatar = dataDict[@"avatar"];
            if ([avatar isKindOfClass:[NSString class]]) {
                [[Ticket sharedInstance]updateuserinfoForIcon:avatar];
            }
            NSNotification *notification =[NSNotification notificationWithName:AvatarUploadSuccess object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [[TWClient sharedInstance]getMyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
                NSLog(@"在上传头像  查询我的信息OK");
                myinfoData *data =[MTLJSONAdapter modelOfClass:[myinfoData class] fromJSONDictionary:dataDict error:NULL];
                data.flyCreditInfo = [MTLJSONAdapter modelOfClass:[flyCreditInfoData class] fromJSONDictionary:dataDict[@"flyCreditInfo"] error:NULL];
                [NSKeyedArchiver archiveRootObject:data toFile:GRXXDATA];
            } failure:^(NSInteger errorCode, NSString *msg) {
                NSLog(@"在上传头像  查询我的信息OK");
            }];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:self.view];
            if (!msg || !msg.length || [msg isKindOfClass:[NSNull class]]) {
                msg = @"上传失败";
            }
            [MBProgressHUD showError:msg toView:weakSelf.view];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}
- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
@end
