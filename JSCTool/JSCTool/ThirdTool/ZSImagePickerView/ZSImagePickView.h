//
//  ZSImagePickView.h
//  RACText
//
//  Created by 班文政 on 2018/12/8.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSImagePickView : UIView

/**  是否允许拍照 */
@property (nonatomic , assign) BOOL  isTakePhoto;
/**  是否允许拍视频 */
@property (nonatomic , assign) BOOL  isTakeVideo;
/**  是否允许选择视频 */
@property (nonatomic , assign) BOOL  isPickingVideo;
/**  是否允许选择图片 */
@property (nonatomic , assign) BOOL  isPickingImage;
/**  是否允许选择gif */
@property (nonatomic , assign) BOOL  isPickingGif;
/**  是否允许选择原图 */
@property (nonatomic , assign) BOOL  isPickingOriginalPhoto;
/**  是否单选模式允许裁剪 */
@property (nonatomic , assign) BOOL  isCrop;
/**  是否单选模式圆形裁剪 */
@property (nonatomic , assign) BOOL  isCircleCrop;
/**  显示一个sheet,把拍照/拍视频按钮放在外面 */
@property (nonatomic , assign) BOOL  isshowSheet;
/**  右上角显示图片选中序号 */
@property (nonatomic , assign) BOOL  isShowSelectedIndex;
/**  照片最大可选张数，设置为1即为单选模式 */
@property (nonatomic , assign) NSInteger  maxCount;
/**  每行显示多少个 */
@property (nonatomic , assign) NSInteger  columnNumber;
/**  允许多选视频/GIF/图片 */
@property (nonatomic , assign) BOOL  isPickingMuitlpleVideo;

@property (nonatomic , copy) void (^imagePickViewBackBlock)(NSArray *selectedPhotos ,NSArray *selectedAssets,CGFloat ImagePickViewMinHeight);

@end

NS_ASSUME_NONNULL_END
