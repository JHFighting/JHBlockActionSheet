//
//  JHBlcokActionSheet.h
//  ActionSheetBlock
//
//  Created by JH on 15/5/26.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBlockActionSheetItem : NSObject

+ (instancetype)itemWithTitle:(NSString *)title andBlock:(dispatch_block_t)block;

- (instancetype)initItemWithTitle:(NSString *)title andBlock:(dispatch_block_t)block;

@end

@interface JHBlcokActionSheet : UIActionSheet

+ (instancetype)actionSheetWithTitle:(NSString *)title
                    cancelButtonItem:(JHBlockActionSheetItem *)cancelItem
               destructiveButtonItem:(JHBlockActionSheetItem *)destructiveItem
                    otherButtonItems:(JHBlockActionSheetItem *)otherItems,...NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initActionSheetWithTitle:(NSString *)title
                        cancelButtonItem:(JHBlockActionSheetItem *)cancelItem
                   destructiveButtonItem:(JHBlockActionSheetItem *)destructiveItem
                        otherButtonItems:(JHBlockActionSheetItem *)otherItems,...NS_REQUIRES_NIL_TERMINATION;

- (void)addButtonWithItem:(JHBlockActionSheetItem *)item;

@end




