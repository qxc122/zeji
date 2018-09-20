//
//  mainController.h
//  jipiao
//
//  Created by Store on 16/7/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseVc.h"

@interface mainController : baseVc
{
    EMConnectionState _connectionState;
}

- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)setupUnreadMessageCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;
@end
