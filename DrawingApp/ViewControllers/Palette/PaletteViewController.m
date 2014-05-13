//
//  PaletteViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "PaletteViewController.h"
#import "ColorInPaletteView.h"

@interface PaletteViewController ()
@property (strong, nonatomic) IBOutletCollection(ColorInPaletteView) NSArray *colorInPaletteViews;

@end

@implementation PaletteViewController

+ (CGSize)prefferedSize
{
    return CGSizeMake(380, 290);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.clearColorButton.currentTitle attributes:@{NSParagraphStyleAttributeName : paragraphStyle}];
//    
//    [self.clearColorButton setAttributedTitle:attrString forState:(UIControlStateNormal)];
}

- (NSArray *)colors
{
    return @[[UIColor blackColor],
             [UIColor blueColor],
             [UIColor brownColor],
             [UIColor cyanColor],
             [UIColor greenColor],
             [UIColor magentaColor],
             [UIColor orangeColor],
             [UIColor purpleColor],
             [UIColor redColor],
             [UIColor yellowColor],
             [UIColor whiteColor],
             [UIColor clearColor]];
}

- (void)setupUI
{
    WeakSelf;
    
    NSArray *colors = [self colors];
    
    for (int i = 0; i < self.colorInPaletteViews.count; i++) {
        ColorInPaletteView *colorView = self.colorInPaletteViews[i];
        colorView.fillColor = colors[i];
        colorView.strokeColor = [UIColor darkGrayColor];
        
        ColorInPaletteView * __weak weakColorView = colorView;
        colorView.Tap = ^{
            if (weakSelf.UpdateColor) {
                weakSelf.UpdateColor(weakColorView.fillColor);
            }
        };
    }
}

//- (IBAction)changeColorFromButton:(UIButton *)sender
//{
//}

@end
