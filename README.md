# SegmentedControl

## Description

A simple segmented control view for iOS 7.


## Installation

Simply plop this repo into your project, and you should be good to go.

## Usage

    @interface LPSegmentedControl : UIView

    - (id)initWithFrame:(CGRect)frame andButtonTitles:(NSArray *)buttonTitles andTintColor:(UIColor *)tintColor andDelegate:(id<LPSegmentedControlDelegate>)delegate;

    - (void)selectButtonAtIndex:(NSUInteger)buttonIndex;

    @end



    @protocol LPSegmentedControlDelegate <NSObject>

    - (void)segmentedControl:(LPSegmentedControl *)segmentedControl buttonTappedWithIndex:(NSUInteger)buttonIndex andTitle:(NSString *)title;

    @end
