//
//  iReflectIAPTableViewController.m
//  iReflect
//
//  Created by Shveta Puri on 8/26/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectIAPTableViewController.h"
#import "iReflectIAPHelper.h"
#import "iReflectAppDelegate.h"

#import <StoreKit/StoreKit.h>

@interface iReflectIAPTableViewController () {
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;

}
@end

@interface iReflectIAPTableViewController ()
@property (strong, nonatomic) iReflectAppDelegate *appDelegate;
@property (strong,nonatomic) NSString *productTitle;
@end

@implementation iReflectIAPTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.appDelegate = (iReflectAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    self.title = @"Purchase Reflections";
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];

}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)restoreTapped:(id)sender {
    [[iReflectIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
  
    
    
      //install product and reload tableview cells to show checkmark
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            
            //install plist ??
            //check if plist is local if not then download from apple server ??
            [self.appDelegate loadDataFromPropertyList:product.localizedTitle];
            
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
//    else {
//        [_purchasedProductIdentifiers addObject:productIdentifier];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    }
     
        
    }];
    
}





//[[NSUserDefaults standardUserDefaults] setBool:YES ForKey:@"isPurchased"];
//In the viewDidLoad of the class, write like:
//
//if([[NSUserDefaults standardUserDefaults] boolForKey:@"isPurchased"])
//{
//    //Enable/show the button
//}
//else
//{
//    //disable/hide button
//}

// 4
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[iReflectIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text = product.localizedTitle;
    self.productTitle = product.localizedTitle;

    [_priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    if ([[iReflectIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else {
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    NSString *text = product.localizedTitle;
    
    if(text) {
    UIFont *font = [self fontForCell];
    CGSize size = [self getSizeOfText:text withFont:font];
    
    //set height for textview too
    //    CGRect frame = self.quoteOut.frame;
    //    frame.size=size;
    //    self.quoteOut.frame = frame;
    
    return (size.height+50); // I put some padding on it.
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
}

- (UIFont *)fontForCell
{
    return [UIFont systemFontOfSize:14];
}

- (CGSize)getSizeOfText:(NSString *)text withFont:(UIFont *)font
{
    return [text sizeWithFont:font constrainedToSize:CGSizeMake(280.0f, MAXFLOAT) ];
}


- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[iReflectIAPHelper sharedInstance] buyProduct:product];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
