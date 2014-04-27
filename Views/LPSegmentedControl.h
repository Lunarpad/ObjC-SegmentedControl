//
//  LPSegmentedControl.h
//  Lunarpad
//
//  Created by Paul Shapiro.
//  Copyright (c) 2014 Lunarpad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPSegmentedControl;

@protocol LPSegmentedControlDelegate <NSObject>

- (void)segmentedControl:(LPSegmentedControl *)segmentedControl buttonTappedWithIndex:(NSUInteger)buttonIndex andTitle:(NSString *)title;

@end

@interface LPSegmentedControl : UIView

- (id)initWithFrame:(CGRect)frame andButtonTitles:(NSArray *)buttonTitles andTintColor:(UIColor *)tintColor andDelegate:(id<LPSegmentedControlDelegate>)delegate;

- (void)selectButtonAtIndex:(NSUInteger)buttonIndex;

@end
