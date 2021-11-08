pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;

import 'Structs.sol';

contract Todo {
   
    modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }

    mapping (uint32=>purchase) purchaseMapping;
    uint256 m_ownerPubkey;
    uint32 purchaseId;

    constructor( uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }

    function getShoppingStat() public view returns (shoppingSummary summary){
        uint32 paidCount;
        uint32 unpaidCount;
        uint32 sum;
        for ((, purchase purchase) : purchaseMapping){
            if (purchase.isBought == true) {
                paidCount++;
                sum += purchase.priceForAll;
            } else{
                unpaidCount++;
            }
        }
        summary = shoppingSummary(paidCount, unpaidCount, sum);
    }

    function getShoppingList() public view returns (purchase[] purchasesArray){
        tvm.accept();
        for (uint32 i; i <= purchaseId; i++){
            purchasesArray.push(purchaseMapping[i]);
        }
    }

    function addPurchase(string name, uint32 number) public onlyOwner {
        tvm.accept();
        purchaseId++;
        purchaseMapping[purchaseId] = purchase(purchaseId, name, number, now, false, 0);
    }

    function deletePurchase(uint32 purchaseID) public onlyOwner {
        tvm.accept();
        require(purchaseMapping.exists(purchaseID), 102);
        delete purchaseMapping[purchaseID];
    }

    function buy(uint32 purchaseID, uint32 priceForAll) public onlyOwner{
        tvm.accept();
        require(purchaseMapping.exists(purchaseID), 102);
        purchaseMapping[purchaseID].isBought = true;
        purchaseMapping[purchaseID].priceForAll = priceForAll;
    }

}

