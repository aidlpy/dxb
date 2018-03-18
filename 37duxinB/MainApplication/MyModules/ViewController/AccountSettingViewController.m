//
//  AccountSettingViewController.m
//  37duxinB
//
//  Created by 37duxin on 06/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "AccountSafeViewController.h"
#import "ForgotPsViewController.h"
#import "MyCell.h"

@interface AccountSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataResource;
    
}
@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{

    _dataResource = @[@{@"title":@"账户绑定"},@{@"title":@"修改密码"}];
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"个人资料" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height -h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataResource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSDictionary *dic =_dataResource[indexPath.row];
    static NSString *myInfoId = @"myInfoId";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfoId];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInfoId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.textLabel.font = FONT_15;
    cell.textLabel.textColor = Color_2A2A2A;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        
        //账户绑定;
        
        AccountSafeViewController *vc = [AccountSafeViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        //修改密码;
        ForgotPsViewController *vc = [ForgotPsViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)backTo{
    
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
