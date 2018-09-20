//
//  ChooseNationalityHead.m
//  jipiao
//
//  Created by Store on 2017/5/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ChooseNationalityHead.h"
#import "DefineUI.h"
#import "Masonry.h"
#import "HeaderTotal.h"

@interface ChooseNationalityHead ()
@property (nonatomic,weak) UILabel *label;
@end

@implementation ChooseNationalityHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorWithHex(0xFFFFFF, 0.2);
        UILabel *label = [UILabel new];
        [self addSubview:label];
        self.label = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        label.font = PingFangSC_Regular(12);
        label.textColor = ColorWithHex(0xFFFFFF, 0.5);
    }
    return self;
}
- (void)setHeadStr:(NSString *)headStr{
    _headStr = headStr;
    self.label.text = headStr;
}
@end
