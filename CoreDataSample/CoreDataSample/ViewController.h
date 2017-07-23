//
//  ViewController.h
//  CoreDataSample
//
//  Created by Dilip Kosuri on 21/7/17.
//  Copyright © 2017 Dilip Kosuri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *bookTitleValue;
@property (weak, nonatomic) IBOutlet UITextField *authorValue;
@property (weak, nonatomic) IBOutlet UITextField *yearPublishedValue;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsInStore;
- (IBAction)addToStoreBtn:(id)sender;
- (IBAction)deleteAllFromStoreValue:(id)sender;
@property (strong) NSMutableArray *devices;

@property (weak, nonatomic) IBOutlet UILabel *showDataLabel;

@end

