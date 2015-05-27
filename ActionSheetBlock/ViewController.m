//
//  ViewController.m
//  ActionSheetBlock
//
//  Created by e1858 on 15/5/26.
//  Copyright (c) 2015年 e1858. All rights reserved.
//

#import "ViewController.h"
#import "JHBlockActionSheet.h"
#import "JHBlockActionSheet+ImagePicker.h"

@interface ViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController



- (IBAction)firstButtonClick:(UIButton *)sender
{
    __weak __typeof(self)weakSelf = self;
    
//    JHBlockActionSheetItem *item1 = [JHBlockActionSheetItem itemWithTitle:@"1" andBlock:^{
//        NSLog(@"1");
//    }];
//    JHBlockActionSheetItem *item2 = [JHBlockActionSheetItem itemWithTitle:@"2" andBlock:^{
//        NSLog(@"2");
//    }];
    JHBlockActionSheetItem *item3 = [JHBlockActionSheetItem itemWithTitle:@"3" andBlock:^{
        [weakSelf showMessage];
    }];
    JHBlockActionSheetItem *item4 = [JHBlockActionSheetItem itemWithTitle:@"4" andBlock:nil];

    JHBlockActionSheet *action = [[JHBlockActionSheet alloc] initActionSheetWithTitle:@"哈哈"
                                                                     cancelButtonItem:item3
                                                                destructiveButtonItem:nil
                                                                     otherButtonItems:item4,nil];
    [action showInView:self.view];
}

- (void)showMessage
{
    NSLog(@"message");
}


- (IBAction)secendButtonClick:(UIButton *)sender
{
    
    __weak __typeof(self)weakSelf = self;
    JHBlockActionSheet *sheet = [JHBlockActionSheet photoPickerSheetWithTitle:nil
                                                                allowsEditing:YES
                                                            presentController:self
                                                             pickerCompletion:^(UIImage *pickImage) {
        weakSelf.imageView.image = pickImage;
    }];
    
    [sheet showInView:self.view];
}

@end
