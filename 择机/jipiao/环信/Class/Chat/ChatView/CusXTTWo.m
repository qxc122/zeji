//
//  CusXTTWo.m
//  jipiao
//
//  Created by Store on 16/8/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CusXTTWo.h"
#import "HeaderTotal.h"
#define WIDTHviewwCusXTTWo    50

@interface CusXTTWo ()
@property (nonatomic,weak) UILabel *label1;
@end


@implementation CusXTTWo
#define CusXTTWoIdentifier @"CusXTTWoIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    CusXTTWo *cell = [tableView dequeueReusableCellWithIdentifier:CusXTTWoIdentifier];
    if (cell == nil) {
        cell = [[CusXTTWo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CusXTTWoIdentifier];
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
        UIView *vieww =[[UIView alloc]init];
        [self.contentView addSubview:vieww];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [vieww addSubview:imageView];
        
        UILabel *label1 =[[UILabel alloc]init];
        self.label1 = label1;
        [vieww addSubview:label1];
        
        [vieww mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(14);
            make.right.equalTo(self).offset(-14);
            make.height.equalTo(@(WIDTHviewwCusXTTWo));
            make.centerY.equalTo(self);
        }];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vieww).offset(10);
            make.width.equalTo(@13);
            make.top.equalTo(label1);
            make.height.equalTo(@13);
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vieww).offset(26);
            make.right.equalTo(vieww).offset(-12);;
            make.top.equalTo(vieww).offset(10);;
            make.bottom.equalTo(vieww).offset(-10);;
        }];
        vieww.backgroundColor = RGBColor(235 , 78, 82);
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = RGBColor(255, 255, 255);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 0;
        vieww.layer.cornerRadius = 4.0;
        vieww.layer.masksToBounds = YES;
        
        imageView.image = [UIImage imageNamed:@"call_silence"];
        //test
        label1.text = @"你的私人秘书已经接通你的私人秘书已经接通你的私人秘书已经";
    }
    return self;
}
@end
