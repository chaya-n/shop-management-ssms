# shop_management

Recrutiment task for SSMS



## Getting Started

The method for authentication if only using an email and a password. Email must be of valid format 
and the password must be of 6 characters atleast.

I have used FirsebaseAuth and Firestore for this project.

There are 3 admin accounts. The Username and password for each are

1) adminone@gmail.com 123456
2) admintwo@gmail.com testtest
3) adminthree@gmail.com 098765

new admin accounts cannot be created through app, only through the firestore console.

Admin can add,delete and modify the products. Please be mindful of the names given to the products
they should not be repeated. Also, 'Example' and 'Example ' are considered different.

_**Users**_
 There is one user already, chayanhjain@gmail.com chayan (credentials). New users can be registered.
The Forgot password button does not work, since I didnt have time to implement it.
Each page for the users has a refresh button,slide your fingers from top to bottom to refresh (like
in google chrome).
In the explore page, search works but be mindful of the difference between 'Example' and 'Example '.
The categories tabs do not work, again since I couldnt finish it on time.