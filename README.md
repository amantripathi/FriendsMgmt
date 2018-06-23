# FriendsMgmt
This is a API based project for doing features like "Friend", "Unfriend", "Block", "Receive Updates" etc.

# This project is totally API based build in Rails 5.2.0

BASE_URL = https://desolate-sands-76509.herokuapp.com


1. For Friendship
  ```
  endpoints: api/relationship
  Method: POST
  request: { friends: [ 'andy@example.com', 'john@example.com' ] }
  ```

2. Get Friend list
  endpoint: /api/relationship/friend_list
  Method: GET
  request: { email: 'andy@example.com' }

3. Common Friend
  endpoints: /api/relationship/common_friends
  Method: GET
  request: { friends: [ 'andy@example.com', 'john@example.com' ] } 

4. Subscribe for updates
  endpoint: /api/subscription
  Method: POST
  request: { "requestor": "lisa@example.com", "target": "john@example.com" }

5. Block Updates
  endpoints: /api/subscription/block
  Method: POST
  request: { "requestor": "andy@example.com", "target": "john@example.com" } 

6. Retrieve email for updates
  endpoint: /api/subscription/reciever
  Method: POST
  request: { "sender": "john@example.com", "text": "Hello World! kate@example.com" } 
