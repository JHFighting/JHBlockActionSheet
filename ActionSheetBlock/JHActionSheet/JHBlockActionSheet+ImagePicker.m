//
//  JHBlockActionSheet+ImagePicker.m
//  ActionSheetBlock
//
//  Created by e1858 on 15/5/27.
//  Copyright (c) 2015年 e1858. All rights reserved.
//

#import "JHBlockActionSheet+ImagePicker.h"

#pragma mark - 图像选择控制器
@interface JHBlockImagePickerController : UIImagePickerController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, copy) JHPhotoPicker_t photoBlock;

@end

@implementation JHBlockImagePickerController

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    JHBlockImagePickerController *imagePicker = (id)picker;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (imagePicker.photoBlock) {
        
        if (image.size.width > 1024) {
            
            // 比例
            CGFloat scaleSize = 1024 / image.size.width;
            
            image = [imagePicker imageWithImage:image scaledToSize:CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize)];
        }
        
        imagePicker.photoBlock(image);
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

//对图片尺寸进行压缩
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
 
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

@implementation JHBlockActionSheet (ImagePicker)

+ (instancetype)photoPickerSheetWithTitle:(NSString *)title
                            allowsEditing:(BOOL)allowsEditing
                        presentController:(UIViewController *)controller
                         pickerCompletion:(JHPhotoPicker_t)photoPicker
{
    __weak UIViewController *weakVC = controller;
    
    dispatch_block_t libraryBlock = ^{  // 相册
    
        JHBlockImagePickerController *imagePicker = [[JHBlockImagePickerController alloc] init];
        imagePicker.photoBlock                    = photoPicker;
        imagePicker.allowsEditing                 = allowsEditing;
        imagePicker.delegate                      = imagePicker;
        imagePicker.sourceType                    = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakVC presentViewController:imagePicker animated:YES completion:nil];
        
    };
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
        JHBlockActionSheetItem *cancelItem  = [JHBlockActionSheetItem itemWithTitle:@"取消" andBlock:nil];

        JHBlockActionSheetItem *libraryItem = [JHBlockActionSheetItem itemWithTitle:@"从手机相册选择" andBlock:libraryBlock];

        JHBlockActionSheetItem *cameraItem  = [JHBlockActionSheetItem itemWithTitle:@"拍照" andBlock:^{
            
            JHBlockImagePickerController *imagePicker = [[JHBlockImagePickerController alloc] init];
            imagePicker.photoBlock                    = photoPicker;
            imagePicker.allowsEditing                 = allowsEditing;
            imagePicker.delegate                      = imagePicker;
            imagePicker.videoQuality                  = UIImagePickerControllerQualityTypeLow;
            imagePicker.sourceType                    = UIImagePickerControllerSourceTypeCamera;
            [weakVC presentViewController:imagePicker animated:YES completion:nil];
            
        }];
        
        return [JHBlockActionSheet actionSheetWithTitle:title
                                       cancelButtonItem:cancelItem
                                  destructiveButtonItem:nil
                                       otherButtonItems:cameraItem, libraryItem, nil];
        
    } else { // 不能拍照，直接从相册中选取
        
        libraryBlock();
        return nil;
    }
}


@end
