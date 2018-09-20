//
//  huankuangBtn.h
//  jipiao
//
//  Created by Store on 16/9/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol huankuangBtnDelegate <NSObject>
- (void)logoAndRegistWillClose;
- (void)huankuangWithTorWeichat:(NSInteger)num tranAmt:(NSString *)tranAmt;
@end

@interface huankuangBtn : UIView
@property (nonatomic,weak) id<huankuangBtnDelegate>delagate;
@property (nonatomic,strong) NSString *totalNum;
- (void)becomeFirst;
- (void)registFirst;

@end