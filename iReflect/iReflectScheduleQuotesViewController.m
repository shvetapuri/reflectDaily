//
//  AddQuoteViewController.m
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectScheduleQuotesViewController.h"
#import "iReflectCategorySelectViewController.h"

@interface iReflectScheduleQuotesViewController ()

@end


@implementation iReflectScheduleQuotesViewController
@synthesize intervalPicker=_intervalPicker;
@synthesize datePicker=_datePicker;
@synthesize delegate = _delegate;

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

    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.navigationItem.title;
    // emboss so that the label looks OK
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;
    
    
    self.instructionsLabel.text=@"Select time to see daily quote";
    
    [self.intervalPicker addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.arrayNumbers = @[[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:2], [NSNumber numberWithInteger:3],[NSNumber numberWithInteger:4],[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:6],[NSNumber numberWithInteger:7],[NSNumber numberWithInteger:8],[NSNumber numberWithInteger:9],[NSNumber numberWithInteger:10],[NSNumber numberWithInteger:11],[NSNumber numberWithInteger:12]];
    self.ampm = @[@"AM",@"PM"];

    
    [self.startTimePicker selectRow:11 inComponent:0 animated:YES];
     [self.startTimePicker selectRow:1 inComponent:1 animated:YES];
     [self.endTimePicker selectRow:5 inComponent:0 animated:YES];
     [self.endTimePicker selectRow:1 inComponent:1 animated:YES];
    

    
    //set default  values
    
    self.startampm=@"PM";
    self.startTime=[NSNumber numberWithInteger:12];
    
    self.endampm=@"PM";
    self.endTime=[NSNumber numberWithInteger:6];
    
    
    self.startTimePicker.tag=100;
    self.endTimePicker.tag=200;
    
    self.datePicker.tag=300;
    
    self.endTimeArray = [self getEndTimeArrays];

    
  //  self.pickerView.transform = CGAffineTransformMakeScale(.9,.9);
    
 //   self.pickerView.frame = CGRectMake(0, 0, 320, 100);
    //self.datePicker.transform = CGAffineTransformMakeScale(.9,.9);
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    self.randomPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 380, 320, 200)];
//    self.randomPicker.delegate = self;
//    self.randomPicker.showsSelectionIndicator = YES;
//    [self.view addSubview:self.randomPicker];
//    [self.randomPicker setHidden:YES];
    
    
//    self.startTimePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 350, 140, 200)];
//    self.startTimePicker.delegate = self;
//    self.startTimePicker.showsSelectionIndicator = YES;
//    [self.view addSubview:self.startTimePicker];
//    [self.startTimePicker setHidden:YES];
    
//    self.startTimePickerLabel = [[UILabel alloc] init];
//    self.startTimePickerLabel.frame = CGRectMake(10, 320, 300, 40);
//    self.startTimePickerLabel.backgroundColor = [UIColor clearColor];
//    self.startTimePickerLabel.textColor = [UIColor blackColor];
//    self.startTimePickerLabel.font = [UIFont fontWithName:@"Verdana-Bold" size: 20.0];
//    self.startTimePickerLabel.textAlignment = NSTextAlignmentLeft;
//    self.startTimePickerLabel.text = @"Start time:";
//    [self.view addSubview:self.startTimePickerLabel];
//    [self.startTimePickerLabel setHidden:YES];
    
//    self.endTimePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 350, 140, 200)];
//    self.endTimePicker.delegate = self;
//    self.endTimePicker.showsSelectionIndicator = YES;
//    [self.view addSubview:self.endTimePicker];
//    [self.endTimePicker setHidden:YES];
    
    //self.randomPicker = myPickerView;
    
}


-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)aSegmentedControl {
    
    NSUInteger index = aSegmentedControl.selectedSegmentIndex;
    
   // UIViewController *newViewController = nil;
    if(index ==0) { //show set time
        [self.datePicker setHidden:NO ];
    //    [self.randomPicker setHidden:YES];
        
        [self.FromLabel setHidden:YES];
        [self.ToLabel setHidden:YES];
        [self.dashLabel setHidden:YES];
        [self.startTimePicker setHidden:YES];
        [self.endTimePicker setHidden:YES];
        self.instructionsLabel.text=@"Select time to see daily quote";
        
        //[self.startTimePickerLabel setHidden:YES];
    } else { //random Time
        [self.datePicker setHidden:YES];
    //    [self.randomPicker setHidden:NO];
        [self.FromLabel setHidden:NO];
        [self.ToLabel setHidden:NO];
        [self.dashLabel setHidden:NO];
        [self.startTimePicker setHidden:NO];
        [self.endTimePicker setHidden:NO];
        
        self.instructionsLabel.text=@"Select 24 hour time window for random daily quote";
      //  [self.startTimePickerLabel setHidden:NO];
    }
 
    
}

