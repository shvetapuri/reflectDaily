//
//  iReflectCategorySelectViewController.m
//  iReflect
//
//  Created by Shveta Puri on 3/31/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectCategorySelectViewController.h"
#import "iReflectScheduleQuotesViewController.h"

@interface iReflectCategorySelectViewController ()

@end

@implementation iReflectCategorySelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.selectedRows = [[NSMutableDictionary alloc] init];
    
 //   [self initRowsWithcheckmarks];
    
   // self.selectedCategoryArray = ((iReflectScheduleQuotesViewController *) self.parentViewController).selectedCategoryArray;
    
    //[self.categoryArray insertObject:@"all" atIndex:0];
    
   // self.tableView.allowsMultipleSelection = YES;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidUnload {
    self.selectedRows = nil;
    
 //   ((iReflectScheduleQuotesViewController *) self.parentViewController).selectedCategoryArray=self.selectedCategoryArray;
   
    
   //[ self.parentViewController selectedCategoryArray ]= self.selectedCategoryArray;
    
    [super viewDidUnload];
}

//- (void)viewWillDisappear:(BOOL)animated {
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
[self configureCell:cell atIndexPath:indexPath];

    NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];

    if ( [self.selectedRows objectForKey:keyString]  || [self.selectedRows objectForKey:@"all"] || [self.selectedCategoryArray containsObject:[self.categoryArray objectAtIndex:indexPath.row]] || [self.selectedCategoryArray containsObject:@"all"])
    {
                
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

    cell.textLabel.text=[self.categoryArray objectAtIndex:indexPath.row];
   
}


-(void)checkmarkAllRows:(UITableView *)tableView
{
    for (int j = 0; j < [self.categoryArray count]; j++) {
        
        int i = 0;
        NSUInteger ints[2]={i,j};
        
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
    

}

-(void)uncheckAllRows:(UITableView *)tableView
{
    for (int j = 0; j < [self.categoryArray count]; j++) {
        int i = 0;
        NSUInteger ints[2]={i,j};
        
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];
    
    //if no checkmark
    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
        
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //if all is selected then add checkmarks to all other categories

        if([[self.categoryArray objectAtIndex:indexPath.row] isEqualToString:@"all"]) {
            
            [self checkmarkAllRows:tableView];
            
            [self.selectedRows removeAllObjects];
            [self.selectedCategoryArray removeAllObjects];
            
            [self.selectedCategoryArray insertObject:@"all" atIndex:0];
            [self.selectedRows setObject:@"all" forKey:@"all"];
            
        } else {
            
            NSString *categoryInRow = thisCell.textLabel.text;
            [self.selectedRows setObject:categoryInRow forKey:keyString];
            //add object in an array
            //if row selected, save in selectedCategories
            [self.selectedCategoryArray addObject:[self.categoryArray objectAtIndex:indexPath.row]];
        }
    }
    //else if checkmark
   else
       
   {
       if([[self.categoryArray objectAtIndex:indexPath.row] isEqualToString:@"all"]) {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        
        [self uncheckAllRows:tableView];
        [self.selectedRows removeAllObjects];
        [self.selectedCategoryArray removeAllObjects];
        
        
        //if you select a row with a checkmark and the all row is not selected deselect
    } else if (![[self.selectedCategoryArray objectAtIndex:0] isEqualToString:@"all"]) {
        
        
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedRows removeObjectForKey:keyString];
        //remove the object at the index from array
        [self.selectedCategoryArray removeObject:[self.categoryArray objectAtIndex:indexPath.row]];
        
        
        //if you select a row with a checkmark and the "all" row is selected then deselect all except the row you selected
    } else if([[self.selectedCategoryArray objectAtIndex:0] isEqualToString:@"all"]){
        
        [self uncheckAllRows:tableView];
        [self.selectedRows removeAllObjects];
        [self.selectedCategoryArray removeAllObjects];
        
        //select only the current row
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        NSString *categoryInRow = thisCell.textLabel.text;
        [self.selectedRows setObject:categoryInRow forKey:keyString];
        //add object in an array
        //if row selected, save in selectedCategories
        [self.selectedCategoryArray addObject:[self.categoryArray objectAtIndex:indexPath.row]];

        
        
    }
   }
    //[tableView reloadData];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
//    //thisCell.accessoryView.hidden = YES;
//    
//    //thisCell.accessoryType = UITableViewCellAccessoryNone;
//    //NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];
//
//    
// 
//}



@end
