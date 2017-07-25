

## Objective-c
``` objective-c
#import "ActionSheet.h"
```
#### ActionSheet

Usage:

```objective-c
@property (strong, nonatomic) ActionSheet *actionSheet;
```

 **- (void)viewDidLoad**

```objective-c
self.actionSheet = [[ActionSheet alloc] init];
self.actionSheet.items = @[@"Toyota",@"Toyota",@"Toyota",@"Toyota",@"Toyota"];
self.actionSheet.images = @[@"logo",@"logo",@"logo",@"logo",@"logo"];
[self.actionSheet showActionSheetWithTitle:@"Select Car" scrollEnable:NO];
[self.actionSheet setSelectedAtIndexPath:^(NSIndexPath *indexPath){
   NSLog(@"%@",indexPath);
}];
```
