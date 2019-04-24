//
//  MVVMViewModel.h
//  JSCTool
//
//  Created by zuosen on 2019/4/24.
//  Copyright © 2019 jsc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MVVMModel;

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : NSObject

@property (nonatomic , copy)NSString *name;

@property (nonatomic , copy)NSString *text;

@property (nonatomic , assign)CGFloat heigh_name;

@property (nonatomic , assign)CGFloat heigh_text;

- (instancetype)initWithModel:(MVVMModel *)model;

+ (void)bindModelWithModel;

@end

NS_ASSUME_NONNULL_END
