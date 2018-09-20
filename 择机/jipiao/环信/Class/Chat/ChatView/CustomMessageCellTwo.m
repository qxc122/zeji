//
//  CustomMessageCellTwo.m
//  jipiao
//
//  Created by Store on 16/8/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CustomMessageCellTwo.h"
#import "HeaderTotal.h"

@implementation CustomMessageCellTwo
-(void)layoutSubviews{
    [super layoutSubviews];
    self.avatarCornerRadius = WIDTHICONCHAT/2.0;
    self.avatarSize = WIDTHICONCHAT;
//    self.leftBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.rightBubbleMargin = UIEdgeInsetsMake(0, 0, 0, 0);
    self.messageNameHeight = SPAINGHICONCHAT;
    self.messageNameIsHidden = YES;
    self.bubbleMaxWidth = screenWidth - 30*WIDTHICON - 2*WIDTHICONCHAT;
}
@end
