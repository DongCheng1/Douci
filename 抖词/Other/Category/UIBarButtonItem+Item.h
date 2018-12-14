//
//  UIBarButtonItem+Item.h
//  Baisibudejie
//
//  Created by 董成 on 2018/12/12.
//  Copyright © 2018 董成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)backitemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
