//
//  EmptyTableBackroundView.m
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import "EmptyTableBackroundView.h"

#define PREFERRED_MAX_LAYOUT_WIDTH  (IS_IPAD ?   320 :   220)
#define FONT_SIZE                   (IS_IPAD ? 25.0f : 20.0f)

@implementation EmptyTableBackroundView

@synthesize textLabel = _textLabel;
@synthesize activityIndicatorView = _activityIndicatorView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.textLabel];
        [self addSubview:self.activityIndicatorView];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addConstraints:[self layoutConstraints]];
    }
    return self;
}

-(UILabel *)textLabel{
    if (!_textLabel) {
//        _textLabel = [UILabel autolayoutView];
        _textLabel.numberOfLines = 0;
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
//        [_textLabel setPreferredMaxLayoutWidth:PREFERRED_MAX_LAYOUT_WIDTH];
//        [_textLabel setFont:[UIFont fontWithName:FONT_LATO_REGULAR size:FONT_SIZE]];
//        [_textLabel setTextColor:[UIColor colorWithHex:COLOR_PATIENT_NAME]];
    }
    return _textLabel;
}

-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
//        _activityIndicatorView = [UIActivityIndicatorView autolayoutView];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        if ([UIDevice isPad]) {
            _activityIndicatorView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }
        _activityIndicatorView.hidesWhenStopped = YES;
//    }
    return _activityIndicatorView;
}

#pragma mark - Layout Constraints

-(NSArray *)layoutConstraints{
    
    NSMutableArray * result = [NSMutableArray array];
    
    NSDictionary * views = @{ @"textLabel": self.textLabel,
                              @"activityIndicatorView": self.activityIndicatorView
                              };
    
    [result addObject:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX  relatedBy:NSLayoutRelationEqual  toItem:self  attribute:NSLayoutAttributeCenterX  multiplier:1  constant:0]];
    [result addObject:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY  relatedBy:NSLayoutRelationEqual  toItem:self  attribute:NSLayoutAttributeCenterY  multiplier:0.75  constant:0]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textLabel]-15-[activityIndicatorView]"
                                                                        options:NSLayoutFormatAlignAllCenterX metrics:nil
                                                                          views:views]];
    return result;
}

-(void)startLoading:(NSString *)text
{
    [self.activityIndicatorView startAnimating];
    self.textLabel.text = text;
}
-(void)stopLoading:(NSString *)text
{
    [self.activityIndicatorView stopAnimating];
    self.textLabel.text = text;
}

@end
