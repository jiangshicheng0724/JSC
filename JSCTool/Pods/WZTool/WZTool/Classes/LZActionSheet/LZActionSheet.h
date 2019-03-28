//
//  LZActionSheet.h
//  LZActionSheetDemo
//
//  Created by LeoZ on 16/3/16.
//  Copyright © 2016年 LeoZ. All rights reserved.
//


#import <UIKit/UIKit.h>
@class LZActionSheet;
@protocol LZActionSheetDelegate <NSObject>
@optional
- (void)LZActionSheet:(LZActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index;

@end


@interface LZActionSheet : UIView
@property (nonatomic, strong) id<LZActionSheetDelegate> delegate;

- (instancetype)initWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles;

+ (instancetype)showActionSheetWithDelegate:(id)delegate cancelButtonTitle:(NSString *)cancleTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)show;
@end


@interface UIView (LZActionSheet)
@property (assign, nonatomic) CGFloat av_x;
@property (assign, nonatomic) CGFloat av_y;
@property (assign, nonatomic) CGFloat av_w;
@property (assign, nonatomic) CGFloat av_h;
@property (assign, nonatomic) CGFloat av_centerX;
@property (assign, nonatomic) CGFloat av_centerY;
@property (assign, nonatomic) CGSize  av_size;
@property (assign, nonatomic) CGPoint av_origin;
@end



@interface UIColor (LZActionSheet)
+ (instancetype)randomColor;
+ (instancetype)colorWithHex:(NSUInteger)hexColor;

@end
