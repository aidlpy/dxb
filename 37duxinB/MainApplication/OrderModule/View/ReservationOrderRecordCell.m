//
//  ReservationOrderRecordCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 12/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservationOrderRecordCell.h"

@implementation ReservationOrderRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(11,24,SIZE.width/2-11, 12.0f)];
        _userLabel.textColor = Color_2A2A2A;
        _userLabel.font = FONT_12;
        _userLabel.text = @"用户A";
        [self addSubview:_userLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,bottom(_userLabel)+8,SIZE.width,1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
        
        
        _btnAction = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-100,15, 93, 16.0f)];
        [_btnAction setTitle:@"已完成" forState:UIControlStateNormal];
        [_btnAction setTitleColor:Color_8AD72E forState:UIControlStateNormal];
        _btnAction.titleLabel.font = FONT_13;
        _btnAction.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_btnAction];
        
        _typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8,bottom(_lineView)+12.5,21.5, 21.5)];
        [_typeImageView setImage:[UIImage imageNamed:Image(@"deep")]];
        [self addSubview:_typeImageView];
        
        _packageLabel = [[UILabel alloc] initWithFrame:CGRectMake(left(_typeImageView)+6,0,200,13.0f)];
        _packageLabel.center = CGPointMake(_packageLabel.center.x, _typeImageView.center.y);
        _packageLabel.text = @"情绪压力，电话咨询，摆脱焦虑";
        _packageLabel.font =FONT_15;
        [self addSubview:_packageLabel];
        
        _arrowImageView =[[UIImageView alloc] initWithFrame:CGRectMake(left(_packageLabel)+19, 0, 8, 15)];
        _arrowImageView.center = CGPointMake(_arrowImageView.center.x, _packageLabel.center.y);
        [_arrowImageView setImage:[UIImage imageNamed:Image(@"grayRightArrow")]];
        [self addSubview:_arrowImageView];
        
        _currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-70, 60, 62, 10)];
        _currentPriceLabel.font = FONT_12;
        _currentPriceLabel.textAlignment = NSTextAlignmentRight;
        _currentPriceLabel.textColor = Color_1F1F1F;
        _currentPriceLabel.text =@"￥200.00";
        [self addSubview:_currentPriceLabel];
        
        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-70,bottom(_currentPriceLabel)+7, 62, 10)];
        _oldPriceLabel.font = FONT_12;
        _oldPriceLabel.textColor = Color_BABABA;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.text =@"￥600.00";
        [self addSubview:_oldPriceLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(35,h(_oldPriceLabel)/2, w(_oldPriceLabel)/2,1)];
        lineView.backgroundColor = Color_BABABA;
        [_oldPriceLabel addSubview:lineView];
        
        _questionDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_packageLabel),bottom(_oldPriceLabel)+42, 250, 35)];
        _questionDetailLabel.textColor = Color_5A5A5A;
        _questionDetailLabel.font = FONT_12;
        _questionDetailLabel.numberOfLines = 2;
        _questionDetailLabel.text = @"问题描述:家庭原因，用户情绪波动较大，希望能得到咨询师开导";
        [self addSubview:_questionDetailLabel];
        
        _packageTimes =[[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-70, y(_questionDetailLabel)+5,62,10)];
        _packageTimes.text = @"x3";
        _packageTimes.font = FONT_13;
        _packageTimes.textColor = Color_5A5A5A;
        _packageTimes.textAlignment = NSTextAlignmentRight;
        [self addSubview:_packageTimes];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,170, SIZE.width, 1)];
        bottomLine.backgroundColor = Color_F1F1F1;
        [self addSubview:bottomLine];
        
        _orderRecordBtn = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width-82,bottom(bottomLine)+5, 70, 27)];
        _orderRecordBtn.titleLabel.font = FONT_14;
        [_orderRecordBtn.layer setCornerRadius:2.0f];
        [_orderRecordBtn.layer setBorderColor:Color_DCDCDC.CGColor];
        [_orderRecordBtn.layer setBorderWidth:1.0f];
        [_orderRecordBtn setTitle:@"订单记录" forState:UIControlStateNormal];
        [_orderRecordBtn addTarget:self action:@selector(checkOrderHistory:) forControlEvents:UIControlEventTouchUpInside];
        [_orderRecordBtn setTitleColor:Color_1F1F1F forState:UIControlStateNormal];
        [self addSubview:_orderRecordBtn];
        
    }
    return self;
}

-(void)checkOrderHistory:(UIButton *)sender{
    
    if (_orderRecordBlock) {
        _orderRecordBlock(self.tag);
    }
}

-(void)updateUI:(ReservationOrderModel *)model
{
    _userLabel.text= model.consultantUsername;
    _packageLabel.text = model.packageTitle;
    _currentPriceLabel.text = model.orderPrice;
    _oldPriceLabel.text = model.orderOldPrice;
    _questionDetailLabel.text = model.orderCustomerDesc;
    _packageTimes.text = [NSString stringWithFormat:@"x%@",model.packageSerTimes];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end