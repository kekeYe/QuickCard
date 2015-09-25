//
//  Person.h
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,assign) int pid;

@property(nonatomic,copy) NSString *pname;

@property(nonatomic,copy) NSString *phonenumber;

@property(nonatomic,copy) NSString *pmail;

@property(nonatomic,copy) NSString *password;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)PersonWithDict:(NSDictionary *)dict;


@end
