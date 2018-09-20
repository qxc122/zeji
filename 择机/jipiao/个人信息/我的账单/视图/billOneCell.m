//
//  billOneCell.m
//  jipiao
//
//  Created by Store on 16/9/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "billOneCell.h"
#import "HeaderTotal.h"

#define SPAINGviewAlltopToSElf  2
#define SPAINGviewAllbottomToSElf  2
#define SPAINGviewAllleftToSElf  11
#define SPAINGviewAllrightToSElf  11

@interface billOneCell ()
@property (nonatomic,weak) UILabel *label11;
@property (nonatomic,weak) UILabel *label12;
@property (nonatomic,weak) UILabel *label13;
@property (nonatomic,weak) UILabel *label1;
@property (nonatomic,weak) UILabel *label2;
@end


@implementation billOneCell
#define billOneCellIdentifier @"billOneCellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    billOneCell *cell = [tableView dequeueReusableCellWithIdentifier:billOneCellIdentifier];
    if (cell == nil) {
        cell = [[billOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:billOneCellIdentifier];
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
        UIView *viewAll = [[UIView alloc]init];
        [self.contentView addSubview:viewAll];
        
        UIView *viewTwo = [[UIView alloc]init];
        [self.contentView addSubview:viewTwo];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        
        UILabel *label11 = [[UILabel alloc]init];
        [self.contentView addSubview:label11];
        UILabel *label12 = [[UILabel alloc]init];
        [self.contentView addSubview:label12];
        UILabel *label13 = [[UILabel alloc]init];
        [self.contentView addSubview:label13];
        
        UILabel *label1 = [[UILabel alloc]init];
        [self.contentView addSubview:label1];
        UILabel *label2 = [[UILabel alloc]init];
        [self.contentView addSubview:label2];
        
        self.label11 = label11;
        self.label12 = label12;
        self.label13 = label13;
        self.label1 = label1;
        self.label2 = label2;
        
        [viewAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(SPAINGviewAllleftToSElf);
            make.right.equalTo(self).offset(-SPAINGviewAllrightToSElf);
            make.top.equalTo(self).offset(SPAINGviewAlltopToSElf);
            make.bottom.equalTo(self).offset(-SPAINGviewAllbottomToSElf);
        }];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewAll).offset(12*WIDTHICON);
            make.width.equalTo(@17);
            make.height.equalTo(@17);
            make.top.equalTo(viewAll.mas_top).offset(19);
        }];
        
        [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(10*WIDTHICON);
            make.top.equalTo(viewAll.mas_top).offset(16);
            make.height.equalTo(@13);
            
        }];
        [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label11.mas_right).offset(10*WIDTHICON);
            make.height.equalTo(@10);
            make.centerY.equalTo(label11);
        }];
        [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label11).offset(0);
            make.height.equalTo(@9);
            make.top.equalTo(label11.mas_bottom).offset(9);
        }];
        
        [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(viewAll).offset(-1);
            make.width.equalTo(@81);
            make.top.equalTo(viewAll);
            make.bottom.equalTo(viewAll);
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(viewTwo).offset(0);
            make.height.equalTo(@10);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(viewTwo).offset(0);
            make.height.equalTo(@11);
            make.centerY.equalTo(viewTwo).offset(9);
            make.top.equalTo(label1.mas_bottom).offset(9);
        }];
        
        viewTwo.backgroundColor = RGBACOLOR(255, 255, 255, 0.1);
        viewAll.layer.borderColor = RGBACOLOR(255, 255, 255, 0.1).CGColor;
        viewAll.layer.borderWidth = 1.0;
        
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        
        label11.font = [UIFont fontWithName:@"Helvetica" size:12];
        label12.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        label13.font = [UIFont fontWithName:@"Helvetica" size:11];
        
        label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        label2.font = [UIFont fontWithName:@"Helvetica-Light" size:11];

        label11.textColor = RGBACOLOR(255, 255, 255,1);
        label12.textColor = RGBACOLOR(255, 255, 255,1);
        label13.textColor = RGBACOLOR(255, 255, 255,1);
        
        label1.textColor = RGBACOLOR(235, 63, 66,1);
        label2.textColor = RGBACOLOR(255, 255, 255,1);


        //test
        label1.text = @"飞行信用支付";
        label2.text = @"飞行信用支付";

        
        label11.text = @"南方航空";
        label12.text = @"ZH-9637";
        label13.text = @"2016-09-01";
        
        imageView.image = [UIImage imageNamed:@"icon_bill"];//qd
    }
    return self;
}
- (void)setData:(billListdataOne *)data{
    self.label11.text = data.tranTypeDesc;
    self.label13.text = data.tranDatetime;
    self.label1.text = data.tranAmt;
    self.label2.text = data.tranChannelDesc;
    self.label12.text = @"";
    //待确认  10月14号
}
@end
