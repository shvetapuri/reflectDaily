//
//  iReflectAddQuoteViewController.h
//  iReflect
//
//  Created by Shveta Puri on 2/2/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iReflectAddQuoteViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *quoteInput;
@property (weak, nonatomic) IBOutlet UITextView *quoteInput;
@property (weak, nonatomic) IBOutlet UITextView *authorInput;
//@property (weak, nonatomic) IBOutlet UITextField *authorInput;
@property (weak,nonatomic) NSString *category;

@property (weak,nonatomic) NSString *quoteTextfieldString;
@property (weak,nonatomic) NSString *authorTextfieldString;
@property (nonatomic) BOOL *editQuote;


@end
