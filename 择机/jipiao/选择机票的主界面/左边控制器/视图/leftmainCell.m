//
//  leftmainCell.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "leftmainCell.h"
#import "myinfo.h"
#import "zejiMain.h"
#import "MIBadgeButton.h"
#import "ChatDemoHelper.h"
#import "myzhangdang.h"

@interface leftmainCell ()
@property (nonatomic,weak) UILabel *num;
@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UIImageView *image1;
@end
#define WIDTHNUM  10

@implementation leftmainCell
#define leftmainCellIdentifier @"leftmainCellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    leftmainCell *cell = [tableView dequeueReusableCellWithIdentifier:leftmainCellIdentifier];
    if (cell == nil) {
        cell = [[leftmainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftmainCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label1 = [[UILabel alloc]init];
        self.label1 = label1;
        [self.contentView addSubview:label1];
        
        UIImageView *image1 = [[UIImageView alloc]init];
        self.image1 = image1;
        [self.contentView addSubview:image1];

        
        UIView *view1 = [[UIView alloc]init];
        [self addSubview:view1];
        view1.backgroundColor = Colorlines;
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(9);
            make.centerY.equalTo(self);
        }];
        [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(label1.mas_left).offset(-5);
            make.height.equalTo(@13);
            make.width.equalTo(@13);
        }];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@1);
            make.bottom.equalTo(self);
        }];
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)setIcon:(NSString *)icon{
    _icon = icon;
    if ([icon hasPrefix:@"http"]) {
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:icon]];
    } else {
        self.image1.image = [UIImage imageNamed:icon];
    }
}
- (void)setDes:(NSString *)des{
    _des = des;
    self.label1.text = des;
}
- (void)setNumWeidu:(NSString *)numWeidu{
    _numWeidu = numWeidu;
        if ([numWeidu integerValue]) {
            CGFloat widthNum = [NSString returnSizeWidthWithString:numWeidu font:FONTSIZE_BADGE];
            self.num.hidden = NO;
            self.num.text = numWeidu;
            CGFloat tmpW = 0;
            CGFloat tmpRadius = 0;
            if (widthNum < MINIWIDTHANDHEIGHTVALUE) {
                tmpW = MINIWIDTHANDHEIGHT;
                tmpRadius = MINIWIDTHANDHEIGHT/2.0;
            }else{
                tmpW = widthNum + 5;
                tmpRadius = 5.0;
                [self.num mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-5);
                    make.centerY.equalTo(self);
                    make.width.equalTo(@(tmpW));
                    make.height.equalTo(@(MINIWIDTHANDHEIGHT));
                }];
            }
            
            self.num.layer.cornerRadius = tmpRadius;
            self.num.layer.masksToBounds = YES;
        } else {
            self.num.hidden = YES;
            [self.num removeFromSuperview];
        }
}
- (UILabel *)num{
    if (!_num) {
        UILabel *num = [[UILabel alloc]init];
        [self.contentView addSubview:num];
        num.backgroundColor = [UIColor redColor];
        num.textColor = [UIColor whiteColor];
        num.textAlignment = NSTextAlignmentCenter;
        num.font = [UIFont systemFontOfSize:FONTSIZE_BADGE];
        num.hidden = YES;
        [num setAdjustsFontSizeToFitWidth:YES];
        self.num = num;
        
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-5);
            make.centerY.equalTo(self);
            make.width.equalTo(@(MINIWIDTHANDHEIGHT));
            make.height.equalTo(@(MINIWIDTHANDHEIGHT));
        }];
    }
    return _num;
}
@end
