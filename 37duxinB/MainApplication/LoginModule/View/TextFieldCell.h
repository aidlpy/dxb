//
//  TextFieldCell.h
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^textFieldBlock)(UITextField *textField);
@interface TextFieldCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UITextField *textFild;
@property(nonatomic,retain)UIImageView *rightArrow;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)textFieldBlock textFieldBlock;

-(void)updateUI:(NSDictionary *)dic;
@end
