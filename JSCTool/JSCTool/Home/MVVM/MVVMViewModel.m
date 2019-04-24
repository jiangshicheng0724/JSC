//
//  MVVMViewModel.m
//  JSCTool
//
//  Created by zuosen on 2019/4/24.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "MVVMViewModel.h"
#import "MVVMModel.h"

@implementation MVVMViewModel

- (instancetype)initWithModel:(MVVMModel *)model
{
    self = [super init];
    if (self) {
        
        self.name = model.name;
        
        self.text = model.text;
        
        self.heigh_name = [NSString sizeWithText:[NSString stringWithFormat:@"%@",model.name] font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(kScreenWidth - (30), MAXFLOAT)].height + (5);
        
        self.heigh_text = [NSString sizeWithText:[NSString stringWithFormat:@"%@",model.text] font:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(kScreenWidth - (30), MAXFLOAT)].height + (5);
        
    }
    return self;
}

+ (void)bindModelWithModel{
    
}
@end
