//
//  logoAndRegist.h
//  jipiao
//
//  Created by Store on 16/8/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol logoAndRegistDelegate <NSObject>
- (void)logoAndRegistWillClose;
- (void)clickWeixinLogin;
@end

@interface logoAndRegist : UIView
@property (nonatomic,weak) id<logoAndRegistDelegate>delagate;
- (void)becomeFirst;
- (void)registFirst;

@end
