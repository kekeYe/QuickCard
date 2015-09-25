//
//  Goods.h
//  igo
//
//  Created by Destiny on 15/9/21.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
@property(nonatomic,assign)int g_id;
@property(nonatomic,copy)NSString *g_name;
@property(nonatomic,copy)NSString *g_describe;
@property(nonatomic,assign)int g_price;
@property(nonatomic,copy)NSString *g_img;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)GoodsWithDictionary:(NSDictionary *)dict;
@end
