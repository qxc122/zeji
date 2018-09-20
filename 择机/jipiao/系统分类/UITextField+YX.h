//
//  UITextField+YX.h
//  jipiao
//
//  Created by Store on 16/11/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (YX)
@property (weak, nonatomic) id<YXTextFieldDelegate> delegate;
@end
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const YXTextFieldDidDeleteBackwardNotification;

