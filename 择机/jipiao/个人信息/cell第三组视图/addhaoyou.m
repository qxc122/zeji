//
//  addhaoyou.m
//  jipiao
//
//  Created by Store on 16/8/19.
//  Copyright © 2016年 admin. All rights reserved.
//


#import "addhaoyou.h"
#import "HeaderTotal.h"
#import "myinfo.h"
#import "MHLoadContactController.h"

@interface addhaoyou ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *textField1;
@property (nonatomic,weak) UITextField *textField2;
@property (nonatomic,weak) UITextField *textField3;
//@property (nonatomic,weak) UITextField *textField4;
@property (nonatomic,weak) UITextField *textField5;
@property (nonatomic,weak) UILabel *label3;
@property (nonatomic,weak) UILabel *label5;
@property (nonatomic,weak) UIImageView *imagEbtn3;
@property (nonatomic,weak) UIButton *btn3;
@property (nonatomic,weak) UIView *view5;
@property (nonatomic,weak) UIView *view3;
@property (nonatomic,weak) UIView *view;
@end

#define witthall  70

@implementation addhaoyou
#define addhaoyouIdentifier @"addhaoyouIdentifier"
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    addhaoyou *cell = [tableView dequeueReusableCellWithIdentifier:addhaoyouIdentifier];
    if (cell == nil) {
        cell = [[addhaoyou alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addhaoyouIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeself)
                                                     name:NOTIFINAME_ADDFRIENDSSUCCES
                                                   object:nil];
        
        self.backgroundColor = RGBColor(3, 13, 29);
        UIView *view = [[UIView alloc]init];
        self.view = view;
        [self.contentView addSubview:view];
        view.backgroundColor = RGBColor(14, 24, 39);
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = RGBColor(224, 224, 224).CGColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(20);
            make.bottom.equalTo(self).offset(-20);
        }];
        UIView *view1 = [[UIView alloc]init];
        [view addSubview:view1];
        UIView *view2 = [[UIView alloc]init];
        [view addSubview:view2];
        UIView *view3 = [[UIView alloc]init];
        self.view3 = view3;
        [view addSubview:view3];
//        UIView *view4 = [[UIView alloc]init];
////        self.view4 = view4;
//        [view addSubview:view4];
        UIView *view5 = [[UIView alloc]init];
        self.view5 = view5;
        [view addSubview:view5];
        view1.backgroundColor  =RGBColor(224, 224, 224);
        view2.backgroundColor  =RGBColor(224, 224, 224);
        view3.backgroundColor  =RGBColor(224, 224, 224);
//        view4.backgroundColor  =RGBColor(224, 224, 224);
        view5.backgroundColor  =RGBColor(224, 224, 224);
        
        UILabel *label1 = [[UILabel alloc]init];
        [view addSubview:label1];
        UILabel *label2 = [[UILabel alloc]init];
        [view addSubview:label2];
        UILabel *label3 = [[UILabel alloc]init];
        [view addSubview:label3];
        
//        UILabel *label4 = [[UILabel alloc]init];
//        [view addSubview:label4];
        UILabel *label44 = [[UILabel alloc]init];
        [view addSubview:label44];
//
        UILabel *label5 = [[UILabel alloc]init];
        self.label5 = label5;
        [view addSubview:label5];
        UITextField *textField1 = [[UITextField alloc]init];
        [view addSubview:textField1];
        UITextField *textField2 = [[UITextField alloc]init];
        [view addSubview:textField2];
        UITextField *textField3 = [[UITextField alloc]init];
        [view addSubview:textField3];
//        UITextField *textField4 = [[UITextField alloc]init];
//        [view addSubview:textField4];
        UITextField *textField5 = [[UITextField alloc]init];
        self.textField5 = textField5;
        [view addSubview:textField5];
        UIButton *btn1 = [[UIButton alloc]init];
        [view addSubview:btn1];
        
        UIImageView *imagEbtn12 = [[UIImageView alloc]init];
        [view addSubview:imagEbtn12];
//        UIImageView *imagEbtn2 = [[UIImageView alloc]init];
//        [view addSubview:imagEbtn2];
        UIImageView *imagEbtn3 = [[UIImageView alloc]init];
        self.imagEbtn3 = imagEbtn3;
        [view addSubview:imagEbtn3];
        
        UIButton *btn12 = [[UIButton alloc]init];
        [view addSubview:btn12];
