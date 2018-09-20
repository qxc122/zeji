//
//  headmyinfo.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "headmyinfo.h"
#import "Masonry.h"
#import "HeaderTotal.h"
@interface headmyinfo ()
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UIButton *btn;
@end

@implementation headmyinfo
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(64, 68, 83);
        
        UIImageView *image = [[UIImageView alloc]init];
        self.image = image;
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]init];
        self.label = label;
        [self addSubview:label];
        
        
        UIButton *btn = [[UIButton alloc]init];
        self.btn = btn;
        [self addSubview:btn];

        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18);
            make.centerY.equalTo(self);
            make.top.equalTo(self).offset(4);
            make.bottom.equalTo(self).offset(-4);
            make.width.equalTo(image.mas_height);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(5);
            make.right.equalTo(btn.mas_left).offset(-10);
            make.top.equalTo(image);
            make.bottom.equalTo(image);
        }];

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-21);
            make.top.equalTo(image);
            make.width.equalTo(btn.mas_height);
            make.bottom.equalTo(image);
        }];
        
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = RGBColor(255, 255, 255);
        
        //测试
//        image.image = [UIImage imageNamed:@"icon_add to"];
//        label.text = @"我是标题";
    }
    return self;
}

- (void)setIcon:(NSString *)icon{
    _icon = icon;
    self.image.image = [UIImage imageNamed:icon];
}
- (void)setDes:(NSString *)des{
    _des = des;
    self.label.text = des;
}
//- (void)setIsHiden:(NSString *)isHiden{
//    _isHiden = isHiden;
//    self.btn.hidden = [isHiden boolValue];
//}
- (void)btnClickHead{
    self.value = [self.value isEqualToString:@"0"]?@"1":@"0";
    if ([self.delegate respondsToSelector:@selector(headClick::)]) {
        [self.delegate headClick:self.index :self.value];
    }
}
- (void)setBtnImage:(NSString *)btnImage{
    _btnImage = btnImage;
    if (btnImage) {
        self.btn.hidden = NO;
        [self.btn setImage:[UIImage imageNamed:btnImage] forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClickHead) forControlEvents:UIControlEventTouchUpInside];
    } else {
        self.btn.hidden = YES;
    }
}
@end
