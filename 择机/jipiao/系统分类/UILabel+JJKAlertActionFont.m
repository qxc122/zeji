//
//  UILabel+JJKAlertActionFont.m
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UILabel+JJKAlertActionFont.h"

@implementation UILabel (JJKAlertActionFont)
- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}
@end
