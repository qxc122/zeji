//
//  datePiker.m
//  TourismT
//
//  Created by Store on 2017/1/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "datePiker.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"
#import "UIImage+cir.h"
#import "DateTools.h"
@interface datePiker ()
@property (nonatomic,weak) UIView *back; //
@property (nonatomic, weak) UIDatePicker *myDatePicker;
@end

@implementation datePiker
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blcak = [[UIView alloc]init];
        blcak.backgroundColor = ColorWithHex(0x000000, 0.5);
        [self addSubview:blcak];
        
        UIDatePicker *myDatePicker = [[UIDatePicker alloc] init];
        self.myDatePicker  =myDatePicker;
        [self addSubview:myDatePicker];
        myDatePicker.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        

        
        [myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        
        UIButton *change = [[UIButton alloc]init];
        [self addSubview:change];
        change.tag = 0;
        [change addTarget:self action:@selector(btnClilc:) forControlEvents:UIControlEventTouchUpInside];
        
        [change setTitle:@"取消" forState:UIControlStateNormal];
        [change setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        change.titleLabel.font = PingFangSC_Regular(14);
        
        
        UIButton *okok = [[UIButton alloc]init];
        [self addSubview:okok];
        okok.tag = 1;
        [okok addTarget:self action:@selector(btnClilc:) forControlEvents:UIControlEventTouchUpInside];
        [okok setTitle:@"确定" forState:UIControlStateNormal];
        [okok setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        okok.titleLabel.font = PingFangSC_Regular(14);
        
        [blcak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [myDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@(200));
            make.bottom.equalTo(self);
        }];
        [change mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myDatePicker);
            make.width.equalTo(@(44));
            make.height.equalTo(@(30));
            make.top.equalTo(myDatePicker);
        }];
        [okok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(myDatePicker);
            make.width.equalTo(@(44));
            make.height.equalTo(@(30));
            make.top.equalTo(myDatePicker);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeClisck)];
        [blcak addGestureRecognizer:tap];
    }
    return self;
}
- (void)closeClisck{
//    NSDate *theDate = self.myDatePicker.date;//该属性返回选中的时间
//    NSString *ddddd = [theDate formattedDateWithFormat:@"YYYY-MM-DD"];

    if (self.nextClick) {
        NSDate *theDate = self.myDatePicker.date;//该属性返回选中的时间
        NSString *ddddd = [theDate formattedDateWithFormat:@"YYYY-MM-dd"];
        self.nextClick(ddddd);
    }
    [self removeFromSuperview];
}
- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];
    
}
- (void)btnClilc:(UIButton *)btn{
    if (btn.tag == 0) {//取消
        [self removeFromSuperview];
    } else {
        [self closeClisck];
    }
}

- (void)setMaxDate:(NSDate *)maxDate{
    _maxDate  = maxDate;
    self.myDatePicker.maximumDate = maxDate;
}
- (void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    self.myDatePicker.minimumDate = minDate;
}
@end
