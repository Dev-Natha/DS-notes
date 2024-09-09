import mysql.connector as connection
from getpass import getpass
import hashlib
import random
import string


mycon = connection.connect(host='127.0.0.1', user='root', passwd='kudiratu1961@',database='')
mycursor = mycon.cursor()


# def create_tables():
#         # mycursor.execute("CREATE DATABASE BANKAPP")
#         mycursor.execute("USE BANKAPP")
#         mycursor.execute('''
#             CREATE TABLE IF NOT EXISTS banks (
#                 id INT PRIMARY KEY AUTO_INCREMENT,
#                 name VARCHAR(255) UNIQUE NOT NULL
#             );
#             CREATE TABLE IF NOT EXISTS accounts (
#                 id INT PRIMARY KEY AUTO_INCREMENT,
#                 bank_id INT,
#                 account_number VARCHAR(20) UNIQUE NOT NULL,
#                 balance DECIMAL(10, 2) DEFAULT 0,
#                 pin VARCHAR(255) NOT NULL,
#                 FOREIGN KEY (bank_id) REFERENCES banks(id)
#             );
#             CREATE TABLE IF NOT EXISTS transactions (
#                 id INT PRIMARY KEY AUTO_INCREMENT,
#                 account_id INT,
#                 amount DECIMAL(10, 2) NOT NULL,
#                 transaction_type ENUM('deposit', 'withdrawal', 'transfer'),
#                 timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#                 FOREIGN KEY (account_id) REFERENCES accounts(id)
#             );
#             CREATE TABLE IF NOT EXISTS categories (
#                 id INT PRIMARY KEY AUTO_INCREMENT,
#                 name VARCHAR(255) UNIQUE NOT NULL
#             );
#             CREATE TABLE IF NOT EXISTS products (
#                 id INT PRIMARY KEY AUTO_INCREMENT,
#                 category_id INT,
#                 name VARCHAR(255) NOT NULL,
#                 price DECIMAL(10, 2) NOT NULL,
#                 quantity INT NOT NULL,
#                 FOREIGN KEY (category_id) REFERENCES categories(id)
#             );
#         ''')


#BANK AVAILABLE
# def populate_banks():
#     mycursor.execute("USE BANKAPP")
#     bank_names = ["Bank of America", "Chase", "Wells Fargo"]
#     mycursor.execute("SELECT COUNT(*) FROM banks")
#     if mycursor.fetchone()[0] == 0:
#             for bank_name in bank_names:
#                 mycursor.execute("INSERT INTO banks (name) VALUES (%s)", (bank_name,))
#             mycon.commit()


# populate_banks()



#MAIN MENU

