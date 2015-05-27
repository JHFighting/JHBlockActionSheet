//
//  ViewController.m
//  ActionSheetBlock
//
//  Created by e1858 on 15/5/26.
//  Copyright (c) 2015年 e1858. All rights reserved.
//

#import "ViewController.h"
#import "JHBlockActionSheet.h"

@interface ViewController () <UIActionSheetDelegate>

@end

@implementation ViewController



- (IBAction)firstButtonClick:(UIButton *)sender
{
    JHBlockActionSheetItem *item1 = [JHBlockActionSheetItem itemWithTitle:@"1" andBlock:^{
        NSLog(@"1");
    }];
    JHBlockActionSheetItem *item2 = [JHBlockActionSheetItem itemWithTitle:@"2" andBlock:^{
        NSLog(@"2");
    }];
    JHBlockActionSheetItem *item3 = [JHBlockActionSheetItem itemWithTitle:@"3" andBlock:^{
        NSLog(@"3");
    }];
    JHBlockActionSheetItem *item4 = [JHBlockActionSheetItem itemWithTitle:@"4" andBlock:nil];

    JHBlockActionSheet *action = [[JHBlockActionSheet alloc] initActionSheetWithTitle:@"哈哈" cancelButtonItem:item3 destructiveButtonItem:item1 otherButtonItems:item2, item3, item4,nil];
    [action showInView:self.view];
}


- (IBAction)secendButtonClick:(UIButton *)sender
{
    JHBlockActionSheetItem *item1 = [JHBlockActionSheetItem itemWithTitle:@"1" andBlock:^{
        NSLog(@"1");
    }];
    JHBlockActionSheetItem *item2 = [JHBlockActionSheetItem itemWithTitle:@"2" andBlock:^{
        NSLog(@"2");
    }];
    JHBlockActionSheetItem *item3 = [JHBlockActionSheetItem itemWithTitle:@"3" andBlock:^{
        NSLog(@"3");
    }];
    JHBlockActionSheetItem *item4 = [JHBlockActionSheetItem itemWithTitle:@"4" andBlock:nil];
    
    JHBlockActionSheet *sheet = [JHBlockActionSheet actionSheetWithTitle:@"哈哈" cancelButtonItem:item3 destructiveButtonItem:item1 otherButtonItems:item2, item3, item4,nil];
    
    [sheet showInView:self.view];
}

@end
