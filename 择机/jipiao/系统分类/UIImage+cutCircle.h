//
//  UIImage+cutCircle.h
//  jipiao
//
//  Created by Store on 16/8/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cutCircle)
- (UIImage *)cutCircleImage;
//ios 改变图片大小缩放方法
+(UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
