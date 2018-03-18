//
//  CityModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 01/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(instancetype)init
{
    
    self = [super init];
    if (self) {
        self.cityArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
