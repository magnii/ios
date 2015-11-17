//
//  StuSelectBarTableViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/13.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectBarProtocol<NSObject>

- (void)loadNewJobsWithSelectedItem:(NSString*)item;

@end

@interface StuSelectBarTableViewController : UITableViewController

@property(nonatomic, strong)NSString *selectedItem;
@property(nonatomic, strong)NSArray *itemsArray;
@property(nonatomic, weak)id<SelectBarProtocol> delegate;
@property(nonatomic, strong)NSString *selectItem;

@end
