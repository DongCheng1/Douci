//
//  UIView+Frame.m
//  Baisibudejie
//
//  Created by 董成 on 2018/12/11.
//  Copyright © 2018 董成. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)



- (CGFloat)dc_height {
    return self.frame.size.height;
}
- (void)setDc_height:(CGFloat)dc_height {
    CGRect rect = self.frame;
    rect.size.height = dc_height;
    self.frame = rect;
}



- (CGFloat)dc_width {
    return self.frame.size.width;
}
- (void)setDc_width:(CGFloat)dc_width {
    CGRect rect = self.frame;
    rect.size.height = dc_width;
    self.frame = rect;
}



- (CGFloat)dc_x {
    return self.frame.origin.x;
}
- (void)setDc_x:(CGFloat)dc_x {
    CGRect rect = self.frame;
    rect.origin.x = dc_x;
    self.frame = rect;
}



- (CGFloat)dc_y {
    return self.frame.origin.y;
}
- (void)setDc_y:(CGFloat)dc_y {
    CGRect rect = self.frame;
    rect.origin.y = dc_y;
    self.frame = rect;
}


@end
