program ATM;
uses crt;

var
userResponse, fullName, phone, accType, password: string;
acctBalance : real;

procedure createAcct; forward;
procedure makeDeposit; forward;
procedure checkAcctDetails; forward;
procedure checkBalance; forward;
procedure makeWithdrawal; forward;
procedure exit_prog; forward;


function isDepositable(virtualPlan : string; proposedAcctBalance: real): boolean;
	var
	 (* local variable declaration *)
	 result: boolean;
	begin

	 if (virtualPlan = 'V-Intant') then result := (proposedAcctBalance >= 500000);
	 if (virtualPlan = 'V-Classic') then result := (proposedAcctBalance >= 1000000);
	 if (virtualPlan = 'V-Pro') then result := (proposedAcctBalance >= 5000000);
	 if (virtualPlan = 'V-Biz') then result := FALSE;


	 isDepositable := result;
end;


procedure displayMenu();
(* Creates a new virtual bank account *)
begin
writeln( ' ');
writeln( '+---------------------------------------------------------+');
writeln( '|__        __                                             |');
writeln( '|\ \      / /  Welcome to Virtual bank. A CLI program to  |');
writeln( '| \ \    / /     that that helps users deposit, withdraw  |');
writeln( '|  \ \__/ /    and also check account details and balance |');
writeln( '|   \____/Bank                                            |');
writeln( '|Created by Tasiu Kwaplong (TK)                           |');
writeln( '+---------------------------------------------------------+');
writeln(fullName);
 writeln('');
 writeln('    Please make a selection');
if fullName = '' then writeln('    c Create account');
if fullName <> '' then writeln('    d Make deposit');
if acctBalance > 0 then writeln('    w Withdraw from account');
if fullName <> '' then writeln('    b Check balance');
if fullName <> '' then writeln('    i Account details');
writeln('    x exit');
writeln('    about');
 
 readln(userResponse);

 case (userResponse) of
 'c' : createAcct();
 'd' : makeDeposit(); { writeln('     Depositing.....' ); }
 'w' : makeWithdrawal();
 'b' : checkBalance();
 'i' : checkAcctDetails();
 'x' : exit_prog();
 'about' :   writeln('Created by Tasiu Kwaplong June 2019. kindly give me a star on github on: www.github.com/tasiukwaplong/virtualbank');

 else
 writeln('[ERROR]     You did not make a valid selection. try again' );
 displayMenu();
 end; {end of switch block}

end; { end of procedure displayMenu }

procedure createAcct;
(* Creates a new virtual bank account *)
var
tempFullName, tempPhone, tempAccType: string;

begin
	{ check if account has already been created }
	if fullName <> '' then writeln('[ERROR]     Account already created');
	if fullName <> '' then displayMenu();


	 writeln('[INFO]     Type your full name:');
	 readln(tempFullName);
	 writeln('[INFO]     Type your phone number:');
	 readln(tempPhone);
	 writeln('[INFO]     Select account type:');
	 writeln('     1 V-Intant (balance of 500 - 200,000)');
	 writeln('     2 V-Classic (balance of 500 - 1,000,000)');
	 writeln('     3 V-Pro (balance of 500 - 50, 000, 000)');
	 writeln('     4 V-Biz (balance of 500 - max)');
	 readln(tempAccType);
 	 writeln('[INFO]     Enter password:');
	 readln(password);


 case (tempAccType) of
 '1' : tempAccType := 'V-Intant' ;
 '2' : tempAccType := 'V-Classic' ;
 '3' : tempAccType := 'V-Pro' ;
 '4' : tempAccType := 'V-Biz' ;
 else
 writeln('[ERROR]     You did not make a valid selection. try again' );
 displayMenu();
 end; {end of switch block}

 fullName := tempFullName;
 accType := tempAccType;
 phone := tempPhone;
clrscr;
 writeln('');
 writeln('[INFO]     Account created successfully...!!!');
 writeln('     Account name: ', tempFullName, '     Account Type: ', accType);
 writeln('     Phone number: ', phone, '     Acct Balance: ', round(acctBalance));
  writeln('');  writeln('');  writeln('');  writeln('');  writeln('');
 displayMenu();

end; { end of procedure createAcct }

