//
//  Goods.h
//  iGou
//
//  Created by administrator on 9/22/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
@property(nonatomic,assign)int gid;
@property(nonatomic,copy)NSString *gname;
@property(nonatomic,assign)double price;
@property(nonatomic,copy)NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
