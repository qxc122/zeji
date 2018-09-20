//
//  toMishu.m
//  jipiao
//
//  Created by Store on 16/8/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "toMishu.h"
#import "resemishu.h"
#import "HeaderTotal.h"

@interface toMishu ()
@property (nonatomic,weak) resemishu *bbuview;
@end

@implementation toMishu
-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarCornerRadius = WIDTHICONCHAT/2.0;
    self.avatarSize = WIDTHICONCHAT;
    //    self.leftBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    //    self.rightBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    self.messageNameHeight = SPAINGHICONCHAT;
    self.messageNameIsHidden = YES;
    self.bubbleMaxWidth = screenWidth - 30 - WIDTHICONCHAT*2;
    self.bubbleView.hidden = YES;
    
    if (!self.bbuview ) {
        resemishu *bbuview = [[resemishu alloc]init];
        self.bbuview = bbuview;
        [self.contentView addSubview:self.bbuview];
        self.bbuview.layer.cornerRadius = cornerRadiusCHAT;
        self.bbuview.layer.masksToBounds = YES;
    }
    
}
#pragma mark - setter
- (void)setModel:(id<IMessageModel>)model
{
    [super setModel:model];
    if (model.isSender) {
        self.bbuview.backgroundColor = RGBColor(223, 224, 225);
        [self.bbuview mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.bubbleView);
            make.right.equalTo(self.bubbleView);
            make.width.equalTo(@(275*WIDTHICON));
            make.top.equalTo(self.bubbleView);
            make.bottom.equalTo(self.bubbleView);
        }];
    } else {
        self.bbuview.backgroundColor = RGBColor(204, 238, 247);
        [self.bbuview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bubbleView);
//            make.right.equalTo(self.bubbleView);
            make.width.equalTo(@(275*WIDTHICON));
            make.top.equalTo(self.bubbleView);
            make.bottom.equalTo(self.bubbleView);
        }];
    }
    [self bringSubviewToFront:self.bbuview];
}
@end
