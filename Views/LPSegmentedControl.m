//
//  LPSegmentedControl.m
//  Lunarpad
//
//  Created by Paul Shapiro.
//  Copyright (c) 2014 Lunarpad. All rights reserved.
//

#import "LPSegmentedControl.h"



////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros



////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants



////////////////////////////////////////////////////////////////////////////////
#pragma mark - C



////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface LPSegmentedControl ()

@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, unsafe_unretained) id<LPSegmentedControlDelegate> delegate;

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation LPSegmentedControl


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame andButtonTitles:(NSArray *)buttonTitles andTintColor:(UIColor *)tintColor andDelegate:(id<LPSegmentedControlDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = tintColor;
        self.buttonTitles = buttonTitles;
        
        self.delegate = delegate;

        [self setup];
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setup

- (void)setup
{
    self.buttons = [NSMutableArray new];
    
    self.layer.borderColor = self.tintColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    [self setupButtons];
    [self startObserving];
}

- (void)setupButtons
{
    int i = 0;
    UIImage *tintedBackgroundImage = [self _newImageFromColor:self.tintColor];
    CGSize buttonSize = [self buttonSize];
    for (NSString *buttonTitle in self.buttonTitles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:self.tintColor forState:UIControlStateNormal];
        [button setTitleColor:WHITE forState:UIControlStateSelected];
        [button setTitleColor:WHITE forState:UIControlStateHighlighted];
        [button setBackgroundImage:tintedBackgroundImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:tintedBackgroundImage forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont fontWithName:HelveticaNeue size:13];
        
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(i * buttonSize.width, 0, buttonSize.width, buttonSize.height);
        
        [self addSubview:button];
        [self.buttons addObject:button];
        
        i++;
    }
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Accessors

- (CGFloat)buttonWidth
{
    return self.frame.size.width/self.buttonTitles.count;
}

- (CGSize)buttonSize
{
    return CGSizeMake([self buttonWidth], self.frame.size.height);
}

- (UIImage *)_newImageFromColor:(UIColor *)color
{
    CGSize buttonSize = [self buttonSize];
    CGRect rect = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Imperatives

- (void)selectButtonAtIndex:(NSUInteger)buttonIndex
{
    if (buttonIndex >= self.buttons.count) {
        NSLog(@"Warn: You tried to select a button that doesn't exist.");
        return;
    }
    [self selectButton:self.buttons[buttonIndex]];
}

- (void)selectButton:(UIButton *)buttonToSelect
{
    buttonToSelect.selected = YES;
    for (UIButton *button in self.buttons) {
        if (![button isEqual:buttonToSelect]) {
            button.selected = NO;
        }
    }
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation

- (void)buttonTapped:(UIButton *)buttonTapped
{
    [self selectButton:buttonTapped];
    if (self.delegate) {
        [self.delegate segmentedControl:self buttonTappedWithIndex:buttonTapped.tag andTitle:[buttonTapped titleForState:UIControlStateNormal]];
    }
}

@end
