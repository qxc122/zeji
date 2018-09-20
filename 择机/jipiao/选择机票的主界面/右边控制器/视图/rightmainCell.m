//
//  rightmainCell.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "rightmainCell.h"

@interface rightmainCell ()
@property (nonatomic,weak) UILabel *labeltitle;
@property (nonatomic,weak) UILabel *labelonetwo;
@property (nonatomic,weak) UILabel *labeltime;
@end

@implementation rightmainCell
#define rightmainCellifier @"rightmainCellifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    rightmainCell *cell = [tableView dequeueReusableCellWithIdentifier:rightmainCellifier];
    if (cell == nil) {
        cell = [[rightmainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightmainCellifier];
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
        //
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_spot_01"]];
        [self.contentView addSubview:image];
        
        UILabel *labeltitle = [[UILabel alloc]init];
        [self.contentView addSubview:labeltitle];
        
        UILabel *labelonetwo = [[UILabel alloc]init];
        labelonetwo.layer.cornerRadius = 3.0;
        labelonetwo.layer.masksToBounds = YES;
        labelonetwo.backgroundColor = RGBColor(247, 55, 70);
        [self.contentView addSubview:labelonetwo];
        
        UILabel *labeltime = [[UILabel alloc]init];
        [self.contentView addSubview:labeltime];

        UIView *view1 = [[UIView alloc]init];
        [self.contentView addSubview:view1];
        view1.backgroundColor = Colorlines;
        
        self.labeltitle = labeltitle;
        self.labelonetwo = labelonetwo;
        self.labeltime = labeltime;
        self.labeltitle.font = [UIFont systemFontOfSize:14];
        self.labelonetwo.font = [UIFont systemFontOfSize:11];
        self.labeltime.font = [UIFont systemFontOfSize:11];
        self.labeltitle.textColor = [UIColor whiteColor];
        self.labelonetwo.textColor = [UIColor whiteColor];
        self.labeltime.textColor = [UIColor whiteColor];

        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.width.equalTo(@5);
            make.height.equalTo(@5);
            make.centerY.equalTo(labeltitle);
        }];
        [labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(10);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@(14));
        }];
        [labelonetwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labeltitle);
            make.width.equalTo(@28);
            make.right.equalTo(labeltime.mas_left).offset(-5);
            make.top.equalTo(labeltitle.mas_bottom).offset(5);
//            make.bottom.equalTo(self).offset(-5*HEIGHTICON);
        }];
        [labeltime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labeltitle.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-5);
//            make.centerY.equalTo(labelonetwo);
        }];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
        self.labelonetwo.textAlignment = NSTextAlignmentCenter;
        labeltime.numberOfLines = 0;
//        self.labeltitle.text = @"北京-上海";
//        self.labelonetwo.text = @"单程";
//        self.labeltime.text = @"2016-12-12 10:45";
    }
    return self;
}
- (void)setData:(rithtFlirhtdataone *)data{
    _data = data;
    
    self.labeltitle.text = [data.depCityName stringByAppendingString:[@"-" stringByAppendingString:data.arrCityName]];
    
    if (data.backDate && data.backDate.length) {
        self.labelonetwo.text = @"往返";
        self.labeltime.text = [NSString stringWithFormat:@"%@/%@",data.depDate,data.backDate];
        self.labelonetwo.backgroundColor = RGBColor(0, 195, 235);
    } else {
        self.labelonetwo.text = @"单程";
        self.labeltime.text = data.depDate;
        self.labelonetwo.backgroundColor = RGBColor(247, 55, 70);
    }
}
@end