//        UIButton *btn2 = [[UIButton alloc]init];
//        [view addSubview:btn2];
        UIButton *btn3 = [[UIButton alloc]init];
        self.btn3 = btn3;
        [view addSubview:btn3];
        
        
        UIButton *btnL = [[UIButton alloc]init];
        [view addSubview:btnL];
        UIButton *btnR = [[UIButton alloc]init];
        [view addSubview:btnR];
        
        
        self.textField1 = textField1;
        self.textField2 = textField2;
        self.textField3 = textField3;
//        self.textField4 = textField4;
        self.textField5 = textField5;
        self.label3 = label3;
//        self.label4 = label4;
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view1).offset(0);
            make.width.equalTo(@(witthall));
            make.right.equalTo(textField1.mas_left).offset(-10);
            make.bottom.equalTo(view1.mas_top).offset(-15);
            make.height.equalTo(@11);
        }];
        [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(10);
            make.right.equalTo(view1);
            //make.top.equalTo(label1);
            //make.bottom.equalTo(label1);
            make.centerY.equalTo(label1);
            make.height.equalTo(@35);
        }];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view1.mas_right).offset(10);
            make.centerY.equalTo(view1);
            make.width.equalTo(@21);
            make.height.equalTo(@21);
        }];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.right.equalTo(view).offset(-47);
            make.top.equalTo(view).offset(42);
            make.height.equalTo(@1);
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view2).offset(0);
            make.width.equalTo(@(witthall));
            make.right.equalTo(textField2.mas_left).offset(-10);
            make.bottom.equalTo(view2.mas_top).offset(-15);
            make.height.equalTo(@11);
        }];
        [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label2.mas_right).offset(10);
            make.right.equalTo(view2);
            make.centerY.equalTo(label2);
            make.height.equalTo(@35);
            //make.top.equalTo(label2);
            //make.bottom.equalTo(label2);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.right.equalTo(view).offset(-16);
            make.top.equalTo(view1.mas_bottom).offset(42);
            make.height.equalTo(@1);
        }];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view3).offset(0);
            make.width.equalTo(@(witthall));
            make.right.equalTo(textField3.mas_left).offset(-10);
            make.bottom.equalTo(view3.mas_top).offset(-15);
            make.height.equalTo(@11);
        }];
        [textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label3.mas_right).offset(10);
            make.right.equalTo(view3);
            make.centerY.equalTo(label3);
            make.height.equalTo(@35);
            //make.top.equalTo(label3);
            //make.bottom.equalTo(label3);
        }];
        [imagEbtn12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(textField3).offset(0);
            make.right.equalTo(view3);
            make.width.equalTo(@8);
            make.height.equalTo(@15);
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.right.equalTo(view).offset(-16);
            make.top.equalTo(view2.mas_bottom).offset(42);
            make.height.equalTo(@1);
        }];
//        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view4).offset(0);
//            //            make.width.equalTo(@(witthall));
//            make.right.equalTo(label44.mas_left).offset(0);
//            make.bottom.equalTo(view4.mas_top).offset(-15);
//            make.height.equalTo(@11);
//        }];
        [label44 mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.width.equalTo(@(witthall));
            //            make.right.equalTo(textField4.mas_left).offset(0);
            make.bottom.equalTo(view3.mas_top).offset(-15);
            make.height.equalTo(@10);
        }];
