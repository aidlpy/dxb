//
//  BalanceViewController.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BalanceViewController.h"
#import "WithDrawViewController.h"
#import "TextFieldCell.h"
#import "RigjtContentCell.h"
#import "WithDrawRecordViewController.h"
#import "CustomerServiceViewController.h"


@interface BalanceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
    UITableView *_tableView;
    NSString *_amountBalance;
    NSString *_freezeBalance;
    UILabel *_balanceLab;

}
@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _dataArray =@[@[@{@"title":@"可提现金额",@"required":@"0",@"palceHolder":@"",@"arrowState":@"0"},
                     @{@"title":@"提现记录",@"required":@"0",@"palceHolder":@"",@"editable":@"0",@"arrowState":@"1"}],
                     @[@{@"title":@"联系客服",@"required":@"0",@"palceHolder":@"",@"editable":@"0",@"arrowState":@"1"}]];
    _amountBalance = @"0.00";
    _freezeBalance = @"0.00";
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"账户余额" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width,SIZE.height-h(self.navView)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self fetchTableViewHeader];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
    
}

-(void)fetchData{
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [httpsManager getServerAPI:FechUserMoneyBalance deliveryDic:dic successful:^(id responseObject) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        if ([[responseDic objectForKey:@"code"] integerValue] ==200) {
            NSDictionary *dataDic = [responseDic objectForKey:@"data"];
            NSDictionary *resultDic = [dataDic objectForKey:@"result"];
            _amountBalance = [resultDic objectForKey:@"amount"];
            _freezeBalance = [resultDic objectForKey:@"freeze"];
            
            _balanceLab.text = _freezeBalance;
            
            [_tableView reloadData];

        }
    } fail:^(id error) {
        
    }];
}


-(UIView *)fetchTableViewHeader{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,150)];
    view.backgroundColor = Color_5ECAF7;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 50,SIZE.width-11, 15)];
    label.text = @"待入账金额";
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    _balanceLab = [[UILabel alloc] initWithFrame:CGRectMake(x(label),bottom(label)+20,SIZE.width-50,35)];
    _balanceLab.text = _freezeBalance;
    _balanceLab.font = [UIFont systemFontOfSize:35.0f];
    _balanceLab.textColor = [UIColor whiteColor];
    [view addSubview:_balanceLab];
    
    return view;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *sectionArray = _dataArray[section];
    return sectionArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArray = _dataArray[indexPath.section];
    NSDictionary *dic = sectionArray[indexPath.row];
    
    if (indexPath.section == 0) {
        
        static NSString *rightContentCellID = @"rightContentCellID";
        RigjtContentCell *cell = [tableView dequeueReusableCellWithIdentifier:rightContentCellID];
        if (cell == nil) {
            cell = [[RigjtContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightContentCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:dic];
        if (indexPath.row == 0) {
            cell.rightLab.text = _amountBalance;
        }
        else{
            cell.rightLab.text = @"";
            
        }
        return cell;
        
        
    }
    else
    {
        static NSString *withDrawCellID = @"withDrawCellID";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:withDrawCellID];
        if (cell == nil) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withDrawCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:dic];
        return cell;
        
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 ) {
        switch (indexPath.row) {
            case 0:
            {
                WithDrawViewController *vc = [[WithDrawViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.totallyMoney = _amountBalance;
                [self.navigationController pushViewController:vc animated:YES];
           
                
            }
                break;
            case 1:
            {
                WithDrawRecordViewController *vc = [WithDrawRecordViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }
                break;
                
            default:
                break;
        }
    }
    else{
        if (FetchToken != nil) {
            [[EMClient sharedClient] loginWithUsername:FetchEMUsername password:FetchEMPassword];
        }
        CacheChatReceiverAdvatar(CustomServiceAdvatar);
        CustomerServiceViewController *vc = [[CustomerServiceViewController  alloc] initWithConversationChatter:EMCUSTOMERNUMBERT conversationType:EMConversationTypeChat];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
