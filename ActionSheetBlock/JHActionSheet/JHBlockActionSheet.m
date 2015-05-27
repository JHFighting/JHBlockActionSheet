//
//  JHActionSheet.m
//  ActionSheetBlock
//
//  Created by JH on 15/5/26.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHBlockActionSheet.h"

@interface JHBlockActionSheetItem ()

/**
 *  标题
 */
@property (nonatomic, copy  ) NSString         *title;
/**
 *  相应事件
 */
@property (nonatomic, copy) dispatch_block_t   block;
/**
 *  次序标示
 */
@property (nonatomic, assign) NSInteger        itemIndex;

@end

@implementation JHBlockActionSheetItem

+ (instancetype)itemWithTitle:(NSString *)title andBlock:(dispatch_block_t)block
{
    JHBlockActionSheetItem *item = [[JHBlockActionSheetItem alloc] initItemWithTitle:title andBlock:block];
    return item;
}

- (instancetype)initItemWithTitle:(NSString *)title andBlock:(dispatch_block_t)block
{
    self = [super init];
    if (self) {
        self.title = title;
        self.block = block;
    }
    return self;
}

@end

@interface JHBlockActionSheet ()  <UIActionSheetDelegate>

{
    /**
     *  存储其他item
     */
    NSMutableArray          *_otherButtonItems;
    JHBlockActionSheetItem  *_cancelItem;
    JHBlockActionSheetItem  *_destructiveItem;
}

@end

@implementation JHBlockActionSheet

+ (instancetype)actionSheetWithTitle:(NSString *)title
                    cancelButtonItem:(JHBlockActionSheetItem *)cancelItem
               destructiveButtonItem:(JHBlockActionSheetItem *)destructiveItem
                    otherButtonItems:(JHBlockActionSheetItem *)otherItems,...
{
    JHBlockActionSheet *actionSheet = [[JHBlockActionSheet alloc] initActionSheetWithTitle:title
                                                                          cancelButtonItem:cancelItem
                                                                     destructiveButtonItem:destructiveItem
                                                                          otherButtonItems:nil];
    
    JHBlockActionSheetItem *item;
    va_list argumentList;
    
    if (otherItems) {
        
        [actionSheet addButtonWithItem:otherItems];
        
        va_start(argumentList, otherItems);
        
        while ((item = va_arg(argumentList, JHBlockActionSheetItem *))) {
            
            [actionSheet addButtonWithItem:item];
            
        }
        va_end(argumentList);
    }
    
    return actionSheet;
}

- (instancetype)initActionSheetWithTitle:(NSString *)title
                        cancelButtonItem:(JHBlockActionSheetItem *)cancelItem
                   destructiveButtonItem:(JHBlockActionSheetItem *)destructiveItem
                        otherButtonItems:(JHBlockActionSheetItem *)otherItems,...
{
    self = [super initWithTitle:title delegate:self
              cancelButtonTitle:cancelItem.title
         destructiveButtonTitle:destructiveItem.title
              otherButtonTitles:nil];
    
    _destructiveItem = destructiveItem;
    _cancelItem      = cancelItem;
    
    JHBlockActionSheetItem *item;
    
    // 可变参数处理
    va_list argumentList;
    
    if (otherItems) {
        
        [self addButtonWithItem:otherItems];
        
        va_start(argumentList, otherItems);
        
        while ((item = va_arg(argumentList, JHBlockActionSheetItem *))) {
            
            [self addButtonWithItem:item];
            
        }
        va_end(argumentList);
    }
    
    return self;
}

- (void)addButtonWithItem:(JHBlockActionSheetItem *)item;
{
    if (_otherButtonItems == nil) {
        _otherButtonItems = [NSMutableArray array];
    }
    [_otherButtonItems addObject:item];
    
    // 获取item的index
    item.itemIndex = [self addButtonWithTitle:item.title];
}

#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        
        if (_cancelItem && _cancelItem.block) {
            _cancelItem.block();
        }
        
    } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        
        if (_destructiveItem && _destructiveItem.block) {
            _destructiveItem.block();
        }

    } else {
        
        [_otherButtonItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            JHBlockActionSheetItem *item = obj;
            if (item.itemIndex == buttonIndex && item.block) {
                item.block();
            }
        }];
        
    }
}

@end


