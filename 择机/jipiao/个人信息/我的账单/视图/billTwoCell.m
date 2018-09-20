//
//  billTwoCell.m
//  jipiao
//
//  Created by Store on 16/9/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "billTwoCell.h"
#import "HeaderTotal.h"
#import "listTwo.h"

@interface billTwoCell ()
@property (nonatomic,weak) UIView *viewtest;
@property (nonatomic,weak) UIImageView *image43;
@property (nonatomic,weak) UILabel *label12;
@property (nonatomic,weak) UILabel *label13;
@property (nonatomic,weak) UILabel *label21;
@property (nonatomic,weak) UILabel *label22;
@property (nonatomic,weak) UILabel *label23;
@property (nonatomic,weak) UILabel *label31;
@property (nonatomic,weak) UILabel *label32;
@property (nonatomic,weak) UILabel *label33;
@property (nonatomic,weak) UILabel *label41;
@property (nonatomic,weak) UILabel *label42;
@property (nonatomic,weak) UILabel *label43;
@property (nonatomic,weak) UIButton *labelbtn;
@property (nonatomic,weak) UILabel *labelbtnLatt;

@end


@implementation billTwoCell
//
//#define billTwoCellIdentifier @"billTwoCellIdentifier"
//+ (instancetype)returnCellWith:(UITableView *)tableView
//{
//    billTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:billTwoCellIdentifier];
//    if (cell == nil) {
//        cell = [[billTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:billTwoCellIdentifier];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(45, 58, 72,1);
        UIImageView *image = [[UIImageView alloc]init];
        [self addSubview:image];
        
        UILabel *label11 = [[UILabel alloc]init];
        [self addSubview:label11];
        
        UILabel *label111 = [[UILabel alloc]init];
        [self addSubview:label111];
        
        UILabel *label12 = [[UILabel alloc]init];
        [self addSubview:label12];
        UILabel *label13 = [[UILabel alloc]init];
        [self addSubview:label13];
        
        UILabel *label2 = [[UILabel alloc]init];
        [self addSubview:label2];
        UILabel *label21 = [[UILabel alloc]init];
        [self addSubview:label21];
        UILabel *label22 = [[UILabel alloc]init];
        [self addSubview:label22];
        UILabel *label23 = [[UILabel alloc]init];
        [self addSubview:label23];
        
        UILabel *label3 = [[UILabel alloc]init];
        [self addSubview:label3];
        UILabel *label31 = [[UILabel alloc]init];
        [self addSubview:label31];
        UILabel *label32 = [[UILabel alloc]init];
        [self addSubview:label32];
        UILabel *label33 = [[UILabel alloc]init];
        [self addSubview:label33];
        
        UILabel *label4 = [[UILabel alloc]init];
        [self addSubview:label4];
        UILabel *label41 = [[UILabel alloc]init];
        [self addSubview:label41];
        UILabel *label42 = [[UILabel alloc]init];
        [self addSubview:label42];
        UILabel *label43 = [[UILabel alloc]init];
        [self addSubview:label43];
        
        UIImageView *image43 = [[UIImageView alloc]init];
        self.image43 = image43;
        [self addSubview:image43];
        
        UIButton *btn = [[UIButton alloc]init];
        [self addSubview:btn];
        
        UILabel *labelbtn = [[UILabel alloc]init];
        self.labelbtnLatt = labelbtn;
        [self addSubview:labelbtn];
        
        UIView *rightView = [[UIView alloc]init];
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label3).offset(0);
            make.bottom.equalTo(label43).offset(0);
            make.right.equalTo(self).offset(0);
            make.left.equalTo(label13).offset(0);
            make.left.equalTo(label23).offset(0);
            make.left.equalTo(label33).offset(0);
            make.left.equalTo(label43).offset(0);
        }];
        
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@22);
            make.height.equalTo(@22);
        }];
        
        [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(image).offset(0);
            make.left.equalTo(image.mas_right).offset(3);
            make.height.equalTo(@19);
        }];
        label111.numberOfLines = 0;
        [label111 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label11).offset(0);
            make.left.equalTo(label11.mas_right).offset(5);
          //  make.right.equalTo(label12.mas_left).offset(-5);
            make.height.equalTo(@15);
        }];
        [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(image).offset(0);
            make.height.equalTo(@17);
            make.right.equalTo(self).offset(0);
//            make.width.equalTo(@(tmp));
        }];
        [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(image).offset(0);
            make.height.equalTo(@19);
            make.right.equalTo(label13.mas_left).offset(0);
        }];
        
        [label23 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label13).offset(0);
            make.height.equalTo(@14);
            make.top.equalTo(label13.mas_bottom).offset(12);
        }];
        [label22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label23).offset(0);
            make.right.equalTo(label12).offset(0);
            make.height.equalTo(@[label23]);
        }];
        [label33 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label13).offset(0);
            make.height.equalTo(@14);
            make.top.equalTo(label23.mas_bottom).offset(4);
        }];
        [label32 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label33).offset(0);
            make.right.equalTo(label12).offset(0);
            make.height.equalTo(@[label33]);
        }];
        [label43 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label13).offset(0);
            make.height.equalTo(@14);
            make.top.equalTo(label33.mas_bottom).offset(4);
        }];
        [image43 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label43.mas_right).offset(2);
            make.right.equalTo(rightView.mas_right).offset(-2);
            make.height.equalTo(@10);
            make.width.equalTo(@10);
            make.centerY.equalTo(label43).offset(0);
        }];
        
        [label42 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label43).offset(0);
            make.right.equalTo(label12).offset(0);
            make.height.equalTo(@[label43]);
        }];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label23).offset(0);
            make.height.equalTo(@[label23]);
            make.width.equalTo(@80);
            make.top.equalTo(label23).offset(0);
        }];
        [label21 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label23).offset(0);
            make.height.equalTo(@[label23]);
            make.top.equalTo(label23).offset(0);
            make.left.equalTo(label2.mas_right);
        }];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label33).offset(0);
            make.height.equalTo(@[label33]);
            make.width.equalTo(@80);
            make.top.equalTo(label33).offset(0);
        }];
        [label31 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label33).offset(0);
            make.height.equalTo(@[label33]);
            make.top.equalTo(label33).offset(0);
            make.left.equalTo(label3.mas_right);
        }];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label43).offset(0);
            make.height.equalTo(@[label43]);
            make.width.equalTo(@80);
            make.top.equalTo(label43).offset(0);
        }];
        [label41 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label43).offset(0);
            make.height.equalTo(@[label43]);
            make.top.equalTo(label43).offset(0);
            make.left.equalTo(label4.mas_right);
        }];
        
        [labelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.bottom.equalTo(self).offset(-12);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@42);
            make.bottom.equalTo(labelbtn.mas_top).offset(-5);
            make.left.equalTo(self).offset(25);
            make.right.equalTo(self).offset(-25);
        }];
        
        NSString *contentSTR = @"查看服务协议";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentSTR];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,contentSTR.length)];
        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:12.0] range:NSMakeRange(0,contentSTR.length)];
        [str addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(47, 191, 238, 1) range:NSMakeRange(0,contentSTR.length)];
        [str addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(0,contentSTR.length)];
        label111.attributedText = str;
        
        labelbtn.text = @"日手续费用万分之五";
        btn.backgroundColor = RGBACOLOR(235, 63, 66, 1.0);
        [btn setTitle:@"立即还款" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(btnClickBill) forControlEvents:UIControlEventTouchUpInside];
        labelbtn.textColor  =RGBACOLOR(255, 222, 0, 1);
        label11.textColor = RGBACOLOR(255, 255, 255, 1);
        label12.textColor = RGBACOLOR(255, 255, 255, 1);
        label13.textColor = RGBACOLOR(255, 255, 255, 1);
        label2.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label21.textColor = RGBACOLOR(255, 255, 255, 1);
        label22.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label23.textColor = RGBACOLOR(255, 255, 255, 1);
        label3.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label31.textColor = RGBACOLOR(255, 255, 255, 1);
        label32.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label33.textColor = RGBACOLOR(255, 255, 255, 1);
        label4.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label41.textColor = RGBACOLOR(255, 255, 255, 1);
        label42.textColor = RGBACOLOR(255, 255, 255, 0.5);
        label43.textColor = RGBACOLOR(255, 255, 255, 1);
        
        labelbtn.font = [UIFont fontWithName:@"Helvetica" size:12];
        label11.font = [UIFont fontWithName:@"Helvetica" size:19];
        label12.font = [UIFont fontWithName:@"Helvetica" size:19];
        label13.font = [UIFont fontWithName:@"Helvetica" size:19];
        
        label2.font = [UIFont fontWithName:@"Helvetica" size:14];
        label21.font = [UIFont fontWithName:@"Helvetica" size:14];
        label22.font = [UIFont fontWithName:@"Helvetica" size:14];
        label23.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        label3.font = [UIFont fontWithName:@"Helvetica" size:14];
        label31.font = [UIFont fontWithName:@"Helvetica" size:14];
        label32.font = [UIFont fontWithName:@"Helvetica" size:14];
        label33.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        label4.font = [UIFont fontWithName:@"Helvetica" size:14];
        label41.font = [UIFont fontWithName:@"Helvetica" size:14];
        label42.font = [UIFont fontWithName:@"Helvetica" size:14];
        label43.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        label12.textAlignment = NSTextAlignmentRight;
        label22.textAlignment = NSTextAlignmentRight;
        label32.textAlignment = NSTextAlignmentRight;
        label42.textAlignment = NSTextAlignmentRight;
        
        label2.textAlignment = NSTextAlignmentRight;
        label3.textAlignment = NSTextAlignmentRight;
        label4.textAlignment = NSTextAlignmentRight;
        labelbtn.textAlignment = NSTextAlignmentCenter;
        image43.image = [UIImage imageNamed:@"jt-1"];
        
        self.label12 = label12;
        self.label22 = label22;
        self.label32 = label32;
        self.label42 = label42;
        
        self.label13 = label13;
        self.label21 = label21;
        self.label23 = label23;
        self.label31 = label31;
        self.label33 = label33;
        self.label41 = label41;
        self.label43 = label43;
        self.labelbtn = btn;
        
        //test
        image.image = [UIImage imageNamed:@"img_reputation"];
        label11.text =@"飞行信用";
        label12.text =@"总额度：";////////
        label13.text =@"5000元";////////
        
        label2.text =@"累积航程：";
        label21.text =@"21次";
        label22.text =@"已用额度：";////////
        label23.text =@"2450元";////////

        label3.text =@"飞行等级：";
