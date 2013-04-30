//
//  iReflectEditQuoteViewController.h
//  iReflect
//
//  Created by Shveta Puri on 4/19/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iReflectEditQuoteViewController : UITableViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *quoteInput;
@property (weak, nonatomic) IBOutlet UITextView *authorInput;
@property (weak,nonatomic) NSString *category;

@property (weak,nonatomic) NSString *quoteTextfieldString;
@property (weak,nonatomic) NSString *authorTextfieldString;



@end
