//
//  CustomMessageCellThree.m
//  jipiao
//
//  Created by Store on 16/11/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CustomMessageCellThree.h"
#import "HeaderTotal.h"
#import "Zhifugp.h"

@interface CustomMessageCellThree ()
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

@implementation CustomMessageCellThree
-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarCornerRadius = WIDTHICONCHAT/2.0;
    self.avatarSize = WIDTHICONCHAT;
    //    self.leftBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    //    self.rightBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    self.messageNameHeight = SPAINGHICONCHAT;
    self.messageNameIsHidden = YES;
    self.bubbleMaxWidth = screenWidth - 30*WIDTHICON - 2*WIDTHICONCHAT;
    self.bubbleView.textLabel.hidden = YES;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<IMessageModel>)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier model:model];
    if (self) {

        UIImageView *image1 = [[UIImageView alloc]init];
        self.image1 = image1;
        [self.contentView addSubview:image1];
        
        UILabel *label1 = [[UILabel alloc]init];
        self.label1 = label1;
        [self.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]init];
        self.label2 = label2;
        [self.contentView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]init];
        self.label3 = label3;
        [self.contentView addSubview:label3];
        
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        
        UILabel *labelL = [[UILabel alloc]init];
        self.labelL = labelL;
        [self.contentView addSubview:labelL];
        
        UILabel *labelM = [[UILabel alloc]init];
        self.labelM = labelM;
        [self.contentView addSubview:labelM];
        
        UILabel *labelR = [[UILabel alloc]init];
        self.labelR = labelR;
        [self.contentView addSubview:labelR];
        
        UILabel *labelL1 = [[UILabel alloc]init];
        self.labelL1 = labelL1;
        [self.contentView addSubview:labelL1];
        
        UILabel *labelM1 = [[UILabel alloc]init];
        self.labelM1 = labelM1;
        [self.contentView addSubview:labelM1];
        
        UILabel *labelR1 = [[UILabel alloc]init];
        self.labelR1 = labelR1;
        [self.contentView addSubview:labelR1];
        
        UIImageView *image2 = [[UIImageView alloc]init];
        self.image2 = image2;
        [self.contentView addSubview:image2];

        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bubbleView).offset(10);
            make.width.equalTo(@16);
            make.top.equalTo(self.bubbleView).offset(5);;
            make.height.equalTo(@16);
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image1.mas_right).offset(5);
//            make.right.equalTo(label2.mas_left).offset(-5);
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
            make.left.equalTo(self.bubbleView).offset(0);
            make.right.equalTo(self.bubbleView).offset(0);
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
            make.centerX.equalTo(self.bubbleView.mas_centerX);
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
            make.right.equalTo(self.bubbleView).offset(-10);
            make.top.equalTo(labelL).offset(0);
            make.bottom.equalTo(labelL).offset(0);
        }];

        [labelL1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelL).offset(0);
//            make.right.equalTo(labelL).offset(0);
            make.height.equalTo(@10);
            make.top.equalTo(labelL.mas_bottom).offset(10);
