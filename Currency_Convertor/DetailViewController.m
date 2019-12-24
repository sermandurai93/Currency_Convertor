//
//  DetailViewController.m
//  Currency_Convertor
//
//  Created by Sermandurai Subbiah on 02/08/18.
//  Copyright © 2018 Sermandurai Subbiah. All rights reserved.
//

#import "DetailViewController.h"
#import "CCBaseModel.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong)NSArray *countryDetail;
@property (nonatomic, strong)NSDictionary *cuntryCurrencyValue;
@property CCBaseModel *baseModel;
@property (nonatomic, readonly) NSArray *searchResults;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _countryDetail = [NSArray arrayWithObjects:@"AUD",@"BGN",@"BRL",@"CAD",@"CHF",@"CNY",@"CZK",@"DKK",@"EUR",@"GBP",@"HKD",@"HRK",@"HUF",@"IDR",@"ILS",@"INR",@"ISK",@"JPY",@"KRW",@"MXN",@"MYR",@"NOK",@"NZD",@"PHP",@"PLN",@"RON",@"RUB",@"SEK",@"SGD",@"THB",@"TRY",@"USD",@"ZAR",nil];
    [self responseFromModel:[[NSUserDefaults standardUserDefaults] valueForKey:@"response"]];
    
}

-(void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickOnBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchResults.count || self.searchString.length) {
        return _searchResults.count;
    }
    return _countryDetail.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"courencyDetailCell"];
    if (self.searchResults.count) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", [self convervalue:[self.searchResults objectAtIndex:indexPath.row]]];
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self.searchResults objectAtIndex:indexPath.row]];
    } else {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", [self convervalue:[_countryDetail objectAtIndex:indexPath.row]]];
    cell.textLabel.text = [_countryDetail objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[_countryDetail objectAtIndex:indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchString = searchText;
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    _searchResults = [self.countryDetail filteredArrayUsingPredicate:resultPredicate];
    [self.tableView reloadData];
}

- (double)convervalue:(NSString *)curntryValue {
    if (curntryValue.length == 0) {
        return 0;
    }
    NSString *singleCurrencyValue = [NSString stringWithFormat:@"%@", _cuntryCurrencyValue[curntryValue]];
    double intSingleCurrencyValue = [singleCurrencyValue doubleValue];
    double userValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userValue"]doubleValue];
    return intSingleCurrencyValue * userValue;
}

- (void)responseFromModel:(NSDictionary *)response {
    self.baseModel = [[CCBaseModel alloc] init];
    self.baseModel.base = response[@"base"];
    self.baseModel.date = response[@"date"];
    self.baseModel.rates = response[@"rates"];
    _cuntryCurrencyValue = response[@"rates"];
}
@end
