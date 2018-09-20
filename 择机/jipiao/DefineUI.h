//
//  DefineUI.h
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#ifndef DefineUI_h
#define DefineUI_h

#define UIColorFromRGB(rgbValue) [UIColor                       \
colorWithRed:(float)(((rgbValue & 0xFF0000) >> 16) / 255.0) \
green:(float)(((rgbValue & 0xFF00) >> 8) / 255.0)    \
blue:(float)((rgbValue & 0xFF) / 255.0)             \
alpha:1.0]

#define UIColorFromRGBA(rgbaValue) [UIColor                        \
colorWithRed:(float)(((rgbaValue & 0xFF000000) >> 16) / 255.0) \
green:(float)(((rgbaValue & 0xFF0000) >> 8) / 255.0)    \
blue:(float)((rgbaValue & 0xFF00) / 255.0)             \
alpha:(float)((rgbaValue & 0xFF) / 255.0)]

#define UIColorFromRGBAlpha(rgb, a) [UIColor            \
colorWithRed:(float)(((rgb >> 16) & 0xFF) / 255.0f) \
green:(((rgb >> 8) & 0xFF) / 255.0f)         \
blue:(((rgb)&0xFF) / 255.0f)                \
alpha:a]

//未读消息数
//#define WidthBadgeLabel   18
//#define HeightBadgeLabel   18
//#define fontBadgeLabel   8


#define   IQdefaultHeight  10.0  //默认高度

//查询左侧页面的
#define  Colorlines RGBColor(59,69,83)   //分割线的颜色
#define  ColorBigBack ColorWithHex(0x2B3B54, 1.0)   //大背景颜色
//#define  ColorBigBack RGBColor(25,35,52)   //大背景颜色

// clang-format off

#define UIColorFromRGB(rgbValue) [UIColor                       \
    colorWithRed:(float)(((rgbValue & 0xFF0000) >> 16) / 255.0) \
           green:(float)(((rgbValue & 0xFF00) >> 8) / 255.0)    \
            blue:(float)((rgbValue & 0xFF) / 255.0)             \
           alpha:1.0]

#define UIColorFromRGBA(rgbaValue) [UIColor                        \
    colorWithRed:(float)(((rgbaValue & 0xFF000000) >> 16) / 255.0) \
           green:(float)(((rgbaValue & 0xFF0000) >> 8) / 255.0)    \
            blue:(float)((rgbaValue & 0xFF00) / 255.0)             \
           alpha:(float)((rgbaValue & 0xFF) / 255.0)]

#define UIColorFromRGBAlpha(rgb, a) [UIColor            \
    colorWithRed:(float)(((rgb >> 16) & 0xFF) / 255.0f) \
           green:(((rgb >> 8) & 0xFF) / 255.0f)         \
            blue:(((rgb)&0xFF) / 255.0f)                \
           alpha:a]
#define RGBColor(R,G,B)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define onePX (1 / [[UIScreen mainScreen] scale])

// clang-format on

//--------------------------------UI------------------------------------------
#define kWindowW [UIScreen mainScreen].bounds.size.width
#define kWindowH [UIScreen mainScreen].bounds.size.height

#define IPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define IPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define IPhone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define IPhone6Plus ([UIScreen mainScreen].bounds.size.height == 736)


#define kMargin_Iphone5_Height 88.0f
#define kMargin_Iphone6_Height 187.0f    //键盘弹出时 要减去相应的屏幕尺寸
#define kMargin_Iphone6P_Height 256.0f

//-----------------------------------文字颜色--------------------------------------------
#define KWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kBgColor [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1]
#define kColorText [UIColor colorWithRed:71/255. green:73/255. blue:74/255. alpha:1]
#define kColorWhite [UIColor whiteColor]
#define kColorBlack [UIColor blackColor]
#define kColorTempus [UIColor colorWithRed:0.5333 green:0.2706 blue:0.5490 alpha:1]
#define kColorRandom KWColor(random()%255, random()%255, random()%255)
///随机颜色
#define RandomColor Color(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1)


#define cornerRadius_width  4.0f

#define ColorWithHex(rgbValue,a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]


#define LRViewBorder(View, Width, Color)\
\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];\

#define LRViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\


#define FONTNAME @"PingFangSC-Regular"
#define FONTNAMEMedium @"PingFangSC-Medium"


#define PingFangSC_Regular(F) [UIFont systemFontOfSize:F]
#define PingFangSC_Medium(F) [UIFont boldSystemFontOfSize:F]


//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

#define placeholderLabeltextColor ColorWithHex(0x000000, 0.3)


#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#endif /* DefineUI_h */
