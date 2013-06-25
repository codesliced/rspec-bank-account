require "rspec"

require_relative "account"

describe Account do
  let(:account) {Account.new("3243242311")}
  let(:account_with_money) {Account.new("3243242311", 2)}

  describe "#initialize" do
    it "with 1 argument" do
      expect{account}.to_not raise_error(ArgumentError)
    end

    it "requires one argument" do
      expect{Account.new}.to raise_error(ArgumentError)
    end

    it "accepts 2 arguments" do
      expect {Account.new("3243242311", 4)}.to_not raise_error(ArgumentError)
    end

    it "account number argument should be a string of numbers" do
      expect {Account.new("no money")}.to raise_error(InvalidAccountNumberError)
    end

      it "starting_balance argument should be a number" do
        expect(Account.new("3243242311", "no money").balance).to_not eq(0)
      end
  end

  describe "transactions" do

    describe "#deposit!" do
      it "should not accept a negative number for deposit" do
       expect{account_with_money.deposit!(-2)}.to raise_error(NegativeDepositError)
      end

      it "deposits should increase the account balance" do
        account_with_money.deposit!(5)
        expect(account_with_money.balance).to eq(7)
      end

      it "should be a number" do
        expect {account_with_money.deposit!("7")}.to raise_error
      end
    end

    describe "#withdraw!" do
      it "show lower account balance" do
        account_with_money.withdraw!(1)
        expect(account_with_money.balance).to eq(1)
      end

      it "amount should be a positive number" do
        expect{account_with_money.withdraw!(-5)}.to raise_error(OverdraftError)
      end

      it "amount cannot let balance go below 0" do
        expect{account_with_money.withdraw!(100)}.to raise_error(OverdraftError)
      end
    end


  end

  describe "#balance" do
    it "should show funds in account" do
      expect(account_with_money.balance).to eq(2)
    end

    it "should be a number" do
      expect(account_with_money.balance).to_not eq(nil)
    end
  end

  describe "#account_number" do
    it "should hide the first 6 digits" do
      expect(account.acct_number).to eq("******2311")
    end

    it "should not show the full account number" do
      expect(account.acct_number).to_not eq("3243242311")
    end
  end


end
