//
//  Person.m
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self==[super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}


+ (instancetype)PersonWithDict:(NSDictionary *)dict{

    return [[super alloc]initWithDict:dict];
}
@end