//- (IBAction)done:(UIStoryboardSegue *)segue {
//  
//    
//    iReflectCategorySelectViewController  *cc = [segue sourceViewController];
//    self.selectedCategoryArray=cc.selectedCategoryArray;
//   // [self selectedCategoryArray:[cc selectedCategoryArray]];
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"selectCategory"]) {
    
        
        iReflectCategorySelectViewController *sel= [segue destinationViewController];
      //  sel.categoryArray= [[NSMutableArray alloc] init];
        
        sel.categoryArray=self.categoryArray;
        
      //  sel.selectedCategoryArray = [[NSMutableArray alloc] init];
                
    //self.selectedCategoryArray=sel.selectedCategoryArray ;
        
        sel.selectedCategoryArray = self.selectedCategoryArray;
   // sel.selectedCategoryArray = [[NSMutableArray alloc] initWithArray:self.selectedCategoryArray copyItems:YES];
        
    }
}

//PickerViewController.m
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {

    if(thePickerView.tag==300) {
        return 1;
       
    } else {
     return 2;
    }
    
}

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    //if end time picker
    if (thePickerView.tag==200) {
        
        if (component==0){
            return [[self.endTimeArray objectAtIndex:0] count];
            
        } else {
            return [[self.endTimeArray objectAtIndex:1] count];
        }
    }
    
        if (component==0){
            return 12;
            
        } else {
            return 2;
        }
     
    
}

//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
        //if end time
        if (thePickerView.tag==200) {
            
          self.endTimeArray= [self getEndTimeArrays];
            
                if (component==0) {
                    
                    return [[[self.endTimeArray objectAtIndex:0] objectAtIndex:row] stringValue];

                }
                else {
                    return [[self.endTimeArray objectAtIndex:1] objectAtIndex:row];
                }
            
            


            }
    
        else if (component==0){
            return [[self.arrayNumbers objectAtIndex:row] stringValue];
        }
        else {
            
            return [self.ampm objectAtIndex:row];
            
            
        }
}

-(NSArray *) getEndTimeArrays {
    
    
    //find out 24 hour start time
    int startTime24hr = [self convertTo24hr:self.startTime ampm:self.startampm];
    
    NSLog(@"in getendtimearrays %d",startTime24hr);

    
    NSMutableArray *endTimeArray=[[NSMutableArray alloc] init] ;
    NSMutableArray *endAMPM=[[NSMutableArray alloc] init];
    
    for(int i=(startTime24hr+1);i<=24;i++) {
        //convert 24hr end time array to 12hr
        
        NSDictionary *convertedTime = [[NSDictionary alloc] initWithDictionary:[self convertTo12hr:i]];
        
        [endTimeArray addObject:[convertedTime objectForKey:@"time"]];
        [endAMPM addObject:[convertedTime objectForKey:@"ampm"]];
        
        NSLog(@"time: %@  ampm: %@", [convertedTime objectForKey:@"time"], [convertedTime objectForKey:@"ampm"] );
    }
    //save last row
//    NSString *lastAmpm = [endAMPM lastObject];
//    int lastAmpmIndex;
//
    
    
    
    NSMutableArray *endAMPMArray=[[NSMutableArray alloc] init];

    
    if([endAMPM containsObject:@"AM"]) {
        [endAMPMArray addObject:@"AM"];
    }
    if([endAMPM containsObject:@"PM"]) {
        [endAMPMArray addObject:@"PM"];
    }
    
    if(startTime24hr==24) {
        endTimeArray= [self.arrayNumbers copy];
        endAMPMArray = [self.ampm copy];
    }
       

return @[endTimeArray, endAMPMArray];
    
    
}

