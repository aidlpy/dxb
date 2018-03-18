//
//  WithDrawViewController.m
//  37duxinB
//
//  Created by 37duxin on 11/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "WithDrawViewController.h"

@interface WithDrawViewController ()<UITextFieldDelegate>
{
    UITextField *_textField;
    
    
}
@end

@implementation WithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    
    
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"提现" rightImage:@"whiteLeftArrow"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(38,h(self.navView)+86,SIZE.width-48,15)];
    label.text = @"提现金额";
    label.font = FONT_15;
    label.textColor = Color_2A2A2A;
    [self.view addSubview:label];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,bottom(label)+44, 17.5,20)];
    priceLabel.text =@"¥";
    priceLabel.font = [UIFont systemFontOfSize:25.0f];
    [self.view addSubview:priceLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(left(priceLabel)+5, 0, SIZE.width-left(priceLabel)-10, 25)];
    _textField.center = CGPointMake(_textField.center.x, priceLabel.center.y);
    _textField.placeholder = @"请输入金额";
    _textField.font = [UIFont systemFontOfSize:25.0f];
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(35,bottom(_textField)+18,SIZE.width-70,1)];
    lineView.backgroundColor =Color_F1F1F1;
    [self.view addSubview:lineView];
    
    UILabel *detailLabl = [[UILabel alloc] initWithFrame:CGRectMake(35,bottom(lineView)+10,SIZE.width-70,12.5)];
    detailLabl.text = [NSString stringWithFormat:@"可提现金额%@元",_totallyMoney];
    detailLabl.textColor = Color_F1F1F1;
    detailLabl.font = [UIFont systemFontOfSize:12.5f];
    [self.view addSubview:detailLabl];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(detailLabl)+48,SIZE.width-70,40)];
    submitBtn.backgroundColor = Color_5ECAF7;
    [submitBtn.layer setCornerRadius:2.0f];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
}

-(void)submitAction:(UIButton *)button{
    
    if (_textField.text.length != 0) {

        if ([_textField.text integerValue] >= 100)
        {
        
            if ([_textField.text integerValue] <= [_totallyMoney integerValue]) {
                
                HttpsManager *httpsManager = [[HttpsManager alloc] init];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:_textField.text forKey:@"apply_amount"];
                [httpsManager postServerAPI:PostApplyWithDraw deliveryDic:dic successful:^(id responseObject) {
                    if ([[responseObject objectForKey:@"code"] integerValue] ==200)
                    {
                        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                        NSString *error_code = [dataDic objectForKey:@"error_code"];
                        if ([error_code integerValue] == 0) {
                            [SVHUD showSuccessWithDelay:[dataDic objectForKey:@"msg"] time:0.8f blockAction:^{
                                [self.navigationController popViewControllerAnimated:YES];
                            }];
                        }
                        else
                        {
                            [SVHUD showErrorWithDelay:[dataDic objectForKey:@"msg"] time:0.8f];
                        }
                    }
                    else
                    {
                        [SVHUD showErrorWithDelay:[[responseObject objectForKey:@"data"] objectForKey:@"msg"] time:0.8f];
                    }
                    
                } fail:^(id error) {
                    [SVHUD showErrorWithDelay:@"请求" time:0.8f];
                }];
                
            }
            else
            {
                  [SVHUD showErrorWithDelay:@"可提现金额不足!" time:0.8f];
                
            }
            
            
        }
        else
        {
          [SVHUD showErrorWithDelay:@"请输入大于100元的金额" time:0.8f];
        }
       
    }
    else
    {
        [SVHUD showErrorWithDelay:@"请输入金额" time:0.8f];
        
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
