//
//  Goods.m
//  igo
//
//  Created by administrator on 15/9/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "Goods.h"

@implementation Goods
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self==[super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

+(instancetype)goodsWithDict:(NSDictionary *)dict{

    return [[super alloc]initWithDict:dict];
}
@end
