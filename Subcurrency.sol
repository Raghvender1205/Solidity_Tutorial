// This creates a simple form of cryptocurrency
// Its contract allows users to create new coins 
// With a ethereum key pair, anyone can send coins

pragma solidity >=0.5.0 <0.8.0;

contract Coin{
    // Address type is a 160 bit value that does'nt allow any arithmetic operations.
    address public minter; // var is accessible to all other contracts
    mapping (address => uint) public balances; 

    // Events allows clients to react to specific contract changes which are declared
    event Sent(address from, address to, uint amount);

    //Constructor code only runs when the contract is created
    constructor() public{
        minter = msg.sender;
    }

    // Sends an amount of the new coin to an address 
    // Can only be called by the Contract Creater
    function mint(address reciver, uint amount) public{
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[msg.sender] -= amount;
        balances[reciver] += amount;
    }

    // Sends an amount of exisiting coins 
    // from any caller to an address
    function send(address reciever, uint amount) public{
        require(amount <= balances[msg.sender], "Insufficient Balance");
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Sent(msg.sender, reciever, amount);
    }
}