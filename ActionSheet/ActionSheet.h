//
//  ActionSheet.h
//  ActionSheet
//
//  Created by M Usman Saeed on 08/07/2017.
//  Copyright © 2017 MUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheet : UIControl<UITableViewDataSource,UITableViewDelegate>


typedef void (^DidTapAtIndexPath)(NSIndexPath *indexPath);
@property (copy, nonatomic) DidTapAtIndexPath SelectedAtIndexPath;


@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *shadowView;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *images;

-(void)showActionSheetWithTitle:(NSString *)title scrollEnable:(BOOL)scrollEnable;
-(void)hide;

@end

