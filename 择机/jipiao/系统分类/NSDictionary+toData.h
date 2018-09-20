//
//  NSDictionary+toData.h
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (toData)
+(NSData *)returnDataWithDictionary:(NSDictionary*)dict;

//NSData 转字典:

// NSData转dictonary

+(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data;

-(NSString*)ToUrl;
@end
