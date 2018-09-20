//
//  userInfo.m
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"displayName" : @"displayName",
             @"authenTicket" : @"authenTicket",
             @"authenUserId" : @"authenUserId",
             @"loginTime" : @"loginTime",
             @"avatar" : @"avatar",
             @"easemobId" : @"easemobId",
             @"phone" : @"phone",
             };
}
//
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    if(self = [super init]){
//        self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
//        self.authenTicket = [aDecoder decodeObjectForKey:@"authenTicket"];
//        self.authenUserId = [aDecoder decodeObjectForKey:@"authenUserId"];
//        self.loginTime = [aDecoder decodeObjectForKey:@"loginTime"];
//        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
//        self.easemobId = [aDecoder decodeObjectForKey:@"easemobId"];
//        
//    }
//    return self;
//}
////归档时调用此方法
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:self.displayName forKey:@"displayName"];
//    [aCoder encodeObject:self.authenTicket forKey:@"authenTicket"];
//    [aCoder encodeObject:self.authenUserId forKey:@"authenUserId"];
//    [aCoder encodeObject:self.loginTime forKey:@"loginTime"];
//    [aCoder encodeObject:self.avatar forKey:@"avatar"];
//    [aCoder encodeObject:self.easemobId forKey:@"easemobId"];
//}
@end
