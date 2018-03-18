//
//  SelectTwiceCell.h
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectedTypeBlock)(NSString *tag);
@interface SelectTwiceCell : UITableViewCell
@property(nonatomic,copy)NSMutableArray *selectedArray;
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UIButton *leftBtn;
@property(nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,copy)selectedTypeBlock selectedTypeBlock;
-(void)updateUI:(NSDictionary *)dic;
-(void)setSelectedData:(NSString *)string;
@end
