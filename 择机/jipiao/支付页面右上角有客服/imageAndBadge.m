//
//  imageAndBadge.m
//  jipiao
//
//  Created by Store on 16/9/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "imageAndBadge.h"
#import "HeaderTotal.h"

#define WidthBadgeLabel  15

@interface imageAndBadge ()
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UILabel *badgeNum;
@end


@implementation imageAndBadge
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc]init];
        image.userInteractionEnabled = YES;
        [self addSubview:image];
        UILabel *badgeNum = [[UILabel alloc]init];
        [self addSubview:badgeNum];
        self.image = image;
        self.badgeNum = badgeNum;
        self.badgeNum.hidden = YES;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [badgeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(8);
            make.top.equalTo(self).offset(-8);
            make.width.equalTo(@(WidthBadgeLabel-3));
            make.height.equalTo(@(WidthBadgeLabel-3));
        }];
        badgeNum.textAlignment = NSTextAlignmentCenter;
        badgeNum.backgroundColor = [UIColor redColor];
        badgeNum.textColor = [UIColor whiteColor];
        badgeNum.font = [UIFont systemFontOfSize:10];
        badgeNum.layer.cornerRadius = (WidthBadgeLabel-3)/2.0;
        badgeNum.layer.masksToBounds = YES;
    }
    return self;
}
- (void)setIcon:(NSString *)icon{
    _icon = icon;
    self.image.image = [UIImage imageNamed:icon];
}
- (void)setNum:(NSString *)num{
    _num = num;
    if ([num integerValue]) {
        self.badgeNum.hidden = NO;
        self.badgeNum.text = num;
    } else {
        self.badgeNum.text = num;
        self.badgeNum.hidden = YES;
    }
    if (self.hidenNum) {
        self.badgeNum.hidden = YES;
    } else {
        self.badgeNum.hidden = NO;
    }
}
- (void)setHidenNum:(BOOL)hidenNum{
    _hidenNum = hidenNum;
    if (hidenNum) {
        self.badgeNum.hidden = YES;
    } else {
        self.badgeNum.hidden = NO;
    }
}
@end
