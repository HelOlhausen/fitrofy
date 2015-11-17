//
//  EmptyTableBackroundView.h
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyTableBackroundView : UIView

@property (nonatomic) UILabel * textLabel;
@property (nonatomic) UIActivityIndicatorView * activityIndicatorView;

-(void)startLoading:(NSString *)text;
-(void)stopLoading:(NSString *)text;

@end