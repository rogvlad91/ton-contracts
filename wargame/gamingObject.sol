
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import 'interfaceGamingObject.sol';

contract gamingObject is interfaceGamingObject {
    uint32 public timestamp;
    uint public HP;
    address public callerAddress;
    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}
    function getHP() public virtual returns(uint) {
        tvm.accept();
        return HP;
    }
    
    function getAttack(uint damage) external override{
        tvm.accept();
        callerAddress = msg.sender;
        HP = HP - damage;
    }
    
    function checkIfDead() private returns (bool){  
        tvm.accept();
        if (HP == 0) {
            return true;
        }
    }
    function deathAHAHAH() public virtual checkOwnerAndAccept{

        self_suicide();
    }
    function self_suicide() private{
         tvm.accept();
        callerAddress.transfer(1, true, 160);
    }
    function addWarUnit(address warUnitAddress) external virtual{}
    function deleteWarUnit(address warUnitAddress) external virtual{}
}