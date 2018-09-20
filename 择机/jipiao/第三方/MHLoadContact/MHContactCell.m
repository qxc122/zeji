//
//  KTDDContactCell.m
//  读取通讯录
//
//  Created by LMH on 16/2/23.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import "MHContactCell.h"
#import "DefineUI.h"

@implementation MHContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _height.constant = 0.5;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.numLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    //self.backgroundColor = [UIColor redColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
