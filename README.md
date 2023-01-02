# Dealicious
![1](https://user-images.githubusercontent.com/100062754/210193715-13fa02af-8ce1-4ec9-bd70-c5a0c290f1ac.gif)
![2](https://user-images.githubusercontent.com/100062754/210193716-e71c2363-52c7-4819-a16a-1f3eaf766f9d.gif)
![3](https://user-images.githubusercontent.com/100062754/210193718-8a447d4f-8dc1-46a6-b66f-2e72913d1acd.gif)



## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Demo](#Demo)
4. [Schema](#Schema)

## Overview
### Description
Application allow users to input information regarding various deals in their neighborhood. Users can then view other crowdsourced information and proceed to vote and comment on each item.

### App Evaluation
- **Category:** Social/Lifestyle/Sharing/Finance
- **Mobile:** Our app is optimally used in a mobile setting where users are actively on the move. Users are not simply limited to mobile use as they can preplan their shopping before leaving the house. We will use camera functions, and gps location tracking to assist with our app.
- **Story:** Our app was developed to help ease the economic pains that are endured during their shopping experience. Considering todays economic climate, we wanted to create an app that would help stretch their dollar further. Fighting inflation one user at a time.

- **Market:** The potential userbase for IOS Deals is anybody who steps into the grocery store. The idea environment for our app would be highly populated cities, where we can have a higher number of users that would be willing to populate our data. Our core market would be money concious shoppers.

- **Habit:** We expect that the majority of users would not be willing to post or engage with the app. To encourage users to post IOS Deals rewards users who contribute to the system by awarding them with a point system which can lead badges, or coupons they can redeem. Or cold hard cash. 

- **Scope:** The base application with the required stories should engage the audience and appear to be feasible to implement within a constrained period of time. The additional optional stories may take extensive research to evaluate implementation strategies and will be prioritized if time allows.

## Product Spec

### 1. User Stories

**Required Must-have Stories**
1. Users have accounts and can log into them
2. Users can post deals with price and store location
3. Users choose to see all stores near them or all deals near them 


**Optional Nice-to-have Stories**
1. Users can add image to their profile 
2. Users are rewarded with point system 
3. Users can post a picture with their deal 
4. Users can press into the store, or deals to find more details about it.

### 2. Screen Archetypes

* Login Screen
   * Users have accounts/can create counts and can log into them
* Stores Stream
   * User can view all stores near them
   * User can click store to find more details
* Deals Stream
    * User can view all deals near them
    * User can click deal to find more details
* Store's Deals Stream
    * User can view deals in a specific store
* Deal Detail
    * User can view specific deal details
* Deal Creation
    * User can post a deal

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stores Feed (Stores Stream)
* Deals Feed (Deals Stream)
* Add a deal (Deal Creation)

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Either Deals Stream or Stores stream
* Deals Stream
   * Stores Stream
   * Deal Creation
   * Deal Detail
* Stores Stream
    * Deals Stream
    * Store's Deals Stream
    * Deal Creation
* Store's Deals Stream
    * Deal Detail
    * Deal Creation
* Deal Detail
    * Store's Deals Stream
    * Deals Stream
* Deal Creation
    * Stores Stream
    * Deals Stream
    * Store's Deals Stream
## Demo
### Interactive Prototype
<img src="https://slack-imgs.com/?c=1&o1=ro&url=http%3A%2F%2Fg.recordit.co%2FQ0eK0uqFdZ.gif" width=600><br>

## Schema 
### Models

User
| Property | Type | Description |
| -------- | -------- | -------- |
| username     | String     | Unique Username Set by User     |
| password     | String     |  Password set by User    |
| userImage     | URL     |   Profile Picture   |


Deals Posts
| Property | Type | Description |
| -------- | -------- | -------- |
| product |  String    | Name of product/deal     |
| author     | Pointer to user    |  User that submitted deal    |
| dealDescription     | String     |   A description of the deal   |
| date     | DateTime     |   When the user posts the deal   |
| expirationDate     | DateTime     |   When the deal expires (optional)   |
| dealPrice     | Float     |   Price of deal   |
| normalPrice     | Float     |   Price of non deal price (optional)   |
| dealPhoto     | URL     |   Photo of deal being posted (optional)  |
| brand     | String     |   Brand of deal (optional)   |
| Store     | String     |  name of store from dropdown   |


### Networking
**List of network requests by screen**
* Login Screen
   * (Create/POST) create new account
   * (Read/GET) login
* Deals Stream
   * (Read/GET) query all nearby deals based on location of user
* Stores Stream
    * (Read/GET) query all nearby stores based on location of user
* Store's Deals Stream
    * (Read/GET) query all deals in specific store
* Deal Detail
    * (Read/GET) get details on deal
* Deal Creation
    * (Create/POST) create new deal
    * (Delete) delete deal (maybe?)

