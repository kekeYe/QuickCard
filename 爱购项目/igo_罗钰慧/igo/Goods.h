//
//  Goods.h
//  igo
//
//  Created by administrator on 15/9/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义实体类
@interface Goods : NSObject

@property(nonatomic,assign)int gid;

@property(nonatomic,copy)NSString *gname;

@property(nonatomic,assign)int price;

@property(nonatomic,copy)NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;
@end
