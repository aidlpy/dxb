//
//  WithDrawRecordViewController.m
//  37duxinB
//
//  Created by 37duxin on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WithDrawRecordViewController.h"
#import "WithDrawRecordCell.h"
#import "WithdrawRecordModel.h"

@interface WithDrawRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL _isHeaderRefresh;
    NSInteger _totallyPage;
    NSInteger _currenPage;
    
}
@end

@implementation WithDrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _totallyPage = 1;
    _isHeaderRefresh = YES;
    _currenPage = 0;
    [self fetchData];
}

-(void)fetchData{
    
    if (_currenPage < _totallyPage) {
        
        HttpsManager *httpsManager = [[HttpsManager alloc] init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)_currenPage] forKey:@"page"];
        NSLog(@"%ld,%ld",(long)_currenPage,(long)_totallyPage);
        [httpsManager getServerAPI:FetchApplyRecordWithDraw deliveryDic:dic  successful:^(id responseObject) {
            if ([[responseObject objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *responseDic = (NSDictionary *)responseObject;
                NSDictionary *dataDic = [responseDic objectForKey:@"data"];
                NSDictionary *metaDic = [dataDic objectForKey:@"_meta"];
                NSArray *arrayResult = [dataDic objectForKey:@"result"];
                _totallyPage = [[metaDic objectForKey:@"pageCount"] integerValue];
                if (_isHeaderRefresh)
                {
                    [_dataArray removeAllObjects];
                }
                if (arrayResult.count ==0)
                {
                    [_tableView reloadData];
                    _isHeaderRefresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
                }
                else
                {
                    [WithdrawRecordModel fetchArray:arrayResult fetchModel:^(BOOL isStop, WithdrawRecordModel *model) {
                        [_dataArray addObject:model];
                        if (isStop) {
                            [_tableView reloadData];
                            _isHeaderRefresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
                        }
                    }];
                }
            }
            
        } fail:^(id error) {
            
        }];
        
    }
    else
    {
        [_tableView reloadData];
        _isHeaderRefresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
        
    }
    
    
    
    
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"提现" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isHeaderRefresh = YES;
        _currenPage = 0;
        [self fetchData];
    }];
    _tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        _isHeaderRefresh = NO;
        _currenPage++;
        [self fetchData];
    }];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *WithDrawRecordCellID = @"WithDrawRecordCellID";
    WithDrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:WithDrawRecordCellID];
    if (cell == nil) {
        cell = [[WithDrawRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WithDrawRecordCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.tag = indexPath.row;
    WithdrawRecordModel *model = _dataArray[indexPath.row];
    [cell updateUI:model];
    return cell;
    
    
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
