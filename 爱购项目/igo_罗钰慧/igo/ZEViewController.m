//
//  ZEViewController.m
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "ZEViewController.h"
#import "loginViewController.h"

@interface ZEViewController ()

@property (weak, nonatomic) IBOutlet UITextField *sureLab;

@property (weak, nonatomic) IBOutlet UITextField *passWold;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

- (IBAction)sureBtn:(id)sender;


@end

@implementation ZEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 *  跳转回登陆界面
 *
 *  @param sender =
 */
- (IBAction)sureBtn:(id)sender {
  
    NSString *str1 = self.passWold.text;
    NSString *str2 = self.sureLab.text;
    NSString *str3 = self.phoneNumber.text;
    
    //判断注册的信息是否符合条件：两次密码需要相等，并且不为空，账号不能为空
    if ( [str1 isEqualToString:str2] && ![str1 isEqualToString:@""] && ![str3 isEqualToString:@""]) {
        
       
        UIStoryboard *storyboard = self.storyboard;
        
        loginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"UserID"];
        
        loginVC.passWold = self.passWold.text ;
        loginVC.gname = self.phoneNumber.text ;
        
        [self.navigationController pushViewController:loginVC animated:YES];
           


    }
    else  {
        
        //提示框
        [self showMessage:@"请填写完整正确信息"];
        
    }
    
}

/**
 *  自定义提示框
 *
 *  @param info 
 */
- (void)showMessage:(NSString *)info{

    UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"" message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [message show];
}

















@end
