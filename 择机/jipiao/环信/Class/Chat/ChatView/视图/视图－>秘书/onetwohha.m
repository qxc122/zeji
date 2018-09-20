//
//  onetwohha.m
//  jipiao
//
//  Created by Store on 16/8/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "onetwohha.h"
#import "HeaderTotal.h"

@interface onetwohha ()
@property (nonatomic,weak) UILabel *labelTime;
@property (nonatomic,weak) UILabel *labelXingHao;
@property (nonatomic,weak) UILabel *labelDiDian1;
@property (nonatomic,weak) UILabel *labelDiDian2;
@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *image2;
@property (nonatomic,weak) UILabel *prices;
@end

@implementation onetwohha
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *labelTime = [[UILabel alloc]init];
            self.labelTime = labelTime;
        [self addSubview:labelTime];
        UILabel *labelXingHao = [[UILabel alloc]init];
                self.labelXingHao = labelXingHao;
        [self addSubview:labelXingHao];
        UILabel *labelDiDian1 = [[UILabel alloc]init];
                self.labelDiDian1 = labelDiDian1;
        [self addSubview:labelDiDian1];
        UILabel *labelDiDian2 = [[UILabel alloc]init];
                self.labelDiDian2 = labelTime;
        [self addSubview:labelDiDian2];
        UIImageView *image1 = [[UIImageView alloc]init];
                self.image1 = image1;
        [self addSubview:image1];
        UIImageView *image2 = [[UIImageView alloc]init];
                self.image2 = image2;
        [self addSubview:image2];
        UILabel *prices = [[UILabel alloc]init];
                self.prices = prices;
        [self addSubview:prices];
        UIImageView *jietou = [[UIImageView alloc]init];
        [self addSubview:jietou];
        
        [labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@11);
        }];
        [labelXingHao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelTime.mas_right).offset(5);
            make.top.equalTo(labelTime).offset(0);
            make.height.equalTo(@[labelTime]);
        }];
        [labelDiDian1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelTime).offset(0);
            make.top.equalTo(labelTime.mas_bottom).offset(10);
            make.height.equalTo(@11);
        }];
        [jietou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelDiDian1.mas_right).offset(0);
            make.right.equalTo(labelDiDian2.mas_left).offset(0);
            make.width.equalTo(@16);
            make.height.equalTo(@8);
            make.centerY.equalTo(labelDiDian1);
        }];
        [labelDiDian2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labelDiDian1).offset(0);
            make.height.equalTo(@[labelDiDian1]);
        }];
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(prices.mas_left).offset(-3);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
            make.centerY.equalTo(labelXingHao);
        }];
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(image1).offset(0);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
            make.centerY.equalTo(labelDiDian2);
        }];
        [prices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(0);
            make.height.equalTo(@12);
            make.centerY.equalTo(self);
        }];
//        labelM1.textColor = RGBColor(82, 82, 82);
//        labelR1.textColor = RGBColor(24, 35, 52);
        labelTime.textColor = RGBColor(24, 35, 52);
        labelXingHao.textColor = RGBColor(24, 35, 52);
        labelDiDian1.textColor = RGBColor(82, 82, 82);
        labelDiDian2.textColor = RGBColor(82, 82, 82);
        prices.textColor = RGBColor(235, 78, 82);
        labelTime.font  =[UIFont systemFontOfSize:12];
        labelXingHao.font  =[UIFont systemFontOfSize:12];
        labelDiDian1.font  =[UIFont systemFontOfSize:12];
        labelDiDian2.font  =[UIFont systemFontOfSize:12];
        prices.font  =[UIFont systemFontOfSize:13];
        jietou.image =[UIImage imageNamed:@"545"];
        //test
        image1.image =[UIImage imageNamed:@"chat_location_preview"];
        image2.image =[UIImage imageNamed:@"545"];
        labelTime.text = @"20:05~23:50";
        labelXingHao.text = @"MU9868（大）";
        labelDiDian1.text = @"深圳宝安T2";
        labelDiDian2.text = @"上海浦东T1";
        prices.text = @"¥2380";
    }
    return self;
}
@end
