//
//  CustomMessageCellOne.m
//  jipiao
//
//  Created by Store on 16/8/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CustomMessageCellOne.h"
#import "HeaderTotal.h"

@implementation CustomMessageCellOne
-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarCornerRadius = WIDTHICONCHAT/2.0;
    self.avatarSize = WIDTHICONCHAT;
    self.messageNameHeight = SPAINGHICONCHAT;
    self.messageNameIsHidden = YES;
    self.bubbleMaxWidth = screenWidth - 30*WIDTHICON - 2*WIDTHICONCHAT;
}
- (void)setModel:(id<IMessageModel>)model{
    [super setModel:model];
//    label.attributedText = [GlobalObject attributedStringWithText:@"msgCo[(-T)]ntent"];
//    IMessageModel>)model  model.text
    
    self.bubbleView.textLabel.attributedText = [GlobalObject attributedStringWithText:model.text];;
}
@end
