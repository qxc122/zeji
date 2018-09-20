//
//  AppDelegate.h
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MainViewController.h"
//#import "ApplyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, EMChatManagerDelegate>
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;
@end