//            make.bottom.equalTo(self.bubbleView).offset(-10);
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
        

        view.backgroundColor = RGBColor(207, 208, 209);
        self.backgroundColor = [UIColor clearColor];

        labelR.textAlignment = NSTextAlignmentRight;
        labelM.textAlignment = NSTextAlignmentCenter;
        labelL1.textAlignment = NSTextAlignmentCenter;
        labelM1.textAlignment = NSTextAlignmentCenter;
        labelR1.textAlignment = NSTextAlignmentCenter;
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
        
        UITapGestureRecognizer *tep = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellClisk)];
        [self.bubbleView addGestureRecognizer:tep];
        self.bubbleView.userInteractionEnabled = YES;
    }
    return self;
}
- (void)cellClisk{
    NSLog(@"sdf");
    NSDictionary *tmp = self.model.message.ext;
    NSDictionary *dataDic = tmp[TSZFTSZF];
    dataDic = dataDic[Myorder];
//    NSMutableDictionary *mudic = [[NSMutableDictionary alloc]init];
//    if ([[dataDic allKeys]containsObject:@"depDate"] && [[dataDic allKeys]containsObject:@"depCityCode"] && [[dataDic allKeys]containsObject:@"flightNo"] && [[dataDic allKeys]containsObject:@"arrCityCode"]) {
//        [mudic setObject:dataDic[@"depDate"] forKey:@"depDate"];
//        [mudic setObject:dataDic[@"depCityCode"] forKey:@"depCityCode"];
//        [mudic setObject:dataDic[@"flightNo"] forKey:@"flightNo"];
//        [mudic setObject:dataDic[@"arrCityCode"] forKey:@"arrCityCode"];
//        Zhifugp *bill = [[Zhifugp alloc]init];
//        NSDictionary *tmpdic = @{@"queryFlightDetailContext":[NSString dictionaryToJsonForJs:mudic]};
//        bill.CookieDic = tmpdic;
//        bill.url = zhifugoupiaoURL;
//        [NaVc pushViewController:bill animated:YES];
//    }
    

        Zhifugp *bill = [[Zhifugp alloc]init];
        NSDictionary *tmpdic = @{@"queryFlightDetailContext":[NSString dictionaryToJsonForJs:dataDic]};
    
//    NSDictionary *tt1 = @{@"sdf":@"我是汉子"};
//    NSString *strTT1 = [NSString stringWithFormat:@"%@",[dataDic description]];
//    NSLog(@"strTT1=%@",strTT1);
//    
//    NSString *strTT2 = [strTT1 stringByReplacingOccurrencesOfString:@"\n" withString:@"\""];
//    NSLog(@"strTT2=%@",strTT2);
//    
//    NSString *strTT3 = [strTT2 stringByReplacingOccurrencesOfString:@"=" withString:@"\":\""];
//    NSLog(@"strTT3=%@",strTT3);
//    
//    NSString *strTT4 = [strTT3 stringByReplacingOccurrencesOfString:@";" withString:@"\","];
//    NSLog(@"strTT3=%@",strTT4);
//
//    NSString *strTT5 = [strTT4 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"strTT3=%@",strTT5);
//    
//    NSString *str1 = @"我df";
//    NSString *str2 = [str1 stringByAddingPercentEscapesUsingEncoding:NSNonLossyASCIIStringEncoding];
//    NSLog(@"str1=%@",str1);
//    NSLog(@"str2=%@",str2);
//    
//    NSString *str3 = [NSString stringWithFormat:@"{\"sdf\":\"%@\"}",str2];
//    NSLog(@"str3=%@",str3);
//    
//    NSDictionary *tmpdic = @{@"queryFlightDetailContext":strTT5};
    
    
//    NSDictionary *tmpdic = @{@"queryFlightDetailContext":@"{\"sdf\":\"%u6211\"}"};
    
    
//    NSString *tmp11 = @"我的";
//
//    
//    NSString *nameTmp22 = [tmp11 stringByReplacingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
//    
//    

//
    
//    NSString *ttt = dataDic[@"tesqwet"];
//    NSString * string4 = [ttt  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    string4 = [ttt  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *tmpdic = @{@"queryFlightDetailContext":ttt};
    
//    NSLog(@"ttt=%@",ttt);
//    NSLog(@"ttt=%@",ttt);
    
//    NSString *str = @"我来了";
//    str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSDictionary *tmpdic = @{@"queryFlightDetailContext":[NSString stringWithFormat:@"{\"accidentPrice\":\"%@\"}",str]};
        bill.CookieDic = tmpdic;
        bill.url = zhifugoupiaoURL;
        [NaVc pushViewController:bill animated:YES];
}
- (void)setModel:(id<IMessageModel>)model{
    NSDictionary *tmp = model.message.ext;
    NSDictionary *dataDic = tmp[TSZFTSZF];
    dataDic = dataDic[Myorder];
    model.text = [NSString stringWithFormat:@"我正在看 %@%@到%@ 的航班",dataDic[@"depDate"]?dataDic[@"depDate"]:@"",dataDic[@"depCityName"],dataDic[@"arrCityName"]];

    [super setModel:model];
    //    label.attributedText = [GlobalObject attributedStringWithText:@"msgCo[(-T)]ntent"];
    //    IMessageModel>)model  model.text

//    NSDictionary *tmp = model.message.ext;
//    NSDictionary *dataDic = tmp[TSZFTSZF];
//    dataDic = dataDic[@"order"];
    
//    tmp = tmp[@"track"];
//    NSString *strr = tmp[@"titl1e"];
//    NSDictionary *dataDic = [NSString dictionaryWithJsonString:strr];
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:dataDic[@"airLogo"]]];
    
    self.label1.text = dataDic[@"airName"];
    self.label2.text = dataDic[@"flightNo"];
    
//    self.label3.text = dataDic[@"depDate"];
    
        NSString *timeee = dataDic[@"depDate"];
      NSString *timeee2 = dataDic[@"cabinType"];
    
    if (timeee2 && timeee2.length) {
        timeee = [timeee stringByAppendingString:@"  "];
        timeee = [timeee stringByAppendingString:timeee2];
    }
        self.label3.text  =timeee;
    
    
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