//        label31.text =@"VIP5 ";
        label32.text =@"可用额度：";////////
        label33.text =@"2450元";////////
        
        label4.text =@"累积里程：";
        label41.text =@"200,230公里";
        label42.text =@"需还本金手续费：";////////
        label43.text =@"2450元";////////
        
        UITapGestureRecognizer *taplabel111 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taplabel111selector)];
        [label111 addGestureRecognizer:taplabel111];
        label111.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setData:(xinyongdata *)data{
    _data = data;
    self.label13.text = data.creditLimit;
    self.label21.text = data.totalFlight;
    self.label23.text = data.usedLimit;
    self.label31.text = data.flylevel;
    
    self.label33.text = data.avalibleLimit;
    self.label41.text = data.totalMileage;
    
    NSString *contentSTR = data.needRepay;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentSTR];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,contentSTR.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:14] range:NSMakeRange(0,contentSTR.length)];
    [str addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(47, 191, 238, 1) range:NSMakeRange(0,contentSTR.length)];
    [str addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(0,contentSTR.length)];
    self.label43.attributedText = str;
    self.labelbtnLatt.text = data.loanRateDesc;
//    self.label43.text = data.needRepay;
    
        [self.viewtest removeFromSuperview];
        UIView *viewtest = [[UIView alloc]init];
