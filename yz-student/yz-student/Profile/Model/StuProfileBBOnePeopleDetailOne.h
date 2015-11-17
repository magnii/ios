//
//  StuProfileBBMemberInfoOne.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StuProfileBBOnePeopleDetailOneOne.h"

@interface StuProfileBBOnePeopleDetailOne : NSObject

@property(nonatomic, copy)NSString *memberId;
@property(nonatomic, strong)StuProfileBBOnePeopleDetailOneOne *oneOne;
@property(nonatomic, copy)NSString *relationId;
@property(nonatomic, copy)NSString *dateId;

@end
