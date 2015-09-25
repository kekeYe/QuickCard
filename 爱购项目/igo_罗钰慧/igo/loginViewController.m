//
//  loginViewController.m
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "loginViewController.h"
#import "LoginTableViewController.h"
#import "ZEViewController.h"

@interface loginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passWord;

- (IBAction)loginBtn:(id)sender;

- (IBAction)addUser:(id)sender;



@end

@implementation loginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
 //将注册界面传回来的值复制到界面显示控件中
    
    if ((self.gname!=nil) || (self.passWold!=nil)) {
        self.userName.text = self.gname;
        self.passWord.text = self.passWold;
    }
}



/**
 *  跳转到登录界面
 *
 *  @param sender
 */
- (IBAction)loginBtn:(id)sender {
   
    if ([self.userName.text isEqualToString:@"admin"]&&[self.passWord.text isEqualToString:@"123456"]) {
        
        UIStoryboard *storyboard = self.storyboard;
        LoginTableViewController *myVC = [storyboard instantiateViewControllerWithIdentifier:@"loginID"];
        
        //界面传值 传到 一开始登录界面
        myVC.gname = self.userName.text;
        
        [self.navigationController pushViewController:myVC animated:YES];
       
        
    }
}

/**
 * 跳转到注册界面
 *
 *  @param sender
 */
- (IBAction)addUser:(id)sender {
    
    UIStoryboard *storyboard = self.storyboard;
    ZEViewController *addVC = [storyboard instantiateViewControllerWithIdentifier:@"zhuceID"];
    
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
