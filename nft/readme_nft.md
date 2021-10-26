# NFT Music Smart Contract #
### This contract is the nft which are in my case various songs.

**The contract can:** 
1. Add songs. The songs have their owner, name, band, rating.
2. Get token owner. Returns song owner public key 
3. Get token info. Returns song name, band and rating
4. Put song up for a sale. This action can be made only by the owner. The owner sets the price of the song
5. Change price. Only the owner can change price
6. Change rating. Only the owner can change rating
7. Change song owner, for example give someone the song you possess as a gift. Only can be done by the owner.
#### Error codes: ####
101 - *the message is not signed at all, or the message has the key that differs from the owner public key*

102 - *there is already the song of this name and band*

103 - *the rating is set higher than 10*

