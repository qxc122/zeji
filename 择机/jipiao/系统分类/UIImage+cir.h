//
//  UIImage+cir.h
//  TourismT
//
//  Created by Store on 2017/2/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cir)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
