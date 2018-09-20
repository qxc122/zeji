//
//  NSDictionary+toData.m
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "NSDictionary+toData.h"

@implementation NSDictionary (toData)
+(NSData *)returnDataWithDictionary:(NSDictionary*)dict

{
    
    NSMutableData *data = [[NSMutableData alloc]init];
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:dict forKey:@"talkData"];
    
    [archiver finishEncoding];
    
    return data;
    
}

//NSData 转字典:

// NSData转dictonary

+(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data

{
    
    //  NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return myDictionary;
    
}

-(NSString*)ToUrl{
    if (self) {
        NSString *url = @"?";
        for (NSString *tmp in self.allKeys) {
            if (self[tmp]) {
                url = [url stringByAppendingString:tmp];
                url = [url stringByAppendingString:@"="];
                if ([self[tmp] isKindOfClass:[NSNumber class]]) {
                    url = [url stringByAppendingString:[self[tmp] string]];
                } else if ([self[tmp] isKindOfClass:[NSString class]]){
                    url = [url stringByAppendingString:self[tmp]];
                }
                if (![tmp isEqual:self.allKeys.lastObject]) {
                    url = [url stringByAppendingString:@"&"];
                }
            }
        }
        return url;
    } else {
        return @"";
    }
    return nil;
}
@end
