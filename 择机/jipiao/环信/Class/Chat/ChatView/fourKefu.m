//
//  fourKefu.m
//  jipiao
//
//  Created by Store on 16/8/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "fourKefu.h"
#import "fourkefuBbuleview.h"
#import "orderInfo.h"

@interface fourKefu ()
@property (nonatomic,weak) fourkefuBbuleview *bbuview;
@end

@implementation fourKefu
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
 
}
#pragma mark - setter

- (void)setModel:(id<IMessageModel>)model
{
    [super setModel:model];
//    NSDictionary *dddic = model.message.ext;
//    NSDictionary *dattta = [dddic objectForKey:@"orderInfo"];
//    orderInfo *data = [MTLJSONAdapter modelOfClass:[orderInfo class] fromJSONDictionary:dattta error:nil];
    
    for (UIView *tmp in self.subviews) {
        if (tmp.tag == 11) {
            [tmp removeFromSuperview];
        }
    }
    
    fourkefuBbuleview *bbuview = [[fourkefuBbuleview alloc]init];
    self.bbuview = bbuview;
    self.bbuview.tag = 11;
    bbuview.backgroundColor = RGBColor(202, 235, 245);
    [self.contentView addSubview:self.bbuview];
    self.bbuview.layer.cornerRadius = cornerRadiusCHAT;
    self.bbuview.layer.masksToBounds = YES;
    [self.bbuview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bubbleView);
        //            make.right.equalTo(self.bubbleView);
        make.width.equalTo(@(280*WIDTHICON));
        make.top.equalTo(self.bubbleView);
        make.bottom.equalTo(self.bubbleView);
    }];
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bbuviewbtnClickkkk)];
//    [self.bbuview addGestureRecognizer:tap1];
//    psgInfoData *datddd = [[psgInfoData alloc]init];
//    datddd.psgName = @"全1";
//    datddd.psgCertNo = @"430422199103152113";
//    psgInfoData *datddd1 = [[psgInfoData alloc]init];
//    datddd1.psgName = @"全超超";
//    datddd1.psgCertNo = @"430422199103152114";
//    data.psgInfo = [NSMutableArray arrayWithObjects:datddd,datddd1, nil];
    
//    bbuview.userInteractionEnabled = YES;
    self.bbuview.dataa = model.message.ext;
}

//- (void)bbuviewbtnClickkkk{
////    NSLog(@"btnClickkkk 去支付订单");
//    if ([self.delegateTwo respondsToSelector:@selector(bbuviewbtnClickkkkdelegate)]) {
//        [self.delegateTwo bbuviewbtnClickkkkdelegate];
//    }
//}
@end
