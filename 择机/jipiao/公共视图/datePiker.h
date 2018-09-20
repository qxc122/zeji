//
//  datePiker.h
//  TourismT
//
//  Created by Store on 2017/1/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface datePiker : UIView
- (void)windosViewshow;
- (void)closeClisck;
@property (nonatomic, strong) NSDate* minDate;
@property (nonatomic, strong) NSDate* maxDate;
@property (nonatomic, copy) void (^nextClick)(NSString *startDate);
@end
