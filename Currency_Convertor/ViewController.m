//
//  ViewController.m
//  Currency_Convertor
//
//  Created by Sermandurai Subbiah on 12/07/18.
//  Copyright © 2018 Sermandurai Subbiah. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import "CCBaseModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userCurrencyValue;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) CCBaseModel *baseModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)networkCall {
    NSURL *url = [NSURL URLWithString:@"https://exchangeratesapi.io/api/latest?base=INR"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSLog(@"%@",response);
            NSError *jsonerror = nil;
            [self getresponse:[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonerror]];
            [[NSUserDefaults standardUserDefaults] setObject:[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonerror] forKey:@"response"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forKey:@"lastUpdateTimestamp"];
            [self updateUI];
        }
    }];
    [dataTask resume];
}

- (void)getresponse:(NSDictionary *)response {
    self.baseModel = [[CCBaseModel alloc] init];
    self.baseModel.base = response[@"base"];
    self.baseModel.date = response[@"date"];
    self.baseModel.rates = response[@"rates"];
}


- (IBAction)clickResult:(id)sender {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self.userCurrencyValue.text];
    if (self.userCurrencyValue.text.length < 1) {
        NSLog(@"Please Enter the Value");
    } else if (![alphaNums isSupersetOfSet:inStringSet]) {
        NSLog(@"Please Enter the Only Numbers");
    } else if ([self.userCurrencyValue.text doubleValue] < 0) {
        NSLog(@"Please Enter the value grater then zero");
    }else  {
        [self currencyConveter];
    }
}

- (void)currencyConveter {
    NSString *now = [NSString stringWithFormat:@"%@", [NSDate date]];
    NSString *lastUpdateTimestamp = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdateTimestamp"];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"response"] == nil){
        [self networkCall];
        return;
    } else if ([[NSDate date] timeIntervalSince1970] - [lastUpdateTimestamp integerValue] >= 86400) {
        [self networkCall];
    } else if (![now containsString:self.baseModel.date]) { //1day = 24h, 1440M, 86400S
        [self networkCall];
    } else {
        [self getresponse:[[NSUserDefaults standardUserDefaults] valueForKey:@"response"]];
    }
    
    [self updateUI];
}

- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        double singleCurrencyValue = [self.baseModel.rates[@"USD"] doubleValue];
        double userValue = [self->_userCurrencyValue.text doubleValue];
        double totalValue = singleCurrencyValue * userValue;
        self.resultLabel.numberOfLines = 0;
        self.resultLabel.text = [NSString stringWithFormat:@"Base - %@ \n Date - %@ \n 1 INR in USD - %@ \n Total USD = %f ", self.baseModel.base, self.baseModel.date, self.baseModel.rates[@"USD"],totalValue ];
    });
}

@end
