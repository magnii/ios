//
//  StuSelectBarButton.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/12.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuSelectBarButton.h"

@implementation StuSelectBarButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.origin.x = 0;
    labelFrame.size.width = self.frame.size.width*0.5;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.titleLabel.frame = labelFrame;
    
    CGRect imgFrame = self.imageView.frame;
    imgFrame.origin.x = CGRectGetMaxX(self.titleLabel.frame);
    self.imageView.frame = imgFrame;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}


@end