def main_menu():
    while True:
        print("\nMain Menu:")
        print("1. Bank App")
        print("2. Shopping Mall App")  # Include this option if you have a shopping mall app
        print("3. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            bank_menu()
        elif choice == '2':
            shopping_menu()  # Call shopping_menu() if implemented
        elif choice == '3':
            break
        else:
            print("Invalid choice. Please try again.")


def bank_menu():
    while True:
        print("\nBanking App:")
        print("1. Register")
        print("2. Login")
        print("3. Back to Main Menu")

        choice = input("Enter your choice: ")

        if choice == '1':
            register()
        elif choice == '2':
            login()
        elif choice == '3':
            break
        else:
            print("Invalid choice. Please try again.")
    



    
def register():
    print("\nBank Registration:")

    while True:
            mycursor.execute("USE BANKAPP")
            mycursor.execute("SELECT name FROM banks")
            banks = mycursor.fetchall()
            if banks:
                print("Available Banks:")
                for i, bank in enumerate(banks):
                    print(f"{i+1}. {bank[0]}")

                while True:
                    try:
                        bank_choice = int(input("Enter the number of the bank you want to register with (or '0' to go back): "))
                        if bank_choice == 0:
                            return  # Go back to the previous menu
                        elif 1 <= bank_choice <= len(banks):
                            bank_id = banks[bank_choice - 1][0]  # Get the bank ID from the list
                            break
                        else:
                            print("Invalid bank choice. Please try again.")
                    except ValueError:
                        print("Invalid input. Please enter a number.")

                while True:
                    account_number = ''.join(random.choices(string.digits, k=10))
                    mycursor.execute("SELECT * FROM accounts WHERE account_number = %s", (account_number,))
                    existing_account = mycursor.fetchone()
                    if not existing_account:
                        break

                while True:
                    pin = input("Enter a 4-digit PIN: ")
                    if len(pin) == 4 and pin.isdigit():
                        confirm_pin = getpass("Confirm your PIN: ")
                        if pin == confirm_pin:
                            break
                        else:
                            print("PINs do not match. Please try again.")
                    else:
                        print("PIN must be 4 digits. Please try again.")
                hashed_pin = hashlib.sha256(pin.encode()).hexdigest()

                mycursor.execute("INSERT INTO accounts (bank_id, account_number, pin) VALUES (%s, %s, %s)", (bank_id, account_number, hashed_pin))
                mycon.commit()
                print(f"Registration successful! Your account number is: {account_number}")
                return  # Exit the registration function after successful registration
            else:
                print("No banks available. Please contact the administrator.")

def login():
    print("\nBank Login:")

    while True:
        account_number = input("Enter your account number (or '0' to go back): ")
        if account_number == '0':
            return

        pin = input("Enter your PIN: ")
        hashed_pin = hashlib.sha256(pin.encode()).hexdigest()
        mycursor.execute("USE BANKAPP")
        mycursor.execute("SELECT * FROM accounts WHERE account_number = %s", (account_number,))
        account = mycursor.fetchone()

        if account and account[4] == hashed_pin:  # Check hashed PIN
            print("Login successful!")
            account_menu(account)  # Call the account_menu function with the logged-in account details
            return  # Exit the login function after successful login
        else:
            print("Invalid account number or PIN.")


def account_menu(account):
    while True:
        print("\nAccount Menu:")
        print("1. Deposit")
        print("2. Withdraw")
        print("3. Transfer")
        print("4. Check Balance")
        print("5. Logout")

        choice = input("Enter your choice: ")

        if choice == '1':
            deposit(account)
        elif choice == '2':
            withdraw(account)
        elif choice == '3':
            transfer(account)
        elif choice == '4':
            check_balance(account)
        elif choice == '5':
            break
        else:
            print("Invalid choice. Please try again.")


def deposit(account):
    while True:
        try:
            amount = float(input("Enter amount to deposit: "))
            if amount > 0:
                    mycursor.execute("USE BANKAPP")
                    mycursor.execute("UPDATE accounts SET balance = balance + %s WHERE id = %s", (amount, account[0]))
                    mycursor.execute("INSERT INTO transactions (account_id, amount, transaction_type) VALUES (%s, %s, 'deposit')", (account[0], amount))
                    mycon.commit()
                    print("Deposit successful. New balance:", check_balance(account))
                    break
            else:
                print("Invalid amount. Please enter a positive number.")
        except ValueError:
            print("Invalid input. Please enter a number.")

def withdraw(account):
    while True:
        try:
            amount = float(input("Enter amount to withdraw: "))
            if 0 < amount <= account[3]:  # Check if sufficient balance
                mycursor.execute("USE BANKAPP")
                mycursor.execute("UPDATE accounts SET balance = balance - %s WHERE id = %s", (amount, account[0]))
                mycursor.execute("INSERT INTO transactions (account_id, amount, transaction_type) VALUES (%s, %s, 'withdrawal')", (account[0], amount))
                mycon.commit()
                print("Withdrawal successful. New balance:", check_balance(account))
                break
            else:
                print("Invalid amount or insufficient balance.")
        except ValueError:
            print("Invalid input. Please enter a number.")

def transfer(account):
    while True:
        try:
            recipient_account_number = input("Enter recipient's account number: ")
            amount = float(input("Enter amount to transfer: "))
            if 0 < amount <= account[3]:
                    mycursor.execute("USE BANKAPP")
                    mycursor.execute("SELECT * FROM accounts WHERE account_number = %s", (recipient_account_number,))
                    recipient = mycursor.fetchone()
                    if recipient:
                        mycursor.execute("UPDATE accounts SET balance = balance - %s WHERE id = %s", (amount, account[0]))
                        mycursor.execute("UPDATE accounts SET balance = balance + %s WHERE id = %s", (amount, recipient[0]))
                        mycursor.execute("INSERT INTO transactions (account_id, amount, transaction_type) VALUES (%s, %s, 'transfer')", (account[0], amount))
                        mycon.commit()
                        print("Transfer successful.")
                        break
                    else:
                        print("Recipient account not found.")
            else:
                print("Invalid amount or insufficient balance.")
        except ValueError:
            print("Invalid input. Please enter a number.")

def check_balance(account):
    print(account[3])



# Shopping app menu
def shopping_menu():
    while True:
        print("\nShopping Mall App:")
        print("1. Register")
        print("2. Login")
        print("3. Browse Categories")  # Added this option
        print("4. View Cart")
        print("5. Checkout")
        print("6. Back to Main Menu")

        choice = input("Enter your choice: ")

        if choice == '1':
            shopping_register()
        elif choice == '2':
            shopping_login()
        elif choice == '3':
            browse_categories()  # Assuming you have this function defined
        elif choice == '4':
            view_cart()
        elif choice == '5':
            checkout()
        elif choice == '6':
            break
        else:
            print("Invalid choice. Please try again.")

def shopping_register():
    print("\nShopping App Registration:")

    while True:
        username = input("Enter your desired username: ")
        password = input("Enter a password: ")
        confirm_password = getpass("Confirm your password: ")

        if password != confirm_password:
            print("Passwords do not match. Please try again.")
            continue

        hashed_password = hashlib.sha256(password.encode()).hexdigest()


        try:
                mycursor.execute("USE SHOP")
                mycursor.execute("INSERT INTO shopping_users (username, password) VALUES (%s, %s)", (username, hashed_password))
                mycon.commit()
                print("Registration successful!")
                return  # Exit the function after successful registration
        except connection.errors.IntegrityError:
                print("Username already taken. Please choose a different one.")

def shopping_login():
    print("\nShopping App Login:")

    while True:
        username = input("Enter your username (or '0' to go back): ")
        if username == '0':
            return

        password = input("Enter your password: ")
        hashed_password = hashlib.sha256(password.encode()).hexdigest()
        mycursor.execute("USE SHOP")

        mycursor.execute("SELECT * FROM shopping_users WHERE username = %s", (username,))
        user = mycursor.fetchone()

        if user and user[2] == hashed_password:  # Check hashed password
            print("Login successful!")
            return user  # Return the user details upon successful login
        else:
            print("Invalid username or password.")


def browse_categories():
        mycursor.execute("USE bankapp")
    
        mycursor.execute("SELECT * FROM categories")
        categories = mycursor.fetchall()

        if categories:
            print("Available Categories:")
            for i, category in enumerate(categories, 1):
                print(f"{i}. {category[1]}")

            while True:
                try:
                    category_choice = int(input("Enter category number to browse or 0 to go back: "))
                    if category_choice == 0:
                        return
                    elif 1 <= category_choice <= len(categories):
                        selected_category_id = categories[category_choice - 1][0]
                        browse_products(selected_category_id)
                        break  # Exit the loop after browsing products in the selected category
                    else:
                        print("Invalid category choice. Please try again.")
                except ValueError:
                    print("Invalid input. Please enter a number.")
        else:
            print("No categories available.")



if __name__ == '__main__':
    
    main_menu()