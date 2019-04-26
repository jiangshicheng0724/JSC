//
//  YYMAllProductView.h
//  YingYunStore
//
//  Created by zuosen on 2019/3/14.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "YYMAddNewBillView.h"
@class YYMNewAddBillModel;

NS_ASSUME_NONNULL_BEGIN

@interface YYMAddNewBillView : UITableViewCell

-(void)setUpWith:(YYMNewAddBillModel *)model;

@end

NS_ASSUME_NONNULL_END
