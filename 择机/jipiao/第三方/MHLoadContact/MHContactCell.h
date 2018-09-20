//
//  MHContactCell.h
//  读取通讯录
//
//  Created by LMH on 16/2/23.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *divLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@end
