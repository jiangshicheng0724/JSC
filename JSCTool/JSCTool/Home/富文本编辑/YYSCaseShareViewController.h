//
//  YYSCaseShareViewController.h
//  ZSPeopleConnectedInternet
//
//  Created by zuosen on 2018/12/7.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "YYMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class LMNDraft;
@interface YYSCaseShareViewController : YYMBaseViewController


@property (nonatomic, readonly) LMNDraft *draft;

- (instancetype)initWithDraft:(LMNDraft *)draft;

@end

NS_ASSUME_NONNULL_END
