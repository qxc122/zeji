//
//  nullcell.m
//  jipiao
//
//  Created by Store on 16/8/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "nullcell.h"

@implementation nullcell
#define nullcellIdentifier @"nullcellIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    nullcell *cell = [tableView dequeueReusableCellWithIdentifier:nullcellIdentifier];
    if (cell == nil) {
        cell = [[nullcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nullcellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
