//
//  tableFoot.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "tableFoot.h"
#import "HeaderTotal.h"
#import "leftdataamain.h"
#import "UIImage+TWProductCode.h"
@implementation tableFoot
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorBigBack;
//        UIImageView *imageView = [[UIImageView alloc]init];
//        [self addSubview:imageView];
//        
//        UILabel *label = [[UILabel alloc]init];
//        [self addSubview:label];
//        
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).offset(45*HEIGHTICON);
//            make.centerX.equalTo(self);
//            make.width.equalTo(@(80*HEIGHTICON));
//            make.height.equalTo(imageView.mas_width);
//        }];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(imageView.mas_bottom).offset(15*HEIGHTICON);
//            make.centerX.equalTo(self);
//            make.height.equalTo(@19);
//        }];
//        
//        label.font = [UIFont systemFontOfSize:17];
//        label.textColor = RGBColor(255, 255, 255);
//        imageView.image = [UIImage imageNamed:@"img_logo_02"];
//        GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
//        if (arrryDes) {
//            if (!arrryDes.twoMa ||!arrryDes.twoMa.length) {
//                arrryDes.twoMa = @"https://itunes.apple.com/app/id1151039931";
//            }
//            imageView.image = [UIImage returnImage:arrryDes.twoMa With:212*HEIGHTICON];
//        }
//        
//        label.text = @"分享app";
        
        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        btn.backgroundColor = RGBColor(131, 140, 146);
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClickmyinfo) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(label.mas_bottom).offset(50*HEIGHTICON);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(13);
            make.height.equalTo(@(44*HEIGHTICON));
            make.width.equalTo(@(screenWidth-100*WIDTHICON));
        }];
    }
    return self;
}
- (void)btnClickmyinfo{
    NSLog(@"取消登录");
    if ([self.delegate respondsToSelector:@selector(clickLogout)]) {
        [self.delegate clickLogout];
    }
}
@end
