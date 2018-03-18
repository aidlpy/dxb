//
//  ConsultingOrderModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseOrderModel.h"

@interface ConsultingOrderModel : BaseOrderModel

@property(nonatomic,copy)NSString *orderUID;
@property(nonatomic,copy)NSString *orderCID;
@property(nonatomic,copy)NSString *orderConsultationStatus;
@property(nonatomic,copy)NSString *orderCSID;
@property(nonatomic,copy)NSString *orderCustomerDesc;
@property(nonatomic,assign)BOOL isReservation;
@property(nonatomic,assign)BOOL isInitiative;
@property(nonatomic,copy)NSString *orderOldPrice;
//@property(nonatomic,copy)NSString *reservationOrderId;
@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,copy)NSString *orderType;

@property(nonatomic,copy)NSArray *packageTags;
@property(nonatomic,copy)NSArray *packageConsultationWay;

@property(nonatomic,copy)NSString *orderInfoZXName;
@property(nonatomic,copy)NSString *orderInfoZXGender;
@property(nonatomic,copy)NSString *orderInfoZXAge;
@property(nonatomic,copy)NSString *orderInfoZXProvince;
@property(nonatomic,copy)NSString *orderInfoZXCity;
@property(nonatomic,copy)NSString *orderInfoZXArea;

+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ConsultingOrderModel *model))fetchModelBlock;

@end
