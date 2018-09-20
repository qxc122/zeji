//
//  twomycell.m
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "twomycell.h"
#import "HeaderTotal.h"
#import "myzhangdang.h"
@interface twomycell ()
@property (nonatomic,weak) UILabel *one;
@property (nonatomic,weak) UILabel *two;
@property (nonatomic,weak) UILabel *three;
@property (nonatomic,weak) UILabel *four;
@end

#define fronalltext  14*WIDTHICON

@implementation twomycell
#define twomycellIdentifier @"twomycellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    
    twomycell *cell = [tableView dequeueReusableCellWithIdentifier:twomycellIdentifier];
    if (cell == nil) {
        cell = [[twomycell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twomycellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *one1 = [[UILabel alloc]init];
        [self.contentView addSubview:one1];
        UILabel *two1 = [[UILabel alloc]init];
        [self.contentView addSubview:two1];
        UILabel *three1 = [[UILabel alloc]init];
        [self.contentView addSubview:three1];
        UILabel *four1 = [[UILabel alloc]init];
        [self.contentView addSubview:four1];
        
        UILabel *one = [[UILabel alloc]init];
        self.one = one;
        [self.contentView addSubview:one];
        UILabel *two = [[UILabel alloc]init];
        self.two = two;
        [self.contentView addSubview:two];
        UILabel *three = [[UILabel alloc]init];
        self.three = three;
        [self.contentView addSubview:three];
        UILabel *four = [[UILabel alloc]init];
        self.four = four;
        [self.contentView addSubview:four];
        
        UIButton *btn =[[UIButton alloc]init];
        btn.backgroundColor = RGBColor(235, 63, 66);
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(btnClickTwoww) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"查看我的信用账单" forState:UIControlStateNormal];
        
        [one1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(20);
            make.bottom.equalTo(one.mas_top).offset(-8);
            make.right.equalTo(two1.mas_left).offset(0);
            make.width.equalTo(@[four1,two1,three1,one,two,three,four]);
            make.height.equalTo(@[four1,two1,three1,one,two,three,four]);
        }];
        [two1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(one1.mas_right).offset(0);
            make.top.equalTo(one1).offset(0);
            make.bottom.equalTo(one1).offset(0);
            make.right.equalTo(three1.mas_left).offset(0);
        }];
        [three1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(two1.mas_right).offset(0);
            make.top.equalTo(one1).offset(0);
            make.bottom.equalTo(one1).offset(0);
            make.right.equalTo(four1.mas_left).offset(0);
        }];
        [four1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(three1.mas_right).offset(0);
            make.top.equalTo(one1).offset(0);
            make.bottom.equalTo(one1).offset(0);
            make.right.equalTo(self).offset(0);
        }];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(one1).offset(0);
            make.top.equalTo(one1.mas_bottom).offset(0);
//            make.bottom.equalTo(btn.mas_top).offset(0);
            make.right.equalTo(one1).offset(0);
        }];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(two1).offset(0);
            make.top.equalTo(one).offset(0);
            make.bottom.equalTo(one).offset(0);
            make.right.equalTo(two1).offset(0);
        }];
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(three1).offset(0);
            make.top.equalTo(one).offset(0);
            make.bottom.equalTo(one).offset(0);
            make.right.equalTo(three1).offset(0);
        }];
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(four1).offset(0);
            make.top.equalTo(one).offset(0);
            make.bottom.equalTo(one).offset(0);
            make.right.equalTo(four1).offset(0);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(25);
            make.top.equalTo(one.mas_bottom).offset(15);
            make.bottom.equalTo(self).offset(-19);
            make.right.equalTo(self).offset(-25);
            make.height.equalTo(@42);
        }];
        
        one1.font = [UIFont systemFontOfSize:fronalltext];
        one1.textColor = RGBColor(173, 173, 173);
        two1.font = [UIFont systemFontOfSize:fronalltext];
        two1.textColor = RGBColor(173, 173, 173);
        three1.font = [UIFont systemFontOfSize:fronalltext];
        three1.textColor = RGBColor(173, 173, 173);
        four1.font = [UIFont systemFontOfSize:fronalltext];
        four1.textColor = RGBColor(173, 173, 173);
        
        one.font = [UIFont systemFontOfSize:fronalltext];
        one.textColor = RGBColor(255, 255, 255);
        two.font = [UIFont systemFontOfSize:fronalltext];
        two.textColor = RGBColor(255, 255, 255);
        three.font = [UIFont systemFontOfSize:fronalltext];
        three.textColor = RGBColor(255, 255, 255);
        four.font = [UIFont systemFontOfSize:fronalltext];
        four.textColor = RGBColor(255, 255, 255);
        
        one1.textAlignment = NSTextAlignmentCenter;
        two1.textAlignment = NSTextAlignmentCenter;
        three1.textAlignment = NSTextAlignmentCenter;
        four1.textAlignment = NSTextAlignmentCenter;
        one.textAlignment = NSTextAlignmentCenter;
        two.textAlignment = NSTextAlignmentCenter;
        three.textAlignment = NSTextAlignmentCenter;
        four.textAlignment = NSTextAlignmentCenter;
        
        one1.text = @"飞行等级";
        two1.text = @"累积航程(段)";
        three1.text = @"累积里程";
        four1.text = @"飞行信用额度";
    }
    return self;
}
- (void)btnClickTwoww{
    myzhangdang *vc = [[myzhangdang alloc]init];
    vc.title  =@"我的账单";
    [NaVc pushViewController:vc animated:YES];
    
//    if ([self.delegate respondsToSelector:@selector(twomycellmybtnClick)]) {
//        [self.delegate twomycellmybtnClick];
//    }
}
- (void)setData:(flyCreditInfoData *)data{
    _data = data;
    self.one.text = data.flylevel;
    self.two.text = data.totalFlight;
    self.three.text = data.totalMileage;
    self.four.text = data.creditLimit;
}
@end
