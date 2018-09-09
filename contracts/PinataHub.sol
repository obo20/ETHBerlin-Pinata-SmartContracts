pragma solidity ^0.4.24;

contract PinataHub {

  mapping(address => string) registeredClientsMapping;
  mapping(address => string) registeredContractsMapping;

  mapping(address => address[]) clientWatchedContracts;
  mapping(address => mapping(address => bool)) clientToContractCheck;
  mapping(address => mapping( address => uint256)) clientContractBalance;
  
  constructor() public {
        
  }

  event ContractAddedClient(
    address indexed _contract,
    address indexed _client,
    string configHash
  );
  
  function registerContractToClient(address _client, address _contract, string _configHash) public returns (bool) {
    clientToContractCheck[_client][_contract] = true;
    clientWatchedContracts[_client].push(_contract);
    emit ContractAddedClient(_contract, _client, _configHash);
    return true;
  }
  
  function getClientWatchedContractsArray(address _client) public view returns (address[]) {
      return clientWatchedContracts[_client]; 
  }
  
  event ClientContractFunded(
    address indexed _contract,
    address indexed _client,
    uint256 paymentAmount
  );
  
  function fundContractToClient(address _contract, address _client) public payable returns (uint256) {
      uint256 balance = clientContractBalance[_client][_contract];
      balance = balance + msg.value;
      clientContractBalance[_client][_contract] = balance;
      emit ClientContractFunded(_contract, _client, msg.value);
      return balance;
  }
  
  function getContractToClientBalance(address _contract, address _client) public view returns (uint256) {
      return clientContractBalance[_client][_contract];
  }
 
  function withdrawContractToClientFunds(address _contract) public returns (bool) {
      uint balance = clientContractBalance[msg.sender][_contract];
      require(balance > 0);
      msg.sender.transfer(balance);
      return true;
  }
  
  //methods for assigning names to clients / contracts if desired
  event ClientRegistered(
    address indexed _client,
    string _name
  );

  //we allow people to rename themselves if they want
  function registerAsClient(string _clientName) public returns (bool) {
    registeredClientsMapping[msg.sender] = _clientName;
    emit ClientRegistered(msg.sender, _clientName);
    return true;
  }
  
  function getClientName(address _client) public view returns (string) {
      return registeredClientsMapping[_client];
  }
  
  event ContractRegistered(
    address indexed _contract,
    string _name
  );
  
  //we allow people to rename themselves if they want
  function registerAsContract(string _contractName) public returns (bool) {
    registeredContractsMapping[msg.sender] = _contractName;
    emit ContractRegistered(msg.sender, _contractName);
    return true;
  }
  
  function getContractName(address _contract) public view returns (string) {
      return registeredContractsMapping[_contract];
  }
}