procedure makeDeposit;
	(* Makes deposit to account*)

	var
	depositAmt, tempAccBal : real; 
	begin
	 if fullName = '' then writeln('[ERROR]     Deposit not possible, create account first');
	 if fullName = '' then displayMenu();
	 
	 depositAmt := 0;
	 writeln('[INFO]     Current Account balance: ', round(acctBalance));
	 writeln('[INFO]     Please enter amount to deposit');
	 readln(depositAmt);
	 {condiion to check if a number is entered will come here}
	  tempAccBal := acctBalance + depositAmt;
	 { check for V-Intant account }
	 if isDepositable(accType, tempAccBal) then writeln(accType, ' does not support balance of up to ', round(tempAccBal), '. Pls upgrade your plan');
	 if isDepositable(accType, tempAccBal) then displayMenu();
	 clrscr;
	 acctBalance := acctBalance + depositAmt;
	 writeln('[INFO]     Making deposit, please wait.......');
	 writeln('[INFO]     Deposit successful. New balance: ', round(acctBalance));

	 displayMenu();
end; { end of procedure createAcct }

procedure makeWithdrawal;
	(* Makes deposit to account*)

	var
	withdrawalAmt, newAcctBalance : real;
	enteredPassword:string;

	begin
	if fullName = '' then writeln('[ERROR]     withdrawal not possible, create account first');
	if acctBalance <= 0  then writeln('[ERROR]     Please fund your account');
	if fullName = '' then displayMenu();

	writeln('[INFO]     Enter password:');
	readln(enteredPassword);

	if enteredPassword <> password then writeln('Wrong password enetered. Enter w to try again');
	if enteredPassword <> password then displayMenu();
	 
	 withdrawalAmt := 0;
	 writeln('[INFO]     Current account balance: ', round(acctBalance));
	 writeln('[INFO]     Please enter amount to Withdraw');
	 readln(withdrawalAmt);
	 {condiion to check if a number is entered will come here}

	 newAcctBalance := acctBalance - withdrawalAmt;
	 writeln('     Making withdrawal, please wait.......');

	if newAcctBalance < 500 then writeln('[ERROR]     Invalid withdrawal operation. Minimum account balance for ',accType,' plan is: 500. Please try again');
	if newAcctBalance >= 500 then acctBalance := newAcctBalance;


	writeln('[INFO]     New account balance: ', round(acctBalance));
	displayMenu();

end; { end of procedure makewithdrawal }

procedure checkBalance;
	(* Check account balance*)

	begin
	clrscr;
	if fullName = '' then writeln('[ERROR]     Balance does not exist, create account first');
	if fullName = '' then displayMenu();
	 writeln('     Current account balance: ', round(acctBalance));
	 displayMenu();
end; { end of procedure checkBlance }

procedure checkAcctDetails;
	(* Check account balance*)

	begin
	clrscr;
	if fullName = '' then writeln('[ERROR]     No account exist, create an account first');
	if fullName = '' then displayMenu();

	 writeln('[INFO]     Displaying account details..... ');
	 writeln('     Account name: ', fullName, '      Account Type: ', accType);
	 writeln('     Phone number: ', phone, '     Acct Balance: ', round(acctBalance));

	 case (accType) of
		 'V-Intant' : writeln('You are on V-Intant plan. Maximum account balance is 200, 000');
		 'V-Classic' : writeln('You are on V-Classic plan. Maximum account balance is 1, 000, 000'); 
		 'V-Pro' : writeln('You are on V-Pro plan. Maximum account balance is 50, 000, 000');
		 'V-Biz' : writeln('You are on V-Biz plan. No limit to account balance')
	else
		 writeln('[ERROR]     No account created. Kindly enter "c" to create a new account' );
		 displayMenu();
	 end; {end of switch block}

	 writeln('');writeln('');writeln('');writeln('');writeln('');
	 displayMenu();
end; { end of procedure checkAcctDetails }

procedure exit_prog;
	{ exit program }
	 begin
	 clrscr;
	  writeln('Thanks for using this software. kindly give me a star on github on:');
	  writeln('www.github.com/tasiukwaplong/virtualbank');
	  exit;
end;

begin
	clrscr;
 fullName := '';
 accType := '';
 acctBalance := 0;
 displayMenu();
end.