//        [textField4 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(textField3).offset(0);
//            make.right.equalTo(imagEbtn12.mas_left).offset(0);
//            make.top.equalTo(label4);
//            make.bottom.equalTo(label4);
//        }];
//        [imagEbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(textField4).offset(0);
//            make.right.equalTo(view4);
//            make.width.equalTo(@8);
//            make.height.equalTo(@15);
//        }];
//        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view3).offset(0);
//            make.right.equalTo(view3).offset(0);
//            make.bottom.equalTo(view3).offset(0);
//            make.top.equalTo(view3.mas_bottom).offset(0);
//            
////            make.height.equalTo(@1);
//        }];
//        view4.hidden = YES;
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view5).offset(0);
            make.width.equalTo(@(witthall));
            make.right.equalTo(textField5.mas_left).offset(-10);
            make.bottom.equalTo(view5.mas_top).offset(-15);
            make.height.equalTo(@11);
        }];
        [textField5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label5.mas_right).offset(10);
            make.right.equalTo(imagEbtn3.mas_left);
            make.centerY.equalTo(label5);
            make.height.equalTo(@35);
            //make.top.equalTo(label5);
            //make.bottom.equalTo(label5);
        }];
        [imagEbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(textField5).offset(0);
            make.right.equalTo(view5);
            make.width.equalTo(@8);
            make.height.equalTo(@15);
        }];
        [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(16);
            make.right.equalTo(view).offset(-16);
            make.top.equalTo(view3.mas_bottom).offset(42);
            make.height.equalTo(@1);
        }];
        [btnL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view5).offset(0);
            make.top.equalTo(view5).offset(5);
            make.bottom.equalTo(view).offset(-5);
            make.width.equalTo(btnL.mas_height);
//            make.height.equalTo(@31);
        }];
        [btnR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view5).offset(0);
            make.bottom.equalTo(btnL).offset(0);
            make.width.equalTo(btnL);
            make.height.equalTo(btnL);
        }];
        [btn12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imagEbtn12);
            make.centerY.equalTo(imagEbtn12);
            make.width.equalTo(@60);
            make.height.equalTo(@44);
        }];
//        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(imagEbtn2);
////            make.right.equalTo(imagEbtn2);
////            make.left.equalTo(textField4);
//            make.centerY.equalTo(imagEbtn2);
//            make.width.equalTo(@400);
//            make.height.equalTo(@44);
//        }];
        [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imagEbtn3);
            make.centerY.equalTo(imagEbtn3);
            make.width.equalTo(@400);
            make.height.equalTo(@44);
        }];
        //        btnL.backgroundColor = [UIColor redColor];
        //        btnR.backgroundColor = [UIColor redColor];
        label1.text = @"姓名";
        label2.text = @"手机号";
        label3.text = @"身份证";
//        label4.text = @"乘客类型";
        //        label44.text = @"(12岁以上)";
        label5.text = @"出生日期";
        label1.font = [UIFont systemFontOfSize:11];
        label2.font = [UIFont systemFontOfSize:11];
        label3.font = [UIFont systemFontOfSize:11];
//        label4.font = [UIFont systemFontOfSize:11];
        label44.font = [UIFont systemFontOfSize:9];
        label5.font = [UIFont systemFontOfSize:11];
        label1.textColor = RGBColor(255, 255, 255);
        label2.textColor = RGBColor(255, 255, 255);
        label3.textColor = RGBColor(255, 255, 255);
//        label4.textColor = RGBColor(255, 255, 255);
        label44.textColor = RGBColor(255, 255, 255);
        label5.textColor = RGBColor(255, 255, 255);
        textField1.placeholder = @"选择或输入姓名";
        textField2.placeholder = @"选择或输入手机号";
        textField3.placeholder = @"请输入证件号码";
        textField3.delegate = self;
//        textField4.placeholder = @"选择类别";
        textField5.placeholder = @"选择出生日期";
        textField1.font = [UIFont systemFontOfSize:10];
        textField2.font = [UIFont systemFontOfSize:10];
        textField3.font = [UIFont systemFontOfSize:10];
