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

@property (nonatomic, strong)NSArray *countryDetail;
@property (nonatomic, strong)NSDictionary *cuntryCurrencyValue;
@property CCBaseModel *baseModel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _countryDetail = [NSArray arrayWithObjects:@"AUD",@"BGN",@"BRL",@"CAD",@"CHF",@"CNY",@"CZK",@"DKK",@"EUR",@"GBP",@"HKD",@"HRK",@"HUF",@"IDR",@"ILS",@"INR",@"ISK",@"JPY",@"KRW",@"MXN",@"MYR",@"NOK",@"NZD",@"PHP",@"PLN",@"RON",@"RUB",@"SEK",@"SGD",@"THB",@"TRY",@"USD",@"ZAR",nil];
    [self responseFromModel:[[NSUserDefaults standardUserDefaults] valueForKey:@"response"]];
    
    // Do any additional setup after loading the view.
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
    return _countryDetail.count - 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"courencyDetailCell"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", [self convervalue:[_countryDetail objectAtIndex:indexPath.row]]];
    cell.textLabel.text = [_countryDetail objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
