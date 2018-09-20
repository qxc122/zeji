//
//  fourkefuBbuleview.m
//  jipiao
//
//  Created by Store on 16/8/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "fourkefuBbuleview.h"
#import "baseWebView.h"
#define WiDTHcir1   8   //左右的圆圈的宽高
#define WiDTHFont   1.4   //字体宽
@interface fourkefuBbuleview ()

@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *imageLine2;
@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UILabel *label2;
@property (nonatomic,weak) UILabel *label3;
@property (nonatomic,weak) UILabel *labelL;
@property (nonatomic,weak) UILabel *labelM;
@property (nonatomic,weak) UILabel *labelR;
@property (nonatomic,weak) UILabel *labelL1;
@property (nonatomic,weak) UILabel *labelM1;
@property (nonatomic,weak) UILabel *labelR1;

@property (nonatomic,weak) UILabel *last1Des;
@property (nonatomic,weak) UILabel *last2Des;
@end

@implementation fourkefuBbuleview
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(205, 237, 247);
//        UIImageView *viewall = [[UIImageView alloc]init];
//        [self addSubview:viewall];
        
        UIView *cir1 = [[UIView alloc]init];
        [self addSubview:cir1];
        
        UIView *cir2 = [[UIView alloc]init];
        [self addSubview:cir2];
        
        UIImageView *imageLine1 = [[UIImageView alloc]init];
        [self addSubview:imageLine1];
        
        UIImageView *imageLine2 = [[UIImageView alloc]init];
        self.imageLine2 = imageLine2;
        [self addSubview:imageLine2];
        
        UIImageView *imageOK = [[UIImageView alloc]init];
        [self addSubview:imageOK];
        
        UIImageView *image1 = [[UIImageView alloc]init];
        self.image1 = image1;
        [self addSubview:image1];
        
        UILabel *label1 = [[UILabel alloc]init];
        self.label1 = label1;
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]init];
        self.label2 = label2;
        [self addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]init];
        self.label3 = label3;
        [self addSubview:label3];
        
        UILabel *labelL = [[UILabel alloc]init];
        self.labelL = labelL;
        [self addSubview:labelL];
        
        UILabel *labelM = [[UILabel alloc]init];
        self.labelM = labelM;
        [self addSubview:labelM];
        
        UILabel *labelR = [[UILabel alloc]init];
        self.labelR = labelR;
        [self addSubview:labelR];
        
        UILabel *labelL1 = [[UILabel alloc]init];
        self.labelL1 = labelL1;
        [self addSubview:labelL1];
        
        UILabel *labelM1 = [[UILabel alloc]init];
        self.labelM1 = labelM1;
        [self addSubview:labelM1];
        
        UILabel *labelR1 = [[UILabel alloc]init];
        self.labelR1 = labelR1;
        [self addSubview:labelR1];
        
        UIImageView *image2 = [[UIImageView alloc]init];
        [self addSubview:image2];
        
        UILabel *labelLast1 = [[UILabel alloc]init];
        [self addSubview:labelLast1];
        UILabel *labelLast2 = [[UILabel alloc]init];
        [self addSubview:labelLast2];
        UILabel *last1Des = [[UILabel alloc]init];
        self.last1Des = last1Des;
        [self addSubview:last1Des];
        UILabel *last2Des = [[UILabel alloc]init];
        self.last2Des = last2Des;
        [self addSubview:last2Des];
        
        UILabel *btnLabel = [[UILabel alloc]init];
        [self addSubview:btnLabel];
        
        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@16);
            make.top.equalTo(self).offset(5);;
            make.height.equalTo(@16);
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.mas_right).offset(5);
            make.right.equalTo(label2.mas_left).offset(-5);
            make.top.equalTo(image1).offset(0);
            make.bottom.equalTo(image1).offset(0);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self).offset(5);
            //            make.right.equalTo(self).offset(5);
            make.top.equalTo(label1).offset(0);
            make.bottom.equalTo(label1).offset(0);
        }];
        
        
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1).offset(0);
            //            make.right.equalTo(self).offset(5);
            make.top.equalTo(label2.mas_bottom).offset(10);
            make.height.equalTo(@10);
        }];
        [imageOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
//            make.bottom.equalTo(imageLine1.mas_top).offset(0);
//            make.height.equalTo(@1);
        }];
        [imageLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cir1.mas_right).offset(0);
            make.right.equalTo(cir2.mas_left).offset(0);
            make.top.equalTo(label3.mas_bottom).offset(15);
            make.height.equalTo(@1);
        }];
        [cir1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageLine1);
            make.centerX.equalTo(self.mas_left);
            make.width.equalTo(@(WiDTHcir1));
            make.height.equalTo(@(WiDTHcir1));
        }];
        [cir2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(imageLine1);
            make.centerX.equalTo(self.mas_right);
            make.width.equalTo(@(WiDTHcir1));
            make.height.equalTo(@(WiDTHcir1));
        }];
        
        
        [labelL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1).offset(0);
            //            make.right.equalTo(labelM.mas_left).offset(-5);
            make.top.equalTo(imageLine1).offset(15);
            make.height.equalTo(@13);
            //            make.width.equalTo(@[labelR]);
            //            make.width.equalTo(@[labelM,labelR,labelL1,labelM1,labelR1]);
            make.height.equalTo(@[labelM,labelR]);
        }];
        [labelM mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.right.equalTo(labelR.mas_left).offset(-5);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(labelL).offset(0);
            make.bottom.equalTo(labelL).offset(0);
        }];
        
        [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelM).offset(-5);
            make.right.equalTo(labelM).offset(5);
            make.top.equalTo(labelM.mas_bottom).offset(0);
            make.height.equalTo(@8);
        }];
        
        [labelR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(labelL).offset(0);
            make.bottom.equalTo(labelL).offset(0);
        }];
        
        [labelL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelL).offset(0);
            make.right.equalTo(labelL).offset(0);
            make.height.equalTo(@10);
            make.top.equalTo(labelL.mas_bottom).offset(10);
        }];
        [labelM1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelM).offset(0);
            make.right.equalTo(labelM).offset(0);
            make.top.equalTo(labelL1).offset(0);
            make.bottom.equalTo(labelL1).offset(0);
        }];
        [labelR1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelR).offset(0);
            make.right.equalTo(labelR).offset(0);
            make.top.equalTo(labelL1).offset(0);
            make.bottom.equalTo(labelL1).offset(0);
        }];
        [imageLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(labelL1.mas_bottom).offset(15);
            make.height.equalTo(@1);
        }];
        [labelLast1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label3);
            make.right.equalTo(last1Des.mas_left).offset(-5);
            make.top.equalTo(imageLine2).offset(15);
            make.height.equalTo(@10);
        }];
        [last1Des mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self);
            make.top.equalTo(labelLast1).offset(0);
            make.bottom.equalTo(labelLast1).offset(0);
        }];
        [labelLast2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label3);
            make.right.equalTo(last2Des.mas_left).offset(-5);
            make.bottom.equalTo(btnLabel.mas_top).offset(-5);
            make.height.equalTo(@10);
        }];
        [last2Des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(labelLast2);
//            make.top.equalTo(labelLast2).offset(0);
//            make.bottom.equalTo(labelLast2).offset(0);
        }];
        [btnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(labelLast2.mas_bottom).offset(5);
            make.bottom.equalTo(self).offset(0);
            make.height.equalTo(@25);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        
        label1.font = [UIFont systemFontOfSize:10];
        label2.font = [UIFont systemFontOfSize:10 weight:1.3];
        label3.font = [UIFont systemFontOfSize:10];
        
        labelL.font = [UIFont systemFontOfSize:13 weight:WiDTHFont];
        labelM.font = [UIFont systemFontOfSize:11 weight:WiDTHFont];
        labelR.font = [UIFont systemFontOfSize:13 weight:WiDTHFont];
        
        labelL1.font = [UIFont systemFontOfSize:10 weight:WiDTHFont];
        labelM1.font = [UIFont systemFontOfSize:10 weight:WiDTHFont];
        labelR1.font = [UIFont systemFontOfSize:10 weight:WiDTHFont];
        labelLast1.font = [UIFont systemFontOfSize:10];
        labelLast2.font = [UIFont systemFontOfSize:10];
        last1Des.font = [UIFont systemFontOfSize:11];
        last2Des.font = [UIFont systemFontOfSize:15];
        
        label1.textColor = RGBColor(24, 35, 52);
        label2.textColor = RGBColor(24, 35, 52);
        label3.textColor = RGBColor(24, 35, 52);
        labelL.textColor = RGBColor(24, 35, 52);
        labelM.textColor = RGBColor(82, 82, 82);
        labelR.textColor = RGBColor(24, 35, 52);
        labelL1.textColor = RGBColor(24, 35, 52);
        labelM1.textColor = RGBColor(82, 82, 82);
        labelR1.textColor = RGBColor(24, 35, 52);
        labelLast1.textColor = RGBColor(82, 82, 82);
        labelLast2.textColor = RGBColor(82, 82, 82);
        last1Des.textColor = RGBColor(24, 35, 52);
        last2Des.textColor = RGBColor(235, 78, 82);
        
        labelR.textAlignment = NSTextAlignmentRight;
        labelM.textAlignment = NSTextAlignmentCenter;
        labelL1.textAlignment = NSTextAlignmentCenter;
        labelM1.textAlignment = NSTextAlignmentCenter;
        labelR1.textAlignment = NSTextAlignmentCenter;
        
        btnLabel.textAlignment =NSTextAlignmentCenter;
        btnLabel.text = @"已预定成功,点击支付";
        btnLabel.textColor = [UIColor whiteColor];
        btnLabel.font = [UIFont systemFontOfSize:10];
        btnLabel.backgroundColor = RGBColor(58, 192, 236);

        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnokokkook) forControlEvents:UIControlEventTouchUpInside];
        
        labelLast1.text = @"乘机人";
        labelLast2.text = @"订单总金额";
        cir1.layer.cornerRadius = WiDTHcir1/2.0;
        cir1.layer.masksToBounds = YES;
        cir2.layer.cornerRadius = WiDTHcir1/2.0;
        cir2.layer.masksToBounds = YES;
        cir1.backgroundColor = RGBColor(25, 32, 45);
        cir2.backgroundColor = RGBColor(25, 32, 45);
        labelLast1.tag = 11;
        last1Des.tag = 11;
        //test
        imageLine1.image = [UIImage imageNamed:@"545"];
        imageLine2.image = [UIImage imageNamed:@"545"];
        label1.text = @"南方航空";
        label2.text = @"ZH-9868";
        label3.text = @"2016-09-01 星期天 农历八月初一";
        labelL.text = @"上海虹桥T2";
        labelM.text = @"(经)昆明";
        labelR.text = @"北京首都T3";
        labelL1.text = @"10:30";
        labelM1.text = @"11:45";
        labelR1.text = @"13:20";
        last1Des.text = @"张三，54656********2112";
        last2Des.text = @"¥ 1890";
        image2.image = [UIImage imageNamed:@"矩形19"];//qxc
        image1.image = [UIImage imageNamed:@"add"];
        imageOK.image = [UIImage imageNamed:@"预订成功"];
        
    }
    return self;
}
- (void)setDataa:(NSDictionary *)dic{
    orderInfo *dataa = [MTLJSONAdapter modelOfClass:[orderInfo class] fromJSONDictionary:dic error:nil];
//    _dataa = dataa;
//orderInfo
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:dataa.airLogo]];
    self.label1.text = dataa.airName;
    self.label2.text = dataa.flightNo;
    NSString *str3 = [NSString stringWithString:dataa.depDate];
    str3 = [str3 stringByAppendingString:@" "];
    if (dataa.lunarDepDate) {
        str3 = [str3 stringByAppendingString:dataa.lunarDepDate];
    }
    self.label3.text = str3;
    
    self.labelL.text = [dataa.depCityName stringByAppendingString:dataa.depTerminal];
    self.labelM.text = dataa.airName;
    self.labelR.text = [dataa.arrCityName stringByAppendingString:dataa.arrTerminal];
    self.labelL1.text = dataa.depTime;
    self.labelM1.text = dataa.airName;
    self.labelR1.text = dataa.arrTime;
    if ([dataa.stopFlag isEqualToString:@"1"]) {    //停
        self.labelM.text = [@"(经)" stringByAppendingString:dataa.stopCityName];
        self.labelM1.text = dataa.stopCityArrTime;
    }else{
        self.labelM1.text = @"";
        self.labelM.text = @"";
    }
    
    for (UIView *tmp in self.subviews) {
        if (tmp.tag == 11) {
            [tmp removeFromSuperview];
        }
    }
    NSInteger jiben = 15;
    NSInteger jibenSpaing = 10;
    NSInteger jibenheigh = 10;
    for (psgInfoData *dataOne in dataa.psgInfo) {
        UILabel *labelLast1 = [[UILabel alloc]init];
        [self addSubview:labelLast1];
        labelLast1.tag = 11;
        
        UILabel *last1Des = [[UILabel alloc]init];
        [self addSubview:last1Des];
        last1Des.tag = 11;
        
        last1Des.textColor = RGBColor(24, 35, 52);
        last1Des.font = [UIFont systemFontOfSize:11];
        labelLast1.textColor = RGBColor(82, 82, 82);
        labelLast1.font = [UIFont systemFontOfSize:10];

        [labelLast1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.label3);
            make.right.equalTo(last1Des.mas_left).offset(-5);
            make.top.equalTo(self.imageLine2).offset(jiben);
            make.height.equalTo(@(jibenheigh));
        }];
        [last1Des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labelLast1).offset(0);
            make.bottom.equalTo(labelLast1).offset(0);
        }];
        jiben += jibenheigh+jibenSpaing;
        labelLast1.text = @"乘机人：";
        last1Des.text = [dataOne.psgName stringByAppendingFormat:@", %@",dataOne.psgCertNo];
    }
    
    self.last2Des.text = [NSString stringWithFormat:@"¥%@",dataa.totalPrice];
}
- (void)btnokokkook{
    NSLog(@"btnokokkook");
    NSString *tmp = nil;
#ifdef DEBUG
    tmp = @"我的机票订单";
#else
    tmp = @"机票订单";
#endif
    
    baseWebView *vc = [[baseWebView alloc]init];
    vc.isRefeth = NO;
    vc.title = tmp;
    vc.url = [kURLAPIBase stringByAppendingString:myOrder];
    [NaVc pushViewController:vc animated:YES];
}
@end
