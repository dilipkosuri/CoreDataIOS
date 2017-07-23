  //
  //  ViewController.m
  //  CoreDataSample
  //
  //  Created by Dilip Kosuri on 21/7/17.
  //  Copyright © 2017 Dilip Kosuri. All rights reserved.
  //

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize authorValue,bookTitleValue,yearPublishedValue,showDataLabel, numberOfItemsInStore;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self saveTheValuesToLabel];
}


- (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  if ([delegate performSelector:@selector(managedObjectContext)]) {
    context = [delegate managedObjectContext];
  }
  return context;
}


- (IBAction)addToStoreBtn:(id)sender {
  
  AppDelegate *appDelegate =
  [[UIApplication sharedApplication] delegate];
  
  NSManagedObjectContext *context =
  [appDelegate managedObjectContext];
  NSManagedObject *newContact;
  newContact = [NSEntityDescription
                insertNewObjectForEntityForName:@"BookStore"
                inManagedObjectContext:context];
  [newContact setValue: authorValue.text forKey:@"author"];
  [newContact setValue: bookTitleValue.text forKey:@"title"];
  [newContact setValue: yearPublishedValue.text forKey:@"year"];
  authorValue.text = @"";
  bookTitleValue.text = @"";
  yearPublishedValue.text = @"";
  NSError *error;
  [context save:&error];

  [self dismissViewControllerAnimated:YES completion:nil];
  
  [self saveTheValuesToLabel];
}

- (void)saveTheValuesToLabel {
  
  AppDelegate *appDelegate =
  [[UIApplication sharedApplication] delegate];
  
  
  NSManagedObjectContext *contx = [appDelegate managedObjectContext];
  
  NSEntityDescription *entityDesc =
  [NSEntityDescription entityForName:@"BookStore"
              inManagedObjectContext:contx];
  
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDesc];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
  [request setPredicate:predicate];
  NSManagedObject *matches = nil;
  NSError *error;
  NSArray *objects = [contx executeFetchRequest:request
                                            error:&error];
  NSMutableString *buffer = [NSMutableString stringWithString:@""];
  
  numberOfItemsInStore.text = [NSString stringWithFormat:
       @"%lu", (unsigned long)[objects count]];
  if ([objects count] == 0) {
    numberOfItemsInStore.text = @"No matches";
  } else {
    for (matches in objects) {
      NSLog(@"Author: %*c%@, Title: %*c%@, Year Published: %*c%@",2, ' ', [matches valueForKey:@"author"], 2, ' ', [matches valueForKey:@"title"], 2, ' ', [matches valueForKey:@"year"]);
      [buffer appendFormat:@"Title: %*c%@, Author: %*c%@, Year Published: %*c%@",2, ' ', [matches valueForKey:@"title"], 2, ' ', [matches valueForKey:@"author"], 2, ' ', [matches valueForKey:@"year"], nil];
        showDataLabel.text = buffer;

    }
  }
}


- (IBAction)deleteAllFromStoreValue:(id)sender {
  AppDelegate *appDelegate =
  [[UIApplication sharedApplication] delegate];
  NSManagedObjectContext *contx = [appDelegate managedObjectContext];
  
  NSEntityDescription *entityDesc =
  [NSEntityDescription entityForName:@"BookStore"
              inManagedObjectContext:contx];
  
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDesc];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
  [request setPredicate:predicate];
  NSManagedObject *matches = nil;
  NSError *error;
  NSArray *objects = [contx executeFetchRequest:request
                                          error:&error];
  if ([objects count] > 0) {
    for (matches in objects) {
      [contx deleteObject:matches];
      
    }
  }
  
   [contx save:&error];
  NSArray *getDataCount = [contx executeFetchRequest:request
                                          error:&error];
  if ([getDataCount count] == 0) {
    showDataLabel.text = @"No Data Available";
    numberOfItemsInStore.text = [NSString stringWithFormat:
                                 @"%lu", (unsigned long)[getDataCount count]];
  }
  
}
@end
