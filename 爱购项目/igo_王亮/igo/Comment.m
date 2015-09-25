//
//  Comment.m
//  igo
//
//  Created by Destiny on 15/9/25.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "Comment.h"

@implementation Comment
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)CommentWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}
@end
