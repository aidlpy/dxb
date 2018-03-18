//
//  MyServiceTypeTwoCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 22/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyServiceTypeTwoCell.h"

@implementation MyServiceTypeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(11.5f,20, SIZE.width-23.0f,225.0f)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [_baseView.layer setCornerRadius:2.0f];
        [_baseView.layer setBorderColor:Color_F1F1F1.CGColor];
        [_baseView.layer setBorderWidth:1.0f];
        [self addSubview:_baseView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5f,15.0f,w(_baseView)-25.0f, 16.0f)];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = Color_1F1F1F;
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = @"情绪压力,电话咨询,摆脱焦虑";
        [_baseView addSubview:_titleLabel];
        
        _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel),bottom(_titleLabel)+14.0f, w(_titleLabel), 14.0f)];
        _tagLabel.text = @"咨询标签: 亲子问题";
        _tagLabel.textColor = Color_4C4C4C;
        _tagLabel.font = FONT_13;
        [_baseView addSubview:_tagLabel];
        
        _commuicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel), bottom(_tagLabel)+14.0f, w(_titleLabel), 14.0f)];
        _commuicateLabel.text = @"咨询方式: 电话";
        _commuicateLabel.textColor = Color_4C4C4C;
        _commuicateLabel.font = FONT_13;
        [_baseView addSubview:_commuicateLabel];
                
        _serviceTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel), bottom(_commuicateLabel)+14.0f, w(_titleLabel), 14.0f)];
        _serviceTimeLabel.text = @"咨询时长: 3次";
        _serviceTimeLabel.textColor = Color_4C4C4C;
        _serviceTimeLabel.font = FONT_13;
        [_baseView addSubview:_serviceTimeLabel];
        
        _commuicateTimesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel), bottom(_serviceTimeLabel)+14.0f, w(_titleLabel), 14.0f)];
        _commuicateTimesCountLabel.text = @"咨询时长: 3次";
        _commuicateTimesCountLabel.textColor = Color_4C4C4C;
        _commuicateTimesCountLabel.font = FONT_13;
        [_baseView addSubview:_commuicateTimesCountLabel];
        
        _serviceSinglePriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel), bottom(_commuicateTimesCountLabel)+14.0f, w(_titleLabel), 14.0f)];
        _serviceSinglePriceLabel.text = @"单次价格: 100.00元";
        _serviceSinglePriceLabel.textColor = Color_4C4C4C;
        _serviceSinglePriceLabel.font = FONT_13;
        [_baseView addSubview:_serviceSinglePriceLabel];
        
        _serviceDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel), bottom(_serviceSinglePriceLabel)+14.0f, w(_titleLabel), 34.0f)];
        _serviceDetailLabel.text = @"咨询信息: 家庭原因";
        _serviceDetailLabel.textColor = Color_4C4C4C;
        _serviceDetailLabel.font = FONT_13;
        _serviceDetailLabel.numberOfLines = 2;
        [_baseView addSubview:_serviceDetailLabel];
        
        _serviceCreateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x(_titleLabel),h(_baseView)-20, w(_titleLabel), 14.0f)];
        _serviceCreateTimeLabel.text = @"2018-01-01 18:30:00";
        _serviceCreateTimeLabel.textColor = Color_BABABA;
        _serviceCreateTimeLabel.font = FONT_12;
        [_baseView addSubview:_serviceCreateTimeLabel];
        
        
        
    }
    return  self;
    
}

-(void)updateUI:(PackageModel *)model{
    
    _titleLabel.text = model.packageTitle;
    _tagLabel.text = [NSString stringWithFormat:@"咨询标签: %@",model.packageServiceTags];
    _commuicateLabel.text = [NSString stringWithFormat:@"咨询方式: %@",model.packageConsultationWay];
    _commuicateTimesCountLabel.text = [NSString stringWithFormat:@"咨询次数: %@",model.packageServiceTimes];
    _serviceTimeLabel.text = [NSString stringWithFormat:@"咨询时长: %@",model.packageServiceHours];
    _serviceSinglePriceLabel.text = [NSString stringWithFormat:@"单次价格: %@",model.packageServiceSinglePrice];
    _serviceDetailLabel.text = [NSString stringWithFormat:@"咨询信息: %@",model.packageServiceContent];
     _serviceCreateTimeLabel.text = [NSString stringWithFormat:@"%@",model.packageServiceCreateTime];
    
    CGSize size = [_serviceDetailLabel boundingRectWithSize:CGSizeMake(w(_serviceDetailLabel), 0)];
    [_serviceDetailLabel setMj_h:size.height];
    
    if (size.height-16.0f > 0 ) {
        [_baseView setMj_h:214.0f + size.height];
        model.cellHeight = h(_baseView)+23.0f;
    }
    else
    {
        [_baseView setMj_h:225.5f];
         model.cellHeight = h(_baseView)+23.0f;
    }
    
    _serviceCreateTimeLabel.frame = CGRectMake(x(_titleLabel),h(_baseView)-20, w(_titleLabel), 14.0f);
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
