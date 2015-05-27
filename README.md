# JHBlockActionSheet
###`支持block回调`

###基本使用方法

###1.导入 #import "JHBlockActionSheet.h"

###2.使用JHBlockActionSheetItem创建item
    JHBlockActionSheetItem *item1 = [JHBlockActionSheetItem itemWithTitle:@"1" andBlock:^{
        NSLog(@"1");
    }];

###3.初始化ActionSheet
    JHBlcokActionSheet *action = [[JHBlcokActionSheet alloc] initActionSheetWithTitle:@"哈哈"
                                                                     cancelButtonItem:item3
                                                                destructiveButtonItem:item1
                                                                     otherButtonItems:item2, item3, item4,nil];

###4.显示
    [action showInView:self.view];

#JHBlockActionSheet+ImagePicker

##利用JHBlockActionSheet快速实现图像选取

    __weak __typeof(self)weakSelf = self;
    JHBlockActionSheet *sheet = [JHBlockActionSheet photoPickerSheetWithTitle:nil
                                                                allowsEditing:YES
                                                            presentController:self
                                                             pickerCompletion:^(UIImage *pickImage) {
        weakSelf.imageView.image = pickImage;
    }];
    
    [sheet showInView:self.view];
    
    
    
    
##仅仅需要一行代码即可搞定
    