//        viewtest.backgroundColor = [UIColor orangeColor];
        self.viewtest = viewtest;
        [self addSubview:viewtest];
        [viewtest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.labelbtn.mas_top).offset(0);
            make.top.equalTo(self.label43.mas_bottom).offset(0);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
        }];
    
        listTwo  *viee = [[listTwo alloc]init];
        viee.IsLastTotal = NO;
        [self.viewtest addSubview:viee];
        
        [viee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.top.equalTo(self.label41.mas_bottom).offset(20);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
        }];
        
        UIView *viewlines = [[UIView alloc]init];
        viewlines.backgroundColor = RGBACOLOR(255, 225, 164, 0.3);
        [self.viewtest addSubview:viewlines];
        [viewlines mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.top.equalTo(viee.mas_bottom).offset(10);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
    
        UIView *viewlines1 = [[UIView alloc]init];
        viewlines1.backgroundColor = RGBACOLOR(255, 225, 164, 0.3);
        [self.viewtest addSubview:viewlines1];
    
        UIScrollView *scrollView = [[UIScrollView alloc]init];
//        scrollView.backgroundColor = [UIColor redColor];
        scrollView.bounces = NO;
//     是否分页
//        scrollView.pagingEnabled = YES;
//     是否滚动
//        scrollView.scrollEnabled = YES;
//        scrollView.showsHorizontalScrollIndicator = NO;
//        scrollView.showsVerticalScrollIndicator = NO;
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
//    label.backgroundColor  =[UIColor greenColor];
//    [scrollView addSubview:label];
    

    [self.viewtest addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewlines.mas_bottom);
        make.bottom.equalTo(viewlines1.mas_top).offset(0);
//        make.height.equalTo(@120);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];

    
        NSInteger heigthvieetmp = heigthvieetmpcont;
        NSInteger spaingvieetmptoptolinesbottom = spaingvieetmptoptolinesbottomcont;
        CGFloat heispa = 0.0;
        NSInteger tmp = 0;
        for (xinyongdataOne *ddtmp in data.loanList) {
            listTwo  *vieetmp = [[listTwo alloc]init];
//            vieetmp.backgroundColor = RGBACOLOR(random()%255, 10, 10, 1);
            vieetmp.data = ddtmp;
            [scrollView addSubview:vieetmp];
            heispa= tmp*heigthvieetmp + (tmp+1)*spaingvieetmptoptolinesbottom;
            [vieetmp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@10);
                make.top.equalTo(scrollView.mas_top).offset(heispa);
                make.left.equalTo(self).offset(0);
                make.right.equalTo(self).offset(0);
            }];
            tmp++;
        }
    if (data.loanList.count) {
        scrollView.contentSize = CGSizeMake(0,heispa+20);
    }else{
        scrollView.contentSize = CGSizeMake(0,spaingvieetmptoptolinesbottom*2+heigthvieetmp);
    }

    
        listTwo  *viee1 = [[listTwo alloc]init];
        viee1.IsLastTotal = YES;
        xinyongdataOne *viee1Data = [[xinyongdataOne alloc]init];
        viee1Data.loanDate = @"合计";
        viee1Data.loanAmt = [NSNumber numberWithFloat:[self.data.totalLoanAmt doubleValue]];
        viee1Data.remainPrinc = [NSNumber numberWithFloat:[self.data.totalRemainPrinc doubleValue]];
        viee1Data.remainInt = [NSNumber numberWithFloat:[self.data.totalRemainInt doubleValue]];
        viee1.data = viee1Data;
    
        [self.viewtest addSubview:viee1];
        [viee1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.bottom.equalTo(self.labelbtn.mas_top).offset(-20);
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
        }];
        

        [viewlines1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.bottom.equalTo(viee1.mas_top).offset(-11);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
    
    if (data.loanList == nil || !data.loanList.count) {
        UILabel *labelNone = [[UILabel alloc]init];
        labelNone.text = @"没有记录";
        [scrollView addSubview:labelNone];
        labelNone.textColor = RGBACOLOR(255, 255, 255, 1);
        labelNone.font = [UIFont fontWithName:@"Helvetica" size:12];
        labelNone.textAlignment = NSTextAlignmentCenter;
        [labelNone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewlines.mas_bottom);
            make.bottom.equalTo(viewlines1.mas_top).offset(0);
            make.left.equalTo(viewlines1).offset(0);
            make.right.equalTo(viewlines1).offset(0);
        }];
    }
    self.viewtest.hidden = YES;

}
- (void)btnClickBill{
    if ([self.data.needRepay integerValue]) {
        if ([self.delegate respondsToSelector:@selector(btnClickLJHK)]) {
            [self.delegate btnClickLJHK];
        }
    }else{
        [MBProgressHUD showError:@"您没有欠款"];
    }
}
#define animateTimes  0.0
- (void)setOpenOrClose:(BOOL)openOrClose{
    _openOrClose = openOrClose;
    if (openOrClose) {
        [UIView animateWithDuration:animateTimes animations:^{
            self.viewtest.hidden = NO;
            self.image43.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else {
        [UIView animateWithDuration:animateTimes animations:^{
            self.viewtest.hidden = YES;
            self.image43.transform = CGAffineTransformIdentity;
        }];
    }
}
- (void)taplabel111selector{
    baseWeb *vc = [[baseWeb alloc]init];
    vc.title = @"服务协议";
    vc.isRefeth = NO;
    vc.url = self.data.loanAgreement;
    [NaVc pushViewController:vc animated:YES];
}
@end
