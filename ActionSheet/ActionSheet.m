/**
 * Copyright © 2017 MUS.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "ActionSheet.h"

@interface ActionSheet ()

@end

@implementation ActionSheet

-(instancetype)init{

   self = [super init];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 1000, self.frame.size.width, self.frame.size.height)];
    
    [self.containerView setBackgroundColor:[UIColor whiteColor]];
    [self.shadowView addSubview:self.containerView];
    
    self.lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.frame.size.width - 8,21)];
    [self.containerView addSubview:self.lblTitle];
    
    UIView *separator = [[UIView alloc]initWithFrame:CGRectMake(0, self.lblTitle.frame.size.height + self.lblTitle.frame.origin.y + 8, self.frame.size.width, 2)];
    [separator setBackgroundColor:[UIColor darkGrayColor]];
    [self.containerView addSubview:separator];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.lblTitle.frame.size.height + self.lblTitle.frame.origin.y + 9, self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
    [self.containerView addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    tapGestureRecognizer.cancelsTouchesInView = YES;
    tapGestureRecognizer.delegate = (id)self;
    
    [self.shadowView addGestureRecognizer:tapGestureRecognizer];
    [self.shadowView setUserInteractionEnabled:YES];
    [self.shadowView setExclusiveTouch:YES];
    self.shadowView.backgroundColor = [UIColor colorWithRed:0/225 green:0/225 blue:0/225 alpha:0.5];
    [self.lblTitle addGestureRecognizer:tapGestureRecognizer];
    [self.lblTitle setUserInteractionEnabled:YES];
    [self.lblTitle setExclusiveTouch:YES];
    
    [self addSubview:self.shadowView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    return self;
}


-(void)showActionSheetWithTitle:(NSString *)title scrollEnable:(BOOL)scrollEnable;
{
    
    UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;

    CGFloat statusBarOffset;
    
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        if (statusBarSize.width < statusBarSize.height) {
            statusBarOffset = statusBarSize.width;
        }
        else{
            statusBarOffset = statusBarSize.height;
        }
    }
    else{
        statusBarOffset = 0.0;
    }
    
    CGFloat width, height;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
        [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        width = top.view.frame.size.height;
        height = top.view.frame.size.width;
    }
    else{
        width = top.view.frame.size.width;
        height = top.view.frame.size.height;
    }
    
    [self setFrame:CGRectMake(top.view.frame.origin.x, top.view.frame.origin.y, width, height)];
    
    self.lblTitle.text = title;
    self.tableView.scrollEnabled = scrollEnable;
    [top.view addSubview:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    CGRect viewRect = self.containerView.frame;
    
    float Viewheight = ([self.items count] * 51) + 37;
    float ViewYPos = self.frame.size.height - ([self.items count] * 51)-37;
    
    if (Viewheight > top.view.frame.size.height - 65) {
        Viewheight = top.view.frame.size.height - 65;
        ViewYPos = 65;
        self.tableView.scrollEnabled = YES;
        
    }else{}
    
    viewRect.origin.y = ViewYPos;
    viewRect.size.height = Viewheight;
    self.containerView.frame = viewRect;
    
    CGRect rect = self.tableView.frame;
    rect.size.height = viewRect.size.height - 37;
    self.tableView.frame = rect;
    [UIView commitAnimations];
    [self.tableView reloadData];
    
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    [self hide];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(51, 13, self.frame.size.width - 12,21)];
    [cell addSubview:itemLabel];
    UIImageView *itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 6, 35,35)];
    [itemImageView setContentMode:UIViewContentModeScaleAspectFit];
    [cell addSubview:itemImageView];
    
    if ([self.items count]) {
        
        itemLabel.text = [self.items objectAtIndex:[indexPath row]];
        if ([self.images count]) {
            itemImageView.image =  [UIImage imageNamed:[self.images objectAtIndex:[indexPath row]]];
        }
    }
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.SelectedAtIndexPath) {
        self.SelectedAtIndexPath(indexPath);
        [self hide];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)hide{
    
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect viewRect = self.containerView.frame;
                         viewRect.origin.y = 1000;
                         self.containerView.frame = viewRect;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{ self.shadowView.layer.opacity = 0.0f; } completion:^(BOOL finished) {
                                              [self removeFromSuperview]; } ]; }
     ];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        return NO;
    }
    return YES;
}

@end
