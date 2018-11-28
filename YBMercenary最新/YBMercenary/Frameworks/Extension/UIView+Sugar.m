//
//  UIView+Sugar.m
//  DSSManito
//
//  Created by Sunny on 2018/1/22.
//  Copyright © 2018年 pengfei.li. All rights reserved.
//

#import "UIView+Sugar.h"

@implementation UIView (Sugar)

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)height {
    
    return  self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)minX {
    
    return self.frame.origin.x;
}

- (CGFloat)minY {
    
    return self.frame.origin.y;
}

- (CGFloat)maxX {
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}


- (CGFloat)x {
    
    return  self.minX;
}

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
}

- (CGFloat)y {
    
    return  self.minY;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
}

@end