//        textField4.font = [UIFont systemFontOfSize:10];
        textField5.font = [UIFont systemFontOfSize:10];
        [textField1 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
        [textField2 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
        [textField3 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
//        [textField4 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
        [textField5 setValue:RGBColor(107, 107, 107) forKeyPath:@"_placeholderLabel.textColor"];
        textField1.textColor = RGBColor(255, 255, 255);
        textField2.textColor = RGBColor(255, 255, 255);
        textField3.textColor = RGBColor(255, 255, 255);
//        textField4.textColor = RGBColor(255, 255, 255);
        textField5.textColor = RGBColor(255, 255, 255);
        //        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField2.keyboardType = UIKeyboardTypeNumberPad;
        //        textField3.keyboardType = UIKeyboardTypeNumberPad;
        //        textField4.keyboardType = UIKeyboardTypeNumberPad;
        //        textField5.keyboardType = UIKeyboardTypeNumberPad;
        btn1.tag = 1;
        btn12.tag = 12;
//        btn2.tag = 2;
        btn3.tag = 3;
        btnL.tag = 4;
        btnR.tag = 5;
        [btn1 addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        [btn12 addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        [btnL addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        [btnR addTarget:self action:@selector(btnhaoyou:) forControlEvents:UIControlEventTouchUpInside];
        //test
//        textField4.userInteractionEnabled = NO;
        imagEbtn12.image = [UIImage imageNamed:@"icon_modify"];
//        imagEbtn2.image = [UIImage imageNamed:@"icon_modify"];
        imagEbtn3.image = [UIImage imageNamed:@"icon_modify"];
        [btn1 setImage:[UIImage imageNamed:@"icon_mail list"] forState:UIControlStateNormal];
//        [btn12 setImage:[UIImage imageNamed:@"icon_modify"] forState:UIControlStateNormal];
//        [btn2 setImage:[UIImage imageNamed:@"icon_modify"] forState:UIControlStateNormal];
//        [btn3 setImage:[UIImage imageNamed:@"icon_modify"] forState:UIControlStateNormal];
        [btnL setImage:[UIImage imageNamed:@"icon_close_01"] forState:UIControlStateNormal];
        [btnR setImage:[UIImage imageNamed:@"icon_complete"] forState:UIControlStateNormal];
    }
    return self;
}
- (void)closeself{
    if ([self.delegate respondsToSelector:@selector(CloseAddFriends)]) {
        self.textField1.text = @"";
        self.textField2.text = @"";
        self.textField3.text = @"";
        self.textField5.text = @"";
        self.label3.text = @"身份证";
        [self.delegate CloseAddFriends];
    }
}
- (void)btnhaoyou:(UIButton *)btn{
    if (btn.tag == 4) { //关闭
        [self closeself];
    }else if (btn.tag == 5){    //添加
        if ([self.delegate respondsToSelector:@selector(goToAddFriendsWithname:tel:certType:certNo:birthday:)]) {
            if (self.textField1.isFirstResponder) {
                [self.textField1 resignFirstResponder];
            } else if (self.textField2.isFirstResponder){
                [self.textField2 resignFirstResponder];
            } else if (self.textField3.isFirstResponder){
                [self.textField3 resignFirstResponder];
            } else if (self.textField5.isFirstResponder){
                [self.textField5 resignFirstResponder];
            }
            [self.delegate goToAddFriendsWithname:self.textField1.text tel:self.textField2.text certType:self.label3.text certNo:self.textField3.text birthday:self.textField5.text];
        }
    }else if(btn.tag == 1){  //去通讯录
        MHLoadContactController *vc = [[MHLoadContactController alloc]init];
        vc.NotificationName = NOTIFINAME_ADDFRIENDS;
        [NaVc pushViewController:vc animated:YES];
    }else if(btn.tag == 3){ //生日
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 130)];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:0];//设置最大时间为：当前时间推后十年
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-100];//设置最小时间为：当前时间前推十年
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        [datePicker setMaximumDate:maxDate];
        [datePicker setMinimumDate:minDate];

        datePicker.datePickerMode = UIDatePickerModeDate;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert.view addSubview:datePicker];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            //实例化一个NSDateFormatter对象
            [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
            NSString *dateString = [dateFormat stringFromDate:datePicker.date];
            //求出当天的时间字符串
            self.textField5.text = dateString;
            NSLog(@"%@",dateString);
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [NaVc presentViewController:alert animated:YES completion:^{ }];
    }else if (btn.tag == 2 || btn.tag == 12){
        NSString *str = nil;
        NSArray *str2 = nil;
        if (btn.tag == 2) {
            str = @"选择乘客类型";
            str2 = @[@"成人(>=12周岁)",@"儿童(2^12周岁)",@"婴儿(14天^周岁)"];
        } else {
            str = @"选择证件类型";
            str2 = @[@"身份证",@"护照",@"其它"];
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        for (NSString *strt in str2) {
            [alert addAction:[UIAlertAction actionWithTitle:strt style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                if (btn.tag == 2) {
//                    self.textField4.text = strt;
                } else {
                    if (![self.label3.text isEqualToString:strt]) {
                        BOOL tmp = YES;
                        if ([strt isEqualToString:@"身份证"]) {
                            tmp = YES;
                        } else {
                            tmp = NO;
                        }
                        if ([self.delegate respondsToSelector:@selector(Selectthetypeofdocument:)]) {
                            [self.delegate Selectthetypeofdocument:tmp];
                        }
                    }
//                    if ([self.label3.text isEqualToString:str2[0]]) {
//                        self.IsIDcard = YES;
//                    } else {
//                        self.IsIDcard = NO;
//                    }
//                    [self showORhiden];
                    self.label3.text = strt;
                }
            }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [NaVc presentViewController:alert animated:true completion:nil];
    }
}
- (void)showORhiden{
    if (!self.IsIDcard) {
        [self showThreecell];
    } else {
        [self hidendThreecell];
    }
}
- (void)showThreecell{
    self.label5.hidden = NO;
    self.textField5.hidden = NO;
    self.imagEbtn3.hidden = NO;
    self.btn3.hidden = NO;
    [self.view5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view3.mas_bottom).offset(42);
        make.height.equalTo(@1);
    }];
}
- (void)hidendThreecell{
    self.label5.hidden = YES;
    self.textField5.hidden = YES;
    self.imagEbtn3.hidden = YES;
    self.btn3.hidden = YES;
    [self.view5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view3).offset(0);
        make.right.equalTo(self.view3).offset(0);
        make.top.equalTo(self.view3).offset(0);
        make.height.equalTo(@[self.view3]);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField) {
        if ([self.label3.text isEqualToString:@"身份证"]) {
            if (textField.text.length == 18) {
                NSString *tmpt = [textField.text  substringWithRange:NSMakeRange(6, 8)];
                NSString *tmp1 = [tmpt substringWithRange:NSMakeRange(0, 4)];
                NSString *tmp2 = [tmpt substringWithRange:NSMakeRange(4, 2)];
                NSString *tmp3 = [tmpt substringWithRange:NSMakeRange(6, 2)];
                self.textField5.text = [NSString stringWithFormat:@"%@-%@-%@",tmp1,tmp2,tmp3];
            } else if(textField.text.length == 15){
                NSString *tmpt = [textField.text  substringWithRange:NSMakeRange(7, 6)];
                NSString *tmp1 = [tmpt substringWithRange:NSMakeRange(0, 2)];
                NSString *tmp2 = [tmpt substringWithRange:NSMakeRange(2, 2)];
                NSString *tmp3 = [tmpt substringWithRange:NSMakeRange(4, 2)];
                self.textField5.text = [NSString stringWithFormat:@"19%@-%@-%@",tmp1,tmp2,tmp3];
            }
            
//            NSString* timeStr = self.textField5.text;
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateStyle:NSDateFormatterMediumStyle];
//            [formatter setTimeStyle:NSDateFormatterShortStyle];
//            [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
            
            //设置时区,这个对于时间的处理有时很重要
            //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
            //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
            //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
            
//            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//            [formatter setTimeZone:timeZone];
//            
//            NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
//            NSInteger day = [date day];
////            NSInteger month = [date month];
//            NSInteger year = [date year];
//            
//            
//            NSDate* date2 = [NSDate date];
//            NSInteger dayNow = [date2 day];
////            NSInteger monthNow = [date2 month];
//            NSInteger yearNow = [date2 year];
//            if ((yearNow - year) >= 12) {
//                self.textField4.text = @"成人(>=12周岁)";
//            } else if((yearNow - year) >= 2){
//                self.textField4.text = @"儿童(2^12周岁)";
//            }else if ((dayNow - day) >= 14){
//                self.textField4.text = @"婴儿(14天^周岁)";
//            }
        }
    }
}
- (void)setIsIDcard:(BOOL)IsIDcard{
    _IsIDcard = IsIDcard;
    [self showORhiden];
}
- (void)setPhoneTel:(NSString *)phoneTel{
    _phoneTel = phoneTel;
    self.textField2.text = phoneTel;
}
- (void)setPhoneName:(NSString *)phoneName{
    _phoneName = phoneName;
    self.textField1.text = phoneName;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
