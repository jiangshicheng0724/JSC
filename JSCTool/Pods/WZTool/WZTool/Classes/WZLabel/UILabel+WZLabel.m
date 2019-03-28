//
//  UILabel+WZLabel.m
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/12.
//

#import "UILabel+WZLabel.h"

@implementation UILabel (WZLabel)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = textColor;
    label.backgroundColor = backGroundColor;
    label.font = font;
    label.text = text;
    [superView addSubview:label];
    label.numberOfLines = 1;
    return label;
}

@end
