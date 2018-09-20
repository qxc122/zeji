//
//  listTwo.m
//  jipiao
//
//  Created by Store on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "listTwo.h"
#import "HeaderTotal.h"

@interface listTwo ()
@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UILabel *label2;
@property (nonatomic,weak) UILabel *label3;
@property (nonatomic,weak) UILabel *label4;
@end

@implementation listTwo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label1 = [[UILabel alloc]init];
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]init];
        [self addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]init];
        [self addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc]init];
        [self addSubview:label4];
        
        self.label1 = label1;
        self.label2 = label2;
        self.label3 = label3;
        self.label4 = label4;
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(@[label2,label3,label4]);
            make.height.equalTo(@[label2,label3,label4]);
            make.left.equalTo(self);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1);
            make.bottom.equalTo(label1);
            make.left.equalTo(label1.mas_right);
        }];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1);
            make.bottom.equalTo(label1);
            make.left.equalTo(label2.mas_right);
        }];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1);
            make.bottom.equalTo(label1);
            make.left.equalTo(label3.mas_right);
            make.right.equalTo(self);
        }];
        label1.textColor = RGBACOLOR(255, 255, 255, 1);
        label2.textColor = RGBACOLOR(255, 255, 255, 1);
        label3.textColor = RGBACOLOR(255, 255, 255, 1);
        label4.textColor = RGBACOLOR(255, 255, 255, 1);
        label1.font = [UIFont fontWithName:@"Helvetica" size:12];
        label2.font = [UIFont fontWithName:@"Helvetica" size:12];
        label3.font = [UIFont fontWithName:@"Helvetica" size:12];
        label4.font = [UIFont fontWithName:@"Helvetica" size:12];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label3.textAlignment = NSTextAlignmentCenter;
        label4.textAlignment = NSTextAlignmentCenter;
        self.label1.text = @"日期";
        self.label2.text = @"信用透支";
        self.label3.text = @"剩余本金";
        self.label4.text = @"手续费";
    }
    return self;
}
- (void)setData:(xinyongdataOne *)data{
    self.label1.text = data.loanDate;
//    self.label2.text = data.loanAmt;
//    self.label3.text = data.remainPrinc;
//    self.label4.text = data.remainInt;
    self.label2.text = [NSString stringWithFormat:@"%@",data.loanAmt];
    self.label3.text = [NSString stringWithFormat:@"%@",data.remainPrinc];
    self.label4.text = [NSString stringWithFormat:@"%@",data.remainInt];
}
- (void)setIsLastTotal:(BOOL)IsLastTotal{
    _IsLastTotal = IsLastTotal;
    if (IsLastTotal) {
        self.label1.textColor = RGBACOLOR(235, 63, 66, 1);
        self.label2.textColor = RGBACOLOR(235, 63, 66, 1);
        self.label3.textColor = RGBACOLOR(235, 63, 66, 1);
        self.label4.textColor = RGBACOLOR(235, 63, 66, 1);
        self.label1.text = @"合计";
    } else {
        self.label1.textColor = RGBACOLOR(255, 255, 255, 1);
        self.label2.textColor = RGBACOLOR(255, 255, 255, 1);
        self.label3.textColor = RGBACOLOR(255, 255, 255, 1);
        self.label4.textColor = RGBACOLOR(255, 255, 255, 1);
    }
}
@end
