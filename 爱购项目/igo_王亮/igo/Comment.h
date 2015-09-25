//
//  Comment.h
//  igo
//
//  Created by Destiny on 15/9/25.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property(nonatomic,copy)NSString *u_name;
@property(nonatomic,copy)NSString *c_comment;
@property(nonatomic,copy)NSString *u_image;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)CommentWithDictionary:(NSDictionary *)dict;
@end
