//
//  UsersFilterViewController.m
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import "UsersFilterViewController.h"

@interface UsersFilterViewController ()

@end

@implementation UsersFilterViewController

-(instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSString *)filterName
{
    return @"users";
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle: NSLocalizedString(@"Users", nil)];
}

@end
