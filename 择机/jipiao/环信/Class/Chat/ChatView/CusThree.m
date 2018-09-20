//
//  CusThree.m
//  jipiao
//
//  Created by Store on 16/8/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CusThree.h"
#import "HeaderTotal.h"


@interface CusThree ()
@property (nonatomic,weak) UIImageView *image1;
@property (nonatomic,weak) UIImageView *image2;
@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UILabel *label2;
@property (nonatomic,weak) UILabel *label3;
@property (nonatomic,weak) UILabel *labelL;
@property (nonatomic,weak) UILabel *labelM;
@property (nonatomic,weak) UILabel *labelR;
@property (nonatomic,weak) UILabel *labelL1;
@property (nonatomic,weak) UILabel *labelM1;
@property (nonatomic,weak) UILabel *labelR1;
@end



@implementation CusThree
#define CusThreeIdentifier @"CusThreeIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    CusThree *cell = [tableView dequeueReusableCellWithIdentifier:CusThreeIdentifier];
    if (cell == nil) {
        cell = [[CusThree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CusThreeIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *viewall = [[UIView alloc]init];
        [self.contentView addSubview:viewall];
        
        UIView *viewback = [[UIView alloc]init];
        [self.contentView addSubview:viewback];
        
        UIImageView *image1 = [[UIImageView alloc]init];
        self.image1 = image1;
        [viewall addSubview:image1];
        
        UILabel *label1 = [[UILabel alloc]init];
        self.label1 = label1;
        [viewall addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]init];
        self.label2 = label2;
        [viewall addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]init];
        self.label3 = label3;
        [viewall addSubview:label3];
        
        UIView *view = [[UIView alloc]init];
        [viewall addSubview:view];
        
        UILabel *labelL = [[UILabel alloc]init];
        self.labelL = labelL;
        [viewall addSubview:labelL];
        
        UILabel *labelM = [[UILabel alloc]init];
        self.labelM = labelM;
        [viewall addSubview:labelM];
        
        UILabel *labelR = [[UILabel alloc]init];
        self.labelR = labelR;
        [viewall addSubview:labelR];
        
        UILabel *labelL1 = [[UILabel alloc]init];
        self.labelL1 = labelL1;
        [viewall addSubview:labelL1];
        
        UILabel *labelM1 = [[UILabel alloc]init];
        self.labelM1 = labelM1;
        [viewall addSubview:labelM1];
        
        UILabel *labelR1 = [[UILabel alloc]init];
        self.labelR1 = labelR1;
        [viewall addSubview:labelR1];
        
        UIImageView *image2 = [[UIImageView alloc]init];
        self.image2 = image2;
        [viewall addSubview:image2];
        
        UIImageView *head = [[UIImageView alloc]init];
        [self.contentView addSubview:head];
        
        [viewback mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(head.mas_centerX).offset(0);
            make.top.equalTo(viewall).offset(0);
            make.bottom.equalTo(head).offset(0);
            make.left.equalTo(viewall.mas_right).offset(-cornerRadiusCHAT);
        }];
        
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(0);
            make.height.equalTo(@(WIDTHICONCHAT));
            make.width.equalTo(@(WIDTHICONCHAT));
        }];

        [viewall mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(50*WIDTHICON);
            make.right.equalTo(head.mas_left).offset(0);
            make.top.equalTo(self).offset(SPAINGHICONCHAT);;
            make.bottom.equalTo(self).offset(-15);
        }];
        
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewall).offset(10);
            make.width.equalTo(@16);
            make.top.equalTo(viewall).offset(5);;
            make.height.equalTo(@16);
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.mas_right).offset(5);
            make.right.equalTo(label2.mas_left).offset(-5);
            make.top.equalTo(image1).offset(0);
            make.bottom.equalTo(image1).offset(0);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(5);
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
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewall).offset(0);
            make.right.equalTo(viewall).offset(0);
            make.top.equalTo(label3.mas_bottom).offset(10);
            make.height.equalTo(@1);
        }];
        
        [labelL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1).offset(0);
//            make.right.equalTo(labelM.mas_left).offset(-5);
            make.top.equalTo(view).offset(10);
            make.height.equalTo(@13);
