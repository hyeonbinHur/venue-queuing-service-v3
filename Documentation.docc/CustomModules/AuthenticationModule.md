# Authentication Module

The authentication module allows for users to login and signup their accounts and they can setup a customer account or a restaurant account.

## Overview

The authentication module contains a few sub-modules or components, such as the `LoginView()` and `SignUpView()`. The login module allows existing users to login using an email and password via the **Firebase Authentication** integration and the signup module allows customers and restaurants to enter their details and create a new account to register themselves for future logins.

### LoginView

The login view is the first screen and the user can enter an `email` address and `password` to sign into the application.

From here they can either login or they can choose to signup and create a new account.

![login page view](loginview)

### SignupView

The signup view contains a few more fields as it's required to store these user data details. Here they can select either to be a venue or not. If they choose to select a venue then they will also need to complete restaurant details on the next step.

![signup page](signupview)
