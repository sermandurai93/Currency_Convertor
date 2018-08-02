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

@property (weak, nonatomic) IBOutlet UILabel *baseCountry;
@property (weak, nonatomic) IBOutlet UITextField *userValue;
@property (strong, nonatomic) CCBaseModel *baseModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
  [self currencyConveter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldbegin:(id)sender {
    [self resignFirstResponder];
}

- (void)networkCall {
    NSURL *url = [NSURL URLWithString:@"https://exchangeratesapi.io/api/latest?base=USD"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSLog(@"%@",response);
            NSError *jsonerror = nil;
            [self getresponse:[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonerror]];
            [[NSUserDefaults standardUserDefaults] setObject:[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonerror] forKey:@"response"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forKey:@"lastUpdateTimestamp"];
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

- (void)currencyConveter {
    NSString *now = [NSString stringWithFormat:@"%@", [NSDate date]];
    NSString *lastUpdateTimestamp = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdateTimestamp"];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"response"] == nil){
        [self networkCall];
        return;
    } else if ([[NSDate date] timeIntervalSince1970] - [lastUpdateTimestamp integerValue] >= 86400) {
        [self networkCall];
    } else {
        [self getresponse:[[NSUserDefaults standardUserDefaults] valueForKey:@"response"]];
        if (![now containsString:self.baseModel.date]) { //1day = 24h, 1440M, 86400S
            [self networkCall];
        }
    }
}

- (IBAction)clickConvertCourency:(id)sender {
    if (self.userValue.text.length >0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userValue.text forKey:@"userValue"];
    }
}

#pragma mark - Number Button Click Action

- (IBAction)numberOne:(id)sender {
    if (self.userValue.text.length > 0) {
    self.userValue.text = [NSString stringWithFormat:@"%@1", self.userValue.text];
    } else {
        self.userValue.text = @"1";
    }
}
- (IBAction)numberTwo:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@2", self.userValue.text];
    } else {
        self.userValue.text = @"2";
    }
}
- (IBAction)numberThree:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@3", self.userValue.text];
    } else {
        self.userValue.text = @"3";
    }
}
- (IBAction)numberFour:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@4", self.userValue.text];
    } else {
        self.userValue.text = @"4";
    }
}
- (IBAction)numberFive:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@5", self.userValue.text];
    } else {
        self.userValue.text = @"5";
    }
}
- (IBAction)numberSix:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@6", self.userValue.text];
    } else {
        self.userValue.text = @"6";
    }
}
- (IBAction)numberSeven:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@7", self.userValue.text];
    } else {
        self.userValue.text = @"7";
    }
}
- (IBAction)numberEight:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@8", self.userValue.text];
    } else {
        self.userValue.text = @"8";
    }
}
- (IBAction)numberNine:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@8", self.userValue.text];
    } else {
        self.userValue.text = @"8";
    }
}
- (IBAction)numberZero:(id)sender {
    if (self.userValue.text.length > 0) {
        self.userValue.text = [NSString stringWithFormat:@"%@0", self.userValue.text];
    } else {
        self.userValue.text = @"0";
    }
}
- (IBAction)numberDot:(id)sender {
    if (self.userValue.text.length > 0) {
        if (![self.userValue.text containsString:@"."]){
            self.userValue.text = [NSString stringWithFormat:@"%@.", self.userValue.text];
        }
    } else {
        self.userValue.text = @".";
    }
}
- (IBAction)numberDelete:(id)sender {
    if (self.userValue.text.length > 0) {
        NSString *beforDeleteText = self.userValue.text;
        NSString *afterDeleteText = [beforDeleteText substringToIndex: [beforDeleteText length] - 1];
        self.userValue.text = afterDeleteText;
    }
}



@end