//            make.width.equalTo(@[labelR]);
//            make.width.equalTo(@[labelM,labelR,labelL1,labelM1,labelR1]);
            make.height.equalTo(@[labelM,labelR]);
        }];
        [labelM mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(labelR.mas_left).offset(-5);
            make.centerX.equalTo(viewall.mas_centerX);
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
            make.right.equalTo(viewall).offset(-10);
            make.top.equalTo(labelL).offset(0);
            make.bottom.equalTo(labelL).offset(0);
        }];
        
        [labelL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelL).offset(0);
            make.right.equalTo(labelL).offset(0);
            make.height.equalTo(@10);
            make.top.equalTo(labelL.mas_bottom).offset(10);
            make.bottom.equalTo(viewall).offset(-10);
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
        label1.font = [UIFont systemFontOfSize:10];
        label2.font = [UIFont systemFontOfSize:10 weight:1.3];
        label3.font = [UIFont systemFontOfSize:10];

        labelL.font = [UIFont systemFontOfSize:13];
        labelM.font = [UIFont systemFontOfSize:11];
        labelR.font = [UIFont systemFontOfSize:13];
        
        labelL1.font = [UIFont systemFontOfSize:10];
        labelM1.font = [UIFont systemFontOfSize:10];
        labelR1.font = [UIFont systemFontOfSize:10];
        
        label1.textColor = RGBColor(24, 35, 52);
        label2.textColor = RGBColor(24, 35, 52);
        label3.textColor = RGBColor(24, 35, 52);
        labelL.textColor = RGBColor(24, 35, 52);
        labelM.textColor = RGBColor(82, 82, 82);
        labelR.textColor = RGBColor(24, 35, 52);
        labelL1.textColor = RGBColor(24, 35, 52);
        labelM1.textColor = RGBColor(82, 82, 82);
        labelR1.textColor = RGBColor(24, 35, 52);

        head.layer.cornerRadius = WIDTHICONCHAT/2.0;
        head.layer.masksToBounds = YES;
        head.backgroundColor = RGBColor(223, 224, 225);
        viewall.backgroundColor = RGBColor(223, 224, 225);
        view.backgroundColor = RGBColor(207, 208, 209);
        self.backgroundColor = [UIColor clearColor];
        viewback.backgroundColor = RGBColor(223, 224, 225);
        labelR.textAlignment = NSTextAlignmentRight;
        labelM.textAlignment = NSTextAlignmentCenter;
        labelL1.textAlignment = NSTextAlignmentCenter;
        labelM1.textAlignment = NSTextAlignmentCenter;
        labelR1.textAlignment = NSTextAlignmentCenter;
        viewall.layer.cornerRadius = cornerRadiusCHAT;
        viewall.layer.masksToBounds = YES;
        //test
        label1.text = @"南方航空";
        label2.text = @"ZH-9868";
        label3.text = @"2016-09-01 星期天 农历八月初一";
        
        labelL.text = @"上海虹桥T2";
        labelM.text = @"(经)";
        labelR.text = @"北京首都T3";
        labelL1.text = @"10:30";
//        labelM1.text = @"11:45";
        labelR1.text = @"13:20";
        image2.image = [UIImage imageNamed:@"矩形19"];
        image1.image = [UIImage imageNamed:@"aa_1"];
        
        if ([[Ticket sharedInstance]judgeIsLOgin]) {
            UIImage *tmp = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:ZEJIICON];
            if (tmp) {
                head.image = tmp;
            }else{
                [head sd_setImageWithURL:[NSURL URLWithString:[Ticket sharedInstance].userinfo.avatar] placeholderImage:[UIImage imageNamed:@"img_head portrait"]];
            }
        }else{
            head.image = [UIImage imageNamed:@"chatListCellHead"];
        }

    }
    return self;
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:dataDic[@"airLogo"]]];
    
    self.label1.text = dataDic[@"airName"];
    self.label2.text = dataDic[@"flightNo"];
//    NSString *timeee = [NSString stringWithFormat:@"%@  %@",dataDic[@"date"],dataDic[@"cabinType"]];
    self.label3.text = dataDic[@"date"];
//    self.label3.text  =timeee;
    
    self.labelL.text = dataDic[@"depCityName"];
//    self.labelM.text = dataDic[@"airName"];
    self.labelR.text = dataDic[@"arrCityName"];
    
    self.labelL1.text = dataDic[@"depTime"];
//    self.labelM1.text = dataDic[@"airName"];
    self.labelR1.text = dataDic[@"arrTime"];
    
    /*
    NSString *str1 = dataDic[@"stopFlag"];
    str1 = @"1";
    if ([str1 isEqualToString:@"1"]) {
        NSString *str2 = dataDic[@"stopCity"];
        NSString *str3 = dataDic[@"stopTime"];
        if ([str2 hasPrefix:@"(经)"]) {
            self.labelM.text = str2;
        } else {
            self.labelM.text = [@"(经)" stringByAppendingString:str2];
        }
        self.labelM1.text = str3;
    } else {
        self.labelM.text = @"";
        self.labelM1.text = @"";
    }
     */
    NSString *str2 = dataDic[@"stopCityName"];  //qxc
    NSString *str3 = dataDic[@"stopTime"];
    if (str2 && str2.length>0) {
        if ([str2 hasPrefix:@"(经)"]) {
            self.labelM.text = str2;
        } else {
            self.labelM.text = [@"(经)" stringByAppendingString:str2];
        }
    }else{
        self.labelM.text = @"";
    }
    self.labelM1.text = str3;
}
@end
