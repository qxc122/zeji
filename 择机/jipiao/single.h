//
//  single.h
//  wallet
//
//  Created by admin on 16/7/7.
//  Copyright © 2016年 xingxing. All rights reserved.
//

#ifndef single_h
#define single_h

#define singleton_h(name) + (instancetype)shared##name;

#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#define NJInitH(name) \
- (instancetype)initWithDict:(NSDictionary *)dict; \
+ (instancetype)name##WithDict:(NSDictionary *)dict;

#define NJInitM(name)\
- (instancetype)initWithDict:(NSDictionary *)dict \
{ \
if (self = [super init]) { \
[self setValuesForKeysWithDictionary:dict]; \
} \
return self; \
} \
+ (instancetype)name##WithDict:(NSDictionary *)dict \
{ \
return [[self alloc] initWithDict:dict]; \
}

#endif /* single_h */
