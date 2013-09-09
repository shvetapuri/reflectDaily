//
//  iReflectIAPHelper.m
//  iReflect
//
//  Created by Shveta Puri on 8/26/13.
//  Copyright (c) 2013 Shveta Puri. All rights reserved.
//

#import "iReflectIAPHelper.h"

@implementation iReflectIAPHelper

+(iReflectIAPHelper *)sharedInstance{
    static dispatch_once_t once;
    static iReflectIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects://replace with REAL
                                      @"com.gotothere.iReflect_famousQuotesBundle",
                                      @"com.gotothere.iReflect_funnyQuotes",
                                      @"com.gotothere.iReflect_appleServerTest",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

//
//// InAppPurchaseManager.m
//- (void)requestProUpgradeProductData
//{
//    NSSet *productIdentifiers = [NSSet setWithObject:@"com.runmonster.runmonsterfree.upgradetopro" ];
//    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
//    productsRequest.delegate = self;
//    [productsRequest start];
//    
//    // we will release the request object in the delegate callback
//}
//
//#pragma mark -
//#pragma mark SKProductsRequestDelegate methods
//
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
//{
//    NSArray *products = response.products;
//    proUpgradeProduct = [products count] == 1 ? [[products firstObject] retain] : nil;
//    if (proUpgradeProduct)
//    {
//        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
//        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
//        NSLog(@"Product price: %@" , proUpgradeProduct.price);
//        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
//    }
//    
//    for (NSString *invalidProductId in response.invalidProductIdentifiers)
//    {
//        NSLog(@"Invalid product id: %@" , invalidProductId);
//    }
//    
//    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
//    [productsRequest release];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
//}


//
//- (void) requestProductData
//{
//    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
//                                 [NSSet setWithObject: kMyFeatureIdentifier]];
//    request.delegate = self;
//    [request start];
//}
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
//{
//    NSArray *myProducts = response.products;
//    // Populate your UI from the products list.
//    // Save a reference to the products list.
//}


@end
