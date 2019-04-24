//
//  MVVMTableViewCell.h
//  JSCTool
//
//  Created by zuosen on 2019/4/24.
//  Copyright © 2019 jsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMTableViewCell : UITableViewCell

- (void)setUpWithViewModel:(MVVMViewModel *)model;

@end

NS_ASSUME_NONNULL_END
