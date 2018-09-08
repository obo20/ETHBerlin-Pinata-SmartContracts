pragma solidity ^0.4.24;

contract ExampleContract {
  
  event ExampleEvent(
    string _hash
  );
  
  function registerAsContract(string _hash) public returns (bool) {
    emit ExampleEvent (_hash);
    return true;
  }
}