-(NSDictionary *)convertTo12hr:(int)timeToConvert {
    
    NSMutableDictionary *convertedTime=[[NSMutableDictionary alloc] init];
    
    if(timeToConvert <12) {
        [convertedTime setValue:[NSNumber numberWithInt:timeToConvert] forKey:@"time" ];
        [convertedTime setValue:@"AM" forKey:@"ampm"];
    } else if(timeToConvert==12) {
        [convertedTime setValue:[NSNumber numberWithInt:timeToConvert] forKey:@"time" ];
        [convertedTime setValue:@"PM" forKey:@"ampm"];
    } else if((timeToConvert-12)==12) {
        [convertedTime setValue:[NSNumber numberWithInt:(timeToConvert-12)] forKey:@"time" ];
        [convertedTime setValue:@"AM" forKey:@"ampm"];
    } else {
        [convertedTime setValue:[NSNumber numberWithInt:(timeToConvert-12)] forKey:@"time"];
        [convertedTime setValue:@"PM" forKey:@"ampm"];
    }
return convertedTime;
}

-(int)convertTo24hr:(NSNumber *)time ampm:(NSString *)ampm {
    
    int time24hr;
    
    if([ampm isEqualToString:@"PM"]){
        if([time intValue] == 12){
            
            time24hr=[time intValue];
            
        } else {
            time24hr=[time intValue] + 12 ;
        }
        
    } else {
        if([time intValue] == 12){
            time24hr=[time intValue] + 12 ;
        } else {
            time24hr=[time intValue];
        }
        
    }
    
    
    return time24hr;
}

//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   // NSLog(@"Selected Color: %@. Index of selected color: %i",
    
   // [thePickerView isEqual:self.startTimePicker]

    
    if(thePickerView.tag==100) {
        

        if (component==0){
            self.startTime=[self.arrayNumbers objectAtIndex:row];
             NSLog(@"in start picker %@",self.startTime);
        } else {
            self.startampm=[self.ampm objectAtIndex:row];
             NSLog(@"in am pm %@",self.startampm);
        }
        
        self.endTimeArray= [self getEndTimeArrays];
        [self.endTimePicker reloadAllComponents];

        
     }
    if (thePickerView.tag==200) {
         if (component==0) {
             self.endTime=[[self.endTimeArray objectAtIndex:0] objectAtIndex:row];
            
         } else {
             self.endampm=[[self.endTimeArray objectAtIndex:1] objectAtIndex:row];
         }
         
     }
    
    if(thePickerView.tag != 300) {
    //check that start time is less than end time otherwise set the font of the end time to red
    if([self compareEndStartTimes] ==0) {
        //end time is before start time
        self.instructionsLabel.textColor=[UIColor redColor];
        self.instructionsLabel.text=@"Start time must be before the end time";

    } else {
        self.instructionsLabel.textColor=[UIColor darkGrayColor];
        self.instructionsLabel.text=@"Select 24 hour time window for random daily quote";

    }
    }
    
}

-(BOOL)compareEndStartTimes {
 
    int startTime24hr = [self convertTo24hr:self.startTime ampm:self.startampm];
    int endTime24hr = [self convertTo24hr:self.endTime ampm:self.endampm];
    
    if(endTime24hr<=startTime24hr) {
        return 0;
    } else {
        return 1;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) textFieldShouldReturn:(UITextField *) textField {
    //if(textField == self.quoteInput){
        [textField resignFirstResponder];
   // }
    return YES;
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([self.selectedCategoryArray count]) {
        cell.detailTextLabel.text=@"selected";
    } else {
        cell.detailTextLabel.text=@"none selected";

    }
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"BasicCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        
//    }
//    
//   // [self configureCell:cell atIndexPath:indexPath];
//    
//    return cell;
//   
//}
//
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    
//    cell.detailTextLabel.text=@"he";
//    
//}





//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"BasicCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]  ;
//    }
//   // [self configureCell:cell atIndexPath:indexPath];
//    NSString *selectedCategories;
//    
//    if([self.selectedCategoryArray count]) {
//        selectedCategories = [self.selectedCategoryArray componentsJoinedByString:@","];
//        
//    } else {
//        selectedCategories =@"none";
//    }
//    
//    cell.detailTextLabel.text = selectedCategories ;
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
