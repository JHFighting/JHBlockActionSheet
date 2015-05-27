//
//  JHBlockActionSheet+ImagePicker.h
//  ActionSheetBlock
//
//  Created by e1858 on 15/5/27.
//  Copyright (c) 2015年 e1858. All rights reserved.
//

#import "JHBlockActionSheet.h"

typedef void(^JHPhotoPicker_t)(UIImage *pickImage);

@interface JHBlockActionSheet (ImagePicker)

/**
 *  图像选择
 *
 *  @param title         actionsheet 标题
 *  @param allowsEditing 图像是否可以编辑
 *  @param controller    控制器
 *  @param photoPicker   选完回调
 *
 *  @return 提示
 */
+ (instancetype)photoPickerSheetWithTitle:(NSString *)title
                            allowsEditing:(BOOL)allowsEditing
                        presentController:(UIViewController *)controller
                         pickerCompletion:(JHPhotoPicker_t)photoPicker;

@end
