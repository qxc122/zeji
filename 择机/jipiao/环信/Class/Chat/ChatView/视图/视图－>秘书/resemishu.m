//
//  resemishu.m
//  jipiao
//
//  Created by Store on 16/8/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "resemishu.h"
#import "HeaderTotal.h"
#import "onetwohha.h"

#define WiDTHcir1resemishu   8   //左右的圆圈的宽高
#define WiDTHFontresemishu   1.4   //字体宽
@interface resemishu ()
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) onetwohha *one;
@property (nonatomic,weak) onetwohha *two;
@end

@implementation resemishu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc]init];
        self.label = label;
        [self addSubview:label];
        UILabel *label1 = [[UILabel alloc]init];
        [self addSubview:label1];
        UILabel *label2 = [[UILabel alloc]init];
        [self addSubview:label2];
        onetwohha *one = [[onetwohha alloc]init];
        self.one = one;
        [self addSubview:one];
        
        UIView *view1 = [[UIView alloc]init];
        [self addSubview:view1];
        
        onetwohha *two = [[onetwohha alloc]init];
        self.two = two;
        [self addSubview:two];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@10);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(5);
            make.top.equalTo(label1).offset(0);
            make.bottom.equalTo(label1).offset(0);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(0);
            make.top.equalTo(label).offset(0);
            make.bottom.equalTo(label).offset(0);
        }];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(label.mas_bottom).offset(0);
            make.height.equalTo(@61);
            make.height.equalTo(@[two]);
        }];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(one.mas_bottom).offset(0);
            make.height.equalTo(@1);
        }];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(one).offset(0);
            make.right.equalTo(one).offset(0);
            make.top.equalTo(view1.mas_bottom).offset(0);
            make.bottom.equalTo(self).offset(0);
        }];
        view1.backgroundColor = RGBColor(134, 134, 134);
        label1.text = @"我正在查询";
        label2.text = @"的航班";
        label.textColor = RGBColor(235, 78, 82);
        label1.textColor = RGBColor(24, 35, 52);
        label2.textColor = RGBColor(24, 35, 52);
        label.font = [UIFont systemFontOfSize:10];
        label1.font = [UIFont systemFontOfSize:10];
        label2.font = [UIFont systemFontOfSize:10];
        //test
        label.text = @" 2016年9月1日 上海到昆明";
    }
    return self;
}
@end
