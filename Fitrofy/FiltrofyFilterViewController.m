//
//  FiltrofyFilterViewController.m
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import "FilterViewController.h"

#define kEmptyTableText NSLocalizedString(@"There are no filters..", nil)

@interface FiltrofyFilterViewController ()
//@property (nonatomic) LoadingEmptyTableBackgroundView * emptyTableBackgroundView;
@end

@implementation FiltrofyFilterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)fetchedFilters:(NSArray *)fetchedFilters
{
    _fetchedFilters = fetchedFilters;
    [self.tableView reloadData];
    
    if (_fetchedFilters.count == 0) {
//        self.tableView.backgroundView = self.emptyTableBackgroundView;
//        [self.emptyTableBackgroundView stopLoading:kEmptyTableText];
//        [self.emptyTableBackgroundView setHidden:NO];
    } else {
        [self.tableView.backgroundView setHidden:YES];
    }
}

-(NSString *)filterName
{
    return @"";
}

-(NSString *)baseRIURL
{
    if (!_baseRIURL) {
//        _baseRIURL = [NSString stringWithFormat:@"care_providers/%@/recent_interactions/%@", cpuid, self.filterName];
    }
    return _baseRIURL;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customizeAppearanceBasic];
//    [self.emptyTableBackgroundView startLoading:@""];
    // Register Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchFilterValues];
    
    // Add observer for popover
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

// Observer for popover
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]){
        [self setPreferredContentSize:CGSizeMake(320.0, self.tableView.contentSize.height)];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Remove observer for popover
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

-(void)customizeAppearanceBasic
{
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.backgroundColor = [UIColor colorWithHex:COLOR_VIEWS_BACKGROUND];
    self.navigationItem.hidesBackButton = YES;
}

-(void)fetchFilterValues
{
    __typeof__(self) __weak weakSelf = self;
    [[OrchidHttpSessionManager sharedClient] GET:self.baseRIURL
                                      parameters:[OrchidHttpSessionManager sharedClient].commonRequestParameters
                                         success:^(NSURLSessionDataTask *task, id responseObject) {
                                             weakSelf.fetchedFilters = [responseObject valueForKeyPath:self.filterName];
                                             [weakSelf.tableView reloadData];
                                         }
                                         failure:^(NSURLSessionDataTask *task, NSError *error) {
                                             
                                         }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCell
                                                             forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont fontWithName:FONT_LATO_REGULAR size:FONT_SIZE_SETTINGS_TEXTLABEL];
    cell.textLabel.textColor = [UIColor colorWithHex:COLOR_GENERAL_LABEL];
    
    NSString * filter = [[self.fetchedFilters objectAtIndex:indexPath.row] valueForKey:@"value"];
    cell.textLabel.text = filter;
    // compare against name
    cell.accessoryType = ((self.rowDescriptor.value && [self.rowDescriptor.value isEqualToString:filter]) ?
                          UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
    return cell;
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath*) indexPath
{
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    NSString * filter = [[self.fetchedFilters objectAtIndex:indexPath.row] valueForKey:@"value"];
    
    if ([self.rowDescriptor.value isEqualToString:filter]) {
        self.rowDescriptor.value = nil;
    } else {
        self.rowDescriptor.value = filter;
    }
    [self.tableView reloadData];
    
    [self.delegate didChangeFilter:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedFilters.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0f;
}

@end