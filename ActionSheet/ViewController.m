//
//  ViewController.m
//  ActionSheet
//
//  Created by M Usman Saeed on 08/07/2017.
//  Copyright © 2017 MUS. All rights reserved.
//

#import "ViewController.h"
#import "ActionSheet.h"

@interface ViewController ()
@property (strong, nonatomic) ActionSheet *actionSheet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showActionSheet:(id)sender {

    self.actionSheet = [[ActionSheet alloc] init];
    self.actionSheet.items = @[@"Toyota",@"Honda",@"Jaguar",@"Porsche",@"Suzuki"];
    self.actionSheet.images = @[@"logo",@"logo",@"logo",@"logo",@"logo"];
    [self.actionSheet showActionSheetWithTitle:@"Select Car" scrollEnable:NO];
    [self.actionSheet setSelectedAtIndexPath:^(NSIndexPath *indexPath){
        NSLog(@"%@",indexPath);
    }];
}

@end
