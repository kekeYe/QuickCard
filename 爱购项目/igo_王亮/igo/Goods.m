//
//  Goods.m
//  igo
//
//  Created by Destiny on 15/9/21.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "Goods.h"

@implementation Goods
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)GoodsWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}
@end
