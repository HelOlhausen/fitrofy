//
//  FiltrofyTableViewController.m
//  Fitrofy
//
//  Created by Helen Olhausen on 10/30/15.
//  Copyright © 2015 Helen Olhausen. All rights reserved.
//

#import "FiltrofyTableViewController.h"
#import "EmptyTableBackroundView.h"

#define kEmptyTableText NSLocalizedString(@"There are is no data for the selected filters..", nil)


@interface FiltrofyTableViewController ()

@property (strong, nonatomic) UIViewController * presentedPopover;

@property (nonatomic) EmptyTableBackroundView * emptyTableBackgroundView;

@end

@implementation FiltrofyTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(EmptyTableBackroundView *)emptyTableBackgroundView
{
    if (!_emptyTableBackgroundView)
    {
        _emptyTableBackgroundView  = [[EmptyTableBackroundView alloc] initWithFrame: self.tableView.frame];
    }
    return _emptyTableBackgroundView;
}

-(void)setFetchedRemoteData:(NSArray *)fetchedRemoteData {
    _fetchedRemoteData = fetchedRemoteData;
    [self.tableView reloadData];
    
    if (_fetchedRemoteData.count == 0) {
        self.tableView.backgroundView = self.emptyTableBackgroundView;
        [self.emptyTableBackgroundView stopLoading:kEmptyTableText];
        [self.emptyTableBackgroundView setHidden:NO];
    } else {
        [self.tableView.backgroundView setHidden:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // TODO: let this be defined by the user
    self.tableView.allowsSelection = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.emptyTableBackgroundView startLoading:@"Loading"];
    [self updateFetchedRemoteData];
}

-(void)updateFetchedRemoteData
{
    if (_remoteLoader) {
        [_remoteLoader cancel];
        _remoteLoader = nil;
    }
    
    [self initializeRemoteLoader];
}

-(void)initializeRemoteLoader
{
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // MUST OVERRIDE THIS METHOD
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedRemoteData.count;
}

#pragma mark - filters actions

-(BOOL)checkReachability
{
    if (![[AFNetworkReachabilityManager sharedManager] isReachable]){
        [[[UIAlertView alloc] initWithMessage:OFFLINE_ERROR_ALERT_MESSAGE] show];
        return NO;
    }
    return YES;
}

-(void)configureNavCon:(UINavigationController *)navigationController
{
    [navigationController.navigationBar setTitleTextAttributes: @{ NSForegroundColorAttributeName: [UIColor colorWithHex: COLOR_PATIENT_NAME],
                                                                   NSFontAttributeName: [UIFont fontWithName: FONT_LATO_REGULAR
                                                                                                        size: FONT_SIZE_NAVIGATION_TITLE] }];
    navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

-(void)displayFilterViewWithSender:(UIView *)sender andFilterVC:(UIViewController<XLFormRowDescriptorViewController> *)controller andValue:(NSString *)value
{
    controller.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:nil
                                                                     rowType:XLFormRowDescriptorTypeSelectorPush];
    // ask each vc for its row descriptor value
    controller.rowDescriptor.value = value;
    
    [self dismissPresentedPopovers];
    
    UINavigationController* navigationController = [[OrchidNavigationController alloc] initWithRootViewController:controller];
    [self configureNavCon:navigationController];
    
    self.presentedPop = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    self.presentedPop.delegate = self;
    
    [self.presentedPop presentPopoverFromRect:[self.tabBarController.view convertRect:sender.bounds
                                                                             fromView:sender]
                                       inView:self.tabBarController.view
                     permittedArrowDirections:UIPopoverArrowDirectionUp
                                     animated:YES];
}

-(void)dismissPresentedPopovers
{
    [self.presentedPop dismissPopoverAnimated:YES];
}

-(void)updateFilterText:(UIButton *)button andValue:(NSString *)value orDefault:(NSString *)defaultValue
{
    NSString * filtertext = [NSString stringWithFormat:@"%@   ▾", value>0 ? value : defaultValue];
    [button setTitle:filtertext forState:UIControlStateNormal];
}

#pragma mark - FilterDelegate

-(void)didChangeFilter:(FilterTableViewController *)filterTableController
{
    // Do here whatever you want with the filter changed
}

-(void)changeFilterSetup
{
    [self dismissPresentedPopovers];
    [self.emptyTableBackgroundView startLoading:@"Loading"];
    [self updateFetchedRemoteData];
}

@end

