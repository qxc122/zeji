//
//  UIImage+cir.m
//  TourismT
//
//  Created by Store on 2017/2/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "UIImage+cir.h"

@implementation UIImage (cir)
//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *image = [UIImage imageNamed:name];
//        1.开启一个和原始图片一样大小的位图上下文.
        CGSize size = CGSizeMake(image.size.width + 2 *borderWidth, image.size.height + 2 * borderWidth);
        UIGraphicsBeginImageContextWithOptions(size,NO,0);
//        2.绘制一个大圆,填充
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
        [[UIColor blueColor] set];
        [path fill];
//        3.添加一个裁剪区域.
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
        [path addClip];
//        4.把图片绘制到裁剪区域当中.
        [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
//        5.生成一张新图片.
        UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
//        6.关闭上下文.
        UIGraphicsEndImageContext();
        
        return clipImage;
        

    
//    // 1.加载原图
//    UIImage *oldImage = [UIImage imageNamed:name];
//    
//    // 2.开启上下文
//    CGFloat imageW = oldImage.size.width * borderWidth;
//    CGFloat imageH = oldImage.size.height * borderWidth;
//    CGSize imageSize = CGSizeMake(imageW, imageH);
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//    
//    // 3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // 4.画边框(大圆)
//    [borderColor set];
//    CGFloat bigRadius = imageW * 0.5; // 大圆半径
//    CGFloat centerX = bigRadius; // 圆心
//    CGFloat centerY = bigRadius;
//    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
//    CGContextFillPath(ctx); // 画圆。As a side effect when you call this function, Quartz clears the current path.
//    
//    // 5.小圆
//    CGFloat smallRadius = bigRadius - borderWidth;
//    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
//    // 裁剪(后面画的东西才会受裁剪的影响)
//    CGContextClip(ctx);
//    
//    // 6.画图
//    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
//    
//    // 7.取图
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 8.结束上下文
//    UIGraphicsEndImageContext();
//    
//    return newImage;
}
@end
