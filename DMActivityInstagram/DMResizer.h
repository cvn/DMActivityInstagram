//
//  DMResizer.h
//  Pods
//
//  Created by Alejandro Benito on 13/05/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DMResizer;

@protocol DMResizerDelegate <NSObject>

-(void)resizer:(id <DMResizer>)resizer finishedResizingWithResult:(UIImage *)image;
-(NSArray *)backgroundColors;

@end


@protocol DMResizer <NSObject>

@property (nonatomic, strong) UIImage *inputImage;
@property (nonatomic, strong) id <DMResizerDelegate> delegate;
@property (readwrite) BOOL skipCropping;

@required
- (instancetype)initWithImage:(UIImage *)imageObject andDelegate:(id<DMResizerDelegate>)delegate;

#pragma mark - Actions
- (void)editingDone;
- (void)cancel;
- (void)changeBackgroundColorTo:(UIColor *)newColor;

@optional
- (void)rotateImage;

@end
