//
//  tableFoot.h
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tableFootDelegate <NSObject>
- (void)clickLogout;
@end


@interface tableFoot : UIView
@property (nonatomic,weak)id<tableFootDelegate>delegate;
@end
