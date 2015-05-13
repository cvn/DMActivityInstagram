//
//  DMColorPickerView.m
//  DMActivityInstagram
//
//  Created by Cory Alder on 2013-09-23.
//  Copyright (c) 2013 Cory Alder. All rights reserved.
//

#import "DMColorPickerView.h"

@interface DMColorPickerView ()

@property (assign, nonatomic) BOOL didSetupConstraints;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (strong ,nonatomic) UIView *contentView;

@end



@implementation DMColorPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)drawRect:(CGRect)rect
{
    for (UIButton *button in [self.contentView subviews]) {
        if (self.roundedButtons) {
            button.layer.cornerRadius = button.bounds.size.width / 2.0;
        }
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 3.0f;
    }
    [self.contentView setNeedsDisplay];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

-(void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.contentView = [UIView new];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.contentView];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:self.scrollView];
}

- (void)updateConstraints
{
    if (self.didSetupConstraints) {
        [super updateConstraints];
        return;
    }
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.scrollView
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1.0f
                                                                        constant:0.0f];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.scrollView
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.scrollView
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.scrollView
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    [self addConstraints:@[widthConstraint, heightConstraint, centerX, centerY]];
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];

    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [self updateColors];
    self.didSetupConstraints = YES;
    [super updateConstraints];
}

-(void)updateColors {

//    NSInteger widthUnit = self.bounds.size.height-8;
//    static NSInteger vGapUnit = 8;
//    static NSInteger hGapUnit = 4;
//    NSInteger width = vGapUnit + ([self.colors count] * (widthUnit+vGapUnit));
    
//    self.scrollView.contentSize = (CGSize){width, self.bounds.size.height};
//    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIButton *previousButton;
    
    for (UIColor *color in self.colors) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [button addTarget:self.delegate action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        if ([color isKindOfClass:[UIColor class]]) {
            button.backgroundColor = color;
        } else {
            button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:(NSString *)color]];
        }
        //ADD contentview constraints
        
        [self.contentView addSubview:button];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-8];
        widthConstraint.priority = UILayoutPriorityRequired;
        [self.contentView addConstraint:widthConstraint];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-8];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        [self.contentView addConstraint:heightConstraint];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        
        if (previousButton) {
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:previousButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
        } else {
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8]];
        }
        previousButton = button;
    }
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:previousButton attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:8]];
}

@end
