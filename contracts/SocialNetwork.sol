pragma solidity ^0.4.24;

contract SocialNetwork {

  event UserAdded(
    uint user_id
  );

  event TextPost(
    uint indexed user_id,
    string image_hash
  );

  event ImagePost(
    uint indexed user_id,
    string image_hash
  );
  
  function addImage(uint user_id, string image_hash) public returns (bool) {
    emit ImagePost(user_id, image_hash);
    return true;
  }
}
