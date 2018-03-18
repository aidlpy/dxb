//
//  ConsultingSubOrderModel.h
//  37duxinB
//
//  Created by Zhang Xinrong on 14/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BaseOrderModel.h"

@interface ConsultingSubOrderModel : BaseOrderModel
@property(nonatomic,copy)NSString *orderUID;
@property(nonatomic,copy)NSString *orderOID;
@property(nonatomic,copy)NSString *orderConsultationStatus;
@property(nonatomic,copy)NSString *orderCSID;
@property(nonatomic,copy)NSString *orderCustomerDesc;
@property(nonatomic,assign)BOOL isReservation;
@property(nonatomic,assign)BOOL isInitiative;
@property(nonatomic,copy)NSString *orderOldPrice;
@property(nonatomic,copy)NSString *reservationOrderId;
@property(nonatomic,copy)NSString *orderSubStatus;
@property(nonatomic,copy)NSString *orderType;
@property(nonatomic,copy)NSString *orderReservationID;

@property(nonatomic,copy)NSArray *packageTags;
@property(nonatomic,copy)NSArray *packageConsultationWay;

@property(nonatomic,copy)NSString *orderInfoZXName;
@property(nonatomic,copy)NSString *orderInfoZXGender;
@property(nonatomic,copy)NSString *orderInfoZXAge;
@property(nonatomic,copy)NSString *orderInfoZXProvince;
@property(nonatomic,copy)NSString *orderInfoZXCity;
@property(nonatomic,copy)NSString *orderInfoZXArea;

+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ConsultingSubOrderModel *model))fetchModelBlock;
@end
