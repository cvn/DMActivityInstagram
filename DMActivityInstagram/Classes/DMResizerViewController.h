//
//  SHKInstagramResizeViewController.h
//  CatPaint
//
//  Created by Cory Alder on 11-07-22.
//  Copyright 2011 Davander Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMColorPickerView.h"
#import "DMResizer.h"

@class DMResizerViewController;


@interface DMResizerViewController : UIViewController <UIScrollViewDelegate, DMColorPickerDelegate, DMResizer>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;

@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIView *topView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, strong) IBOutlet DMColorPickerView *colorPicker;




@end
