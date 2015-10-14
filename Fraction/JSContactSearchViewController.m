//
//  JSContactSearchViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/8/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSContactSearchViewController.h"

#import <RHAddressBook/AddressBook.h>

@interface JSContactSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) RHAddressBook *addressBook;
@property (strong, nonatomic) NSArray       *peopleArray;
@property (strong, nonatomic) NSArray       *searchResultArray;

@property (weak, nonatomic) IBOutlet UISearchBar *seachBar;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JSContactSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAdressBook];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Address Book

- (void)setUpAdressBook{
    
    self.addressBook = [[RHAddressBook alloc]init];
    
    if ([RHAddressBook authorizationStatus] != RHAuthorizationStatusAuthorized ){
        
        [self.addressBook  requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
            
            [self fethAddressBook];
        }];
        
        //get notification when there is a change to the addressBook
        [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(addressBookChanged) name:RHAddressBookExternalChangeNotification object:nil];
    }
}

- (void)addressBookChanged{
    
    [self fethAddressBook];
}

- (void)fethAddressBook{
   
    [self setAddressBook:self.addressBook];
    
    NSArray *addressBookToSort              = [self.addressBook people];
    NSMutableArray *personWithPhoneNumbers  = [[NSMutableArray alloc]init];
    
    for (RHPerson *person in addressBookToSort) {
        
        if (person.phoneNumbers.count > 1) {
            [personWithPhoneNumbers addObject:person];
        }
    }
    
    [self.peopleArray arrayByAddingObjectsFromArray:personWithPhoneNumbers];
}


#pragma mark TableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = @"searchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
    
        cell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    RHPerson *person = self.searchResultArray[indexPath.row ];
    
    cell.textLabel.text         = person.name;
    
    
    RHMultiStringValue *phonesMultiValue = [person phoneNumbers];
    
    
    if
    NSString *phoneNumber =  [phonesMultiValue valueForKey:RHPersonPhoneIPhoneLabel];
    NSString *phoneNumbers  = [person.phoneNumbers valueAtIndex:0];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.peopleArray count];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
