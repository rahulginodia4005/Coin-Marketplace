pragma solidity >=0.4.22;
import './Tether.sol';

contract CoinC {
    string public name = 'CoinC';
    string public symbol = 'C';
    address public owner;
    uint totalCoins = 1000000;
    Tether public tether;
    address public own_address;


    mapping(address => uint) public coinBalance;
    mapping(address => uint) public valueBalance;
    mapping(address => bool) public hasInvested;

    constructor(Tether _tether) public  {
        tether = _tether;
        coinBalance[msg.sender] = totalCoins;
        owner = msg.sender;
        own_address = address(this);

    }
    
    address [] public bidders;

    function buyCoins(address investor, uint coins, uint value) public returns (bool success) {
        require(coins > 0, 'you cannot buy zero coins');
        require(coinBalance[msg.sender] >= coins, 'number of coins exceeds the total supply');
        uint totalAmount = value*coins;

        tether.transferFrom(investor, msg.sender , totalAmount);

        coinBalance[msg.sender] -= coins;
        coinBalance[investor] += coins;
        valueBalance[investor] += totalAmount;
        if(!hasInvested[investor]){
            hasInvested[investor] = true;
            bidders.push(investor);
        }
        return true;
        
    }

    function sellCoins(address investor, uint coins, uint value) public returns (bool success) {
        require(coins > 0, 'you cannot sell zero coins');
        require(coinBalance[investor] >= coins, 'insufficient coin balance');
        uint totalAmount = coins*value;

        tether.transferFrom(msg.sender,investor, totalAmount);

        coinBalance[investor] -= coins;
        coinBalance[msg.sender] += coins;
        valueBalance[investor] -= totalAmount;
        if(coinBalance[investor] == 0){
            for(uint i = 0;i<bidders.length;i++){
                if(bidders[i]==investor){
                    delete bidders[i];
                    break;
                }
            }
            hasInvested[investor] = false;
        } 
        return true;
    }



}