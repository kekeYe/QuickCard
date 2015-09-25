//
//  LoginTableViewController.m
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "LoginTableViewController.h"

#import "loginViewController.h"
#import "Person.h"
#import "AFNetworking.h"

@interface LoginTableViewController ()

@property(nonatomic,strong) Person *person;

@property(nonatomic,strong) NSMutableArray *personArr;

@end

@implementation LoginTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例tableview的头和尾视图，目的是空白部分没有下划线
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
   

}
/**
 *  返回三行
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


/**
 *  每一行的详细数据加载及显示
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
   
    
    if (indexPath.row==0) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"0.jpg"]];
        imgView.frame = CGRectMake(10, 10, 70, 70);
        
        [cell.contentView addSubview:imgView];
       
          // 判断self.gname的值是否为空，若不为空 则将self.gname的值赋给lab
        if (self.gname==nil) {
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 50, 20)];
            lab.text = @"登录";
            [cell.contentView addSubview:lab];

        
        }
        else{
        
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 50, 20)];
            lab.text = self.gname;
            [cell.contentView addSubview:lab];
        }
     
    
    }
    
    else if (indexPath.row==1){
        
        cell.textLabel.text = @"手机号";
        
        if (self.gname!=nil) {
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 12, 150, 20)];
            lab.text = @"15555378826";
            [cell.contentView addSubview:lab];

        }
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        }
    
    else if (indexPath.row==2){
        
        self.tableView.rowHeight = 44;
        cell.textLabel.text = @"邮箱";
        
        if (self.gname!=nil) {
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, 180, 20)];
            lab.text = @"1067772845@qq.com";
            [cell.contentView addSubview:lab];
            
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
        
    }
   
    
    return cell;
}


/**
 *  对所选择的行进行操作
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 跳转到登陆界面
    if (indexPath.row==0) {
        
   
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    loginViewController *VC = [storyBoard instantiateViewControllerWithIdentifier:@"UserID"];
    [self.navigationController pushViewController:VC animated:YES];
    
   }
}

/**
 *  设置row的高
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 90;
    }else{
        return 44 ;
    }
}


@end
