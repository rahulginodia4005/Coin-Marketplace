pragma solidity >=0.4.22;

contract Tether {
    string public name = 'Tether';
    string public symbol = 'USDT';
    uint public totalSupply = 10000000000000000000000000; //1 million usdt
    uint public decimal = 18;

    event Approval(
        address _from,
        address _to,
        uint amount
    );

    event Transfer(
        address _from,
        address _to,
        uint amount
    );

    
    mapping(address => mapping(address => uint)) public allowance;
    mapping(address => uint) public balanceOf;

    constructor() public {
        balanceOf[msg.sender] = totalSupply;

    }


    function approve(address coin, uint amount) public returns (bool success) {
        allowance[msg.sender][coin] = amount;
        emit Approval(msg.sender, coin, amount);
        return true;

    }

    function transfer(address _to, uint amount) public returns (bool success) {
        require(balanceOf[msg.sender] >= amount,'hhhhhhlllll');
        balanceOf[msg.sender] -= amount;
        balanceOf[_to] += amount;
        emit Transfer(msg.sender, _to, amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint amount) public returns (bool success) {
        require(allowance[_from][_to] >= amount);
        require(balanceOf[_from] >= amount);
        balanceOf[_from] -= amount;
        balanceOf[_to] += amount;
        allowance[_from][_to] -= amount;
        emit Transfer(_from, _to, amount);
        return true;
    }

}