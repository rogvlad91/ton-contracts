pragma ton-solidity >=0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "../Debot.sol";
import "../Terminal.sol";
import "../Menu.sol";
import "../AddressInput.sol";
import "../ConfirmInput.sol";
import "../Upgradable.sol";
import "../Sdk.sol";
import 'HasConstructorWithPubKey.sol';
import 'Interfaces.sol';
import 'Structs.sol';
import 'shoppingList.sol';
import 'ADebotListInit.sol';


contract fillingShoppingListDebot is ADebotListInit  {
    string purchaseName;
    function setStat(shoppingSummary stat) public override {
        m_stat = stat;
        _menu();
    }

    function _menu() internal override {
        string sep = '----------------------------------------';
        Menu.select(
            format(
                "You have {}/{} paid purchaces/unpaid purchaces for {} total sum ",
                    m_stat.paidCount,
                    m_stat.unpaidCount,
                    m_stat.sum
            ),
            sep,
            [
                MenuItem("Add new purchase","",tvm.functionId(addPurchaseToReadName)),
                MenuItem("Show shopping list","",tvm.functionId(getShoppingList)),
                MenuItem("Delete purchase","",tvm.functionId(deletePurchase))
            ]
        );
    }

    function addPurchaseToReadName(uint32 index) public {
        index = index;
        Terminal.input(tvm.functionId(addPurchaseToReadNumber), "Enter purchase name:", false);
    }

    function addPurchaseToReadNumber(string name) public {
        purchaseName = name;
        Terminal.input(tvm.functionId(addPurchase_), "Enter number of items:", false);
    }

    function addPurchase_(string number) public view {
        (uint256 num,) = stoi(number);
        uint32 numOfItems = uint32(num);
        optional(uint256) pubkey = 0;
        IShoppingList(m_address).addPurchase{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(purchaseName, numOfItems);
    }

    function getShoppingList(uint32 index) public view {
        index = index;
        optional(uint256) none;
        IShoppingList(m_address).getShoppingList{
            abiVer: 2,
            extMsg: true,
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(getShoppingList_),
            onErrorId: 0
        }();
    }

    function getShoppingList_( purchase[] purchasesArray ) public {
        uint32 i;
        if (purchasesArray.length > 0 ) {
            Terminal.print(0, "Your shopping list:");
            for (i = 0; i < purchasesArray.length; i++) {
                purchase Purchase = purchasesArray[i];
                string bought;
                if (Purchase.isBought) {
                    bought = '✓';
                } else {
                    bought = ' ';
                }
                Terminal.print(0, format("{} {}  {} {}  at {}", Purchase.id, bought, Purchase.number, Purchase.name, Purchase.createdAt));
            }
        } else {
            Terminal.print(0, "Your shopping list is empty");
        }
        _menu();
    }

    function deletePurchase(uint32 index) public {
        index = index;
        if (m_stat.paidCount + m_stat.unpaidCount > 0) {
            Terminal.input(tvm.functionId(deletePurchase_), "Enter purchase number:", false);
        } else {
            Terminal.print(0, "Sorry, you have no purchases to delete");
            _menu();
        }
    }

    function deletePurchase_(string value) public view {
        (uint256 num,) = stoi(value);
        optional(uint256) pubkey = 0;
        IShoppingList(m_address).deletePurchase{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(uint32(num));
    }
}