//
//  shareMyapp.m
//  jipiao
//
//  Created by Store on 16/8/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "shareMyapp.h"
#import "HeaderTotal.h"
#import "leftdataamain.h"
#import "UIImage+TWProductCode.h"

@interface shareMyapp ()
@property (nonatomic,weak) UIImageView *imageViewTwo;
@end

@implementation shareMyapp
- (void)viewDidLoad{
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;
    self.title = @"分享app";
    self.view.backgroundColor = RGBColor(38, 48, 64);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    
    UIImageView *imageViewTwo = [[UIImageView alloc]init];
    self.imageViewTwo = imageViewTwo;
    [self.view addSubview:imageViewTwo];
    
    UILabel *label1 = [[UILabel alloc]init];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]init];
    [self.view addSubview:label3];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(15*HEIGHTICON);
        make.width.equalTo(@(57*HEIGHTICON));
        make.height.equalTo(imageView.mas_width);
    }];
    
    [imageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).offset(48*HEIGHTICON);
        make.width.equalTo(@(212*HEIGHTICON));
        make.height.equalTo(imageViewTwo.mas_width);
    }];

    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageViewTwo.mas_bottom).offset(20*HEIGHTICON);
        make.height.equalTo(@16);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.equalTo(@10);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(label3.mas_top).offset(-5);
        make.height.equalTo(@10);
    }];
    
//    imageView.image = [UIImage imageNamed:@"img_head portrait"];
    UIImage *tmp = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:ZEJIICON];
    if (tmp) {
        imageView.image = tmp;
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar]placeholderImage:[UIImage imageNamed:@"img_head portrait"] options:SDWebImageRetryFailed];
    }
    
    imageViewTwo.image = [UIImage imageNamed:@"img_logo_02"];
    GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
    if (arrryDes) {
        if (!arrryDes.twoMa ||!arrryDes.twoMa.length) {
           arrryDes.twoMa = @"https://itunes.apple.com/app/id1151039931";
        }
        imageViewTwo.image = [UIImage returnImage:arrryDes.twoMa With:212*HEIGHTICON];
    }
    [[TWClient sharedInstance]getGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            NSLog(@"获取全局参数获取OK");
            GlobalParams *arrryDes = [MTLJSONAdapter modelOfClass:[GlobalParams class] fromJSONDictionary:dataDict error:nil];
            if (!arrryDes.twoMa ||!arrryDes.twoMa.length) {
                arrryDes.twoMa = @"https://itunes.apple.com/app/id1151039931";
            }
            [NSKeyedArchiver archiveRootObject:arrryDes toFile:ALLHDATA];
            imageViewTwo.image = [UIImage returnImage:arrryDes.twoMa With:212*HEIGHTICON];

        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"获取全局参数获取失败");
    }];
    
    
    
    label1.text = @"我的分享二维码";
    
    label2.text = @"腾邦国际 版权所有";
    label3.text = @"Copyright 2000 - 2016 feiren.com All Rights Reserved";
    label1.textColor = [UIColor whiteColor];
    label2.textColor = RGBColor(185, 185, 185);
    label3.textColor = RGBColor(185, 185, 185);
    label1.font = [UIFont systemFontOfSize:16];
    label2.font = [UIFont systemFontOfSize:10];
    label3.font = [UIFont systemFontOfSize:8];
}
@end
