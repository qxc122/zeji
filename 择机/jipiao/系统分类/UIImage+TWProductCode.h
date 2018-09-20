//
//  UIImage+TWProductCode.h
//  wallet
//
//  Created by linqb on 16/4/14.
//  Copyright © 2016年 xingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TWProductCode)

/**
 *  生成条形码
 */
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

+ (UIImage *)qrImageByContent:(NSString *)content;

//pre
+ (UIImage *)qrImageWithContent:(NSString *)content size:(CGFloat)size;
/**
 *   色值 0~255
 *
 */
+ (UIImage *)qrImageWithContent:(NSString *)content size:(CGFloat)size red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;



+ (UIImage *)qrImageWithContent:(NSString *)content logo:(UIImage *)logo size:(CGFloat)size red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

+ (UIImage *)returnImage:(NSString *)str With:(CGFloat)width;
@end
