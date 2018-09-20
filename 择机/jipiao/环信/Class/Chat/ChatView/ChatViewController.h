/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"


@interface ChatViewController : EaseMessageViewController <EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

@property (nonatomic,strong) NSDictionary *info;//发送给客服或者秘书用到
- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

@property (nonatomic, strong) NSString *EachOtherName;
@property (nonatomic, strong) NSString *HeadOfTheOtherSide;
@property (nonatomic, strong) NSString *mobie;
@property (nonatomic, strong) UIImage *headImage;
@end
