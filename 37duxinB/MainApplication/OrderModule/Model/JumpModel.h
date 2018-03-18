//
//  JumpModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JumpModel : NSObject
@property(nonatomic,assign)BOOL isMain;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,assign)NSInteger pageNumber;
@end
