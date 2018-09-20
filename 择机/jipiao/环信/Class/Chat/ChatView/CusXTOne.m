//
//  CusXTOne.m
//  jipiao
//
//  Created by Store on 16/8/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CusXTOne.h"
#import "HeaderTotal.h"

#define WIDTHvieww    26

@interface CusXTOne ()
@property (nonatomic,weak) UILabel *label1;
@end

@implementation CusXTOne
#define CusXTOneIdentifier @"CusXTOneIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    CusXTOne *cell = [tableView dequeueReusableCellWithIdentifier:CusXTOneIdentifier];
    if (cell == nil) {
        cell = [[CusXTOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CusXTOneIdentifier];
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

        UILabel *label1 =[[UILabel alloc]init];
        self.label1 = label1;
        [vieww addSubview:label1];
        
        [vieww mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(55);
            make.right.equalTo(self).offset(-55);
            make.height.equalTo(@(WIDTHvieww));
            make.centerY.equalTo(self);
        }];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vieww);
            make.right.equalTo(vieww);
            make.top.equalTo(vieww);
            make.bottom.equalTo(vieww);
        }];
        vieww.backgroundColor = RGBColor(140, 146, 155);
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = RGBColor(24, 35, 52);
        label1.textAlignment = NSTextAlignmentCenter;
        vieww.layer.cornerRadius = WIDTHvieww/2.0;
        vieww.layer.masksToBounds = YES;
        //test
        label1.text = @"你的私人秘书已经接通";
    }
    return self;
}
@end
