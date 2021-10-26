# Smart wallet #
The wallet has 3 options:
1. The transaction in which tax is included into transaction value (i.e. you send 1 dollar, the tax is 0.1 dollar, person receives 0.9 dollars)
2. The transaction in which tax is excluded out of value (i.e. you send 1 dollar and pay 1.1 dollar, because the tax is 0.1 dollar, and person receives 1 dollar)
3. The transaction of all money in your wallet, after which wallet is destroyed
#### Error codes: ####
101 - *the public key of contract is not set*

102 - *the message is not signed at all, or the message has the key that differs from the owner public key*
