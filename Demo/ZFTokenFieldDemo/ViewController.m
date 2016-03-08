//
//  ViewController.m
//  ZFTokenFieldDemo
//
//  Created by Amornchai Kanokpullwad on 11/11/2014.
//  Copyright (c) 2014 Amornchai Kanokpullwad. All rights reserved.
//

#import "ViewController.h"
#import "ZFTokenField.h"

@interface ViewController () <ZFTokenFieldDataSource, ZFTokenFieldDelegate>
@property (weak, nonatomic) IBOutlet ZFTokenField *tokenField;
@property (nonatomic, strong) NSMutableArray *tokens;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tokens = [NSMutableArray array];
    
    
    NSLog(@":\u200B\u200B\u200B");
    NSLog(@"11");
    
    self.tokenField.dataSource = self;
    self.tokenField.delegate = self;
//    self.tokenField.maxContact = 4;
    self.tokenField.showPlusButton = YES;
    self.tokenField.textField.placeholder = @"Enter here";
    [self.tokenField reloadData];
    
    [self.tokenField.textField becomeFirstResponder];
}

- (IBAction)sendButtonPressed:(id)sender
{
    self.tokens = [NSMutableArray array];
    [self.tokenField reloadData];
}

- (void)tokenDeleteButtonPressed:(UIButton *)tokenButton
{
    NSUInteger index = [self.tokenField indexOfTokenView:tokenButton.superview];
    if (index != NSNotFound) {
        [self.tokens removeObjectAtIndex:index - 1];
        [self.tokenField reloadData];
    }
}

#pragma mark - ZFTokenField DataSource

- (CGFloat)lineHeightForTokenInField:(ZFTokenField *)tokenField
{
    return 40;
}

- (NSUInteger)numberOfTokenInField:(ZFTokenField *)tokenField
{
    return self.tokens.count;
}

- (UIView *)tokenField:(ZFTokenField *)tokenField viewForTokenAtIndex:(NSUInteger)index
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TokenView" owner:nil options:nil];
    UIView *view = nibContents[0];
    UILabel *label = (UILabel *)[view viewWithTag:2];
    UIButton *button = (UIButton *)[view viewWithTag:3];
    
    [button addTarget:self action:@selector(tokenDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = CGRectGetWidth(button.frame) / 2;
    button.layer.masksToBounds = YES;
    
    label.text = self.tokens[index];
    CGSize size = [label sizeThatFits:CGSizeMake(1000, 30)];
    view.frame = CGRectMake(0, 0, size.width + 50, 30);
    return view;
}

#pragma mark - ZFTokenField Delegate

- (CGFloat)tokenMarginInTokenInField:(ZFTokenField *)tokenField
{
    return 5;
}

- (void)tokenField:(ZFTokenField *)tokenField didReturnWithText:(NSString *)text
{
    [self.tokens addObject:text];
    [tokenField reloadData];
}

- (void)tokenField:(ZFTokenField *)tokenField didRemoveTokenAtIndex:(NSUInteger)index
{
    [self.tokens removeObjectAtIndex:index];
}

- (BOOL)tokenFieldShouldEndEditing:(ZFTokenField *)textField
{
    return NO;
}

- (void)tokenFieldSelectDetailButton:(ZFTokenField *)tokenField
{
    NSLog(@"点击详情按钮");
}

- (void)tokenFieldSelectAddContactButton:(ZFTokenField *)tokenField
{
    NSLog(@"add contact");
}

@end
