//
//  Goods.m
//  iGou
//
//  Created by administrator on 9/22/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict
{
    return [[super alloc]initWithDict:dict];
}

@end
