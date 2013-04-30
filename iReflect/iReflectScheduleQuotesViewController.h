//
//  AddQuoteViewController.h
//  iReflect
//
//  Created by Shveta Puri on 1/4/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iReflectScheduleQuotesViewController;
@protocol addDelegate<NSObject>
@end

@interface iReflectScheduleQuotesViewController : UITableViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    id <addDelegate> delegate;
}

@property (nonatomic,assign) id <addDelegate> delegate;

@property (strong, nonatomic) IBOutlet UISegmentedControl *intervalPicker;

@property(strong,nonatomic) IBOutlet UIPickerView *startTimePicker;
@property(strong,nonatomic) IBOutlet UIPickerView *endTimePicker;

@property (strong,nonatomic) NSArray *arrayNumbers;
@property (strong,nonatomic) NSArray *ampm;

@property(nonatomic) NSNumber *startTime;
@property(nonatomic) NSNumber *endTime;
@property(strong,nonatomic) NSString *startampm;
@property(strong,nonatomic) NSString *endampm;


@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (strong,nonatomic) NSMutableArray *selectedCategoryArray;
@property (strong,nonatomic) NSMutableArray *selectedCategoryObjects;

@property (weak,nonatomic) NSString *selectedCategory;

@property (weak, nonatomic) IBOutlet UILabel *dashLabel;
@property (weak, nonatomic) IBOutlet UILabel *FromLabel;
@property (weak, nonatomic) IBOutlet UILabel *ToLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@end
