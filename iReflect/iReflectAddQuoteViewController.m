//
//  iReflectAddQuoteViewController.m
//  iReflect
//
//  Created by Shveta Puri on 2/2/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iReflectAddQuoteViewController.h"
#import "Quote.h"

@interface iReflectAddQuoteViewController ()

@end

@implementation iReflectAddQuoteViewController

@synthesize quoteInput=_quoteInput;
@synthesize authorInput =_authorInput;
@synthesize category=_category;

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
    self.title = self.category;
    self.quoteInput.text=self.quoteTextfieldString;
    self.authorInput.text = self.authorTextfieldString;

//    if(!self.quoteTextfieldString) {
//        self.quoteInput.text=@"Quote";
//        self.quoteInput.textColor = [UIColor lightGrayColor];
//    
//        self.authorInput.text=@"Author";
//        self.authorInput.textColor = [UIColor lightGrayColor];
//    }
    
   // UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 220, 200, 100)];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.quoteInput.layer.cornerRadius = 5;
    self.quoteInput.clipsToBounds = YES;
    [self.quoteInput.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.quoteInput.layer setBorderWidth:2.0];
    
    
    self.authorInput.layer.cornerRadius = 5;
    self.authorInput.clipsToBounds = YES;
    [self.authorInput.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.authorInput.layer setBorderWidth:2.0];
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
//{
//    if(!self.quoteTextfieldString) {
//    if(textView.tag==1) {
//        self.quoteInput.text = @"";
//        self.quoteInput.textColor = [UIColor blackColor];
//    } else {
//        self.authorInput.text=@"";
//        self.authorInput.textColor = [UIColor blackColor];
//
//    }
//    }
//    return YES;
//}
//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(!self.quoteTextfieldString) {
//    
//    if(self.quoteInput.text.length == 0){
//        self.quoteInput.textColor = [UIColor lightGrayColor];
//        self.quoteInput.text = @"Quote";
//    }
//    if(self.authorInput.text.length==0) {
//        self.authorInput.textColor = [UIColor lightGrayColor];
//        self.authorInput.text = @"Author";
//
//    }
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textViewShouldReturn:(UITextView *) textView {
    if(textView == self.quoteInput){
        [textView resignFirstResponder];
    }
    return YES;
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        if ([self.quoteInput.text length]) {
               
        }
    }
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}




@end
