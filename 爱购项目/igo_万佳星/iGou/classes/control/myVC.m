//
//  myVC.m
//  iGou
//
//  Created by administrator on 9/24/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "myVC.h"
#import "loginVC.h"
#import "AFNetworking.h"
@interface myVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation myVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
//    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    self.tableview.scrollEnabled = NO;
    [self.navigationItem setLeftBarButtonItem:nil animated:NO];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];//单例方法
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/users.php?action=select_user"];
    [mgr POST:urlPath parameters:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", self.u_id] forKey:@"u_id"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSLog(@"dict:%@",dict);
        
        int code = [[dict valueForKey:@"code"]integerValue];
        if (code == 200)
        {
            self.dataArr = [dict valueForKey:@"data"];
//
        }
        [self.tableview reloadData];
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"错误%@",error);
     }];
    
    NSLog(@"u_id--%d",self.u_id);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    if (self.u_id == 0)
    {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"header.png"];
            cell.textLabel.text = @"请登录";
            
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"手机号";
        }
        else
        {
            cell.textLabel.text = @"邮箱";
        }
        

    }
    else
    {
        [cell setSelected:NO];
        
        NSDictionary *data = [self.dataArr firstObject];
        NSLog(@"data:%@",data);
        
        if (indexPath.row == 0) {
            //                    cell.imageView setFrame:<#(CGRect)#>
            cell.imageView.image = [UIImage imageNamed:@"header.png"];
            cell.textLabel.text = [data valueForKey:@"u_name"];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"手机号:%4@",[data valueForKey:@"u_mobile"]];;
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"邮箱:%@",[data valueForKey:@"u_email"]];
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.u_id == 0)
    {
        if (indexPath.row == 0) {
            loginVC *login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else
    {
        if (indexPath.row == 0) {
            /**
             * 更换头像的操作
             */
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}



@